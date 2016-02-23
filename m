From: Kevin Daudt <me@ikke.info>
Subject: Re: git diff HEAD^(255) fails
Date: Tue, 23 Feb 2016 21:58:07 +0100
Message-ID: <20160223205807.GA15324@ikke.info>
References: <CA+4vN7w2=JWusWDhhGNzAkJbE-s44G4WoXdvf26yzvtYfpktfQ@mail.gmail.com>
Reply-To: git@lists.ikke.info
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ole Tange <ole@tange.dk>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:58:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYK2A-0006jj-1E
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 21:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbcBWU6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 15:58:10 -0500
Received: from ikke.info ([178.21.113.177]:37241 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755162AbcBWU6J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 15:58:09 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id 71C79440082; Tue, 23 Feb 2016 21:58:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CA+4vN7w2=JWusWDhhGNzAkJbE-s44G4WoXdvf26yzvtYfpktfQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287117>

On Sat, Feb 06, 2016 at 10:56:46PM +0100, Ole Tange wrote:
> git diff first looks for a file, then looks if it is a reference to a
> revision. If the file fails due to being too long, the diff fails:
> 
> $ git init
> $ git diff 'HEAD^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
> HEAD
> fatal: failed to stat
> 'HEAD^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^':
> File name too long
> 
> If file name too long it should just try to see if it is a reference
> to a revision.
> 

Is there a reason you are repeating 255 "^" instead of using HEAD~255?
