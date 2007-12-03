From: "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH] Reorder msgfmt command-line arguments.
Date: Mon, 3 Dec 2007 17:04:02 +0000
Message-ID: <20071203170402.GA13712@crustytoothpaste.ath.cx>
References: <20071203012631.GA22450@crustytoothpaste.ath.cx> <Pine.LNX.4.64.0712031034200.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 18:04:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzEic-0002eH-NJ
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 18:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbXLCREK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 12:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbXLCREJ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 12:04:09 -0500
Received: from mknod.org ([209.223.236.42]:39446 "EHLO mknod.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbXLCREH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 12:04:07 -0500
Received: from crustytoothpaste.ath.cx (c-98-197-197-167.hsd1.tx.comcast.net [98.197.197.167])
	by mknod.org (Postfix) with ESMTP id 2DF37218002;
	Mon,  3 Dec 2007 11:04:05 -0600 (CST)
Received: from crustytoothpaste.ath.cx (lakeview.crustytoothpaste.ath.cx [172.16.2.249])
	(authenticated bits=0)
	by crustytoothpaste.ath.cx (8.14.2/8.14.2/Debian-2) with ESMTP id lB3H42Dc011756
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Dec 2007 17:04:04 GMT
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712031034200.27959@racer.site>
X-No-CC: If you CC me on this list, I will feed you to Branden Robinson.
X-Machine: Running on lakeview using GNU/Linux on x86 (Linux kernel
	2.6.24-rc3-amd64)
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66925>

On Mon, Dec 03, 2007 at 10:35:33AM +0000, Johannes Schindelin wrote:
>On Mon, 3 Dec 2007, brian m. carlson wrote:
>
>> Any program using getopt or getopt_long will stop processing options 
>> once a non-option argument has been encountered, if POSIXLY_CORRECT is 
>> set.
>
>So have you tested that msgfmt indeed does not work with the present 
>command line?

Yes.  I run with POSIXLY_CORRECT set to 1, and it does indeed break.  I 
wouldn't have fixed it if it had worked.

There are parts of the git testsuite that hang in this case, too, but I 
have yet to examine them.  Rest assured that there are indeed patches 
coming, assuming the problems are fixable.

>Besides, you probably want to send this as a git-gui patch: based on 
>git-gui.git, not git.git, and Cc'ed to Shawn Pearce.

Thanks.  Will do.

-- 
brian m. carlson / brian with sandals: Houston, Texas, US
+1 713 440 7475 | http://crustytoothpaste.ath.cx/~bmc | My opinion only
a typesetting engine: http://crustytoothpaste.ath.cx/~bmc/code/thwack
OpenPGP: RSA v4 4096b 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187
