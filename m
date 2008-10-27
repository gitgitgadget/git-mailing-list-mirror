From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 15:07:32 -0500
Message-ID: <b6jwksWkldU6N726dbI3k3yYE6WL1aXJERb9Oh1lNd8g5zdTavgRew@cipher.nrlssc.navy.mil>
References: <ge0rla$mce$1@ger.gmane.org> <200810261955.10536.jnareb@gmail.com> <200810270147.52490.arne_bab@web.de> <200810270252.23392.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Arne Babenhauserheide <arne_bab@web.de>, mercurial@selenic.com,
	SLONIK.AZ@gmail.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 21:09:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuYOk-0007Qz-Lm
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 21:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYJ0UHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbYJ0UHx
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 16:07:53 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56089 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbYJ0UHw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 16:07:52 -0400
Received: by mail.nrlssc.navy.mil id m9RK7W7o008009; Mon, 27 Oct 2008 15:07:33 -0500
In-Reply-To: <200810270252.23392.jnareb@gmail.com>
X-OriginalArrivalTime: 27 Oct 2008 20:07:33.0049 (UTC) FILETIME=[A5C5AA90:01C9386F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99262>

Jakub Narebski wrote:
> On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
>> Also, looking at git, git users still have to garbage collect regularly, which 
>> shows to me that the design wasn't really cleaner. 
> 
> Well, they have to a lot less than they used to, and there is 
> "git gc --auto" that can be put in crontab safely.

I think you missed the most convincing argument _for_ explicit garbage collection.

By allowing explicit repository packing, git allows you to delay a cpu intensive
operation til later, when time doesn't matter, like at the end of the day right
before I go home. It also allows more cpu intensive delta/compression algorithms
to be used.

By contrast, mercurial performs deltafication and compression on each commit.
So, acceptable commit speed must be weighed against the complexity of the
deltafication/compression algorithm and file format.

-brandon
