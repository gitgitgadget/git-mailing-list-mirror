From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: [PATCH 2/2] show color hints based on state of the git tree
Date: Mon, 15 Oct 2012 15:20:01 +0200
Message-ID: <507C0D81.7030005@nieuwland.nl>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org> <20121005211030.GA5414@simaj.xs4all.nl> <507BC7F1.3080506@drmicha.warpmail.net> <507BD0EE.5000107@nieuwland.nl> <507BD3C1.4040807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	spearce@spearce.org, artagnon@gmail.com, schwab@linux-m68k.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 15:20:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNkal-0005iL-Jh
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 15:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab2JONUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 09:20:11 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:51400 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753325Ab2JONUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 09:20:11 -0400
Received: (qmail 13769 invoked by uid 453); 15 Oct 2012 13:20:02 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Mon, 15 Oct 2012 15:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <507BD3C1.4040807@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207746>

Hi Michael, sorry for the duplicate, forgot to reply-all...

On 10/15/2012 11:13 AM, Michael J Gruber wrote:

> ...only because you don't know the color coding scheme. It's green
> because those changes are saved somewhere (in the index) and would even
> survice a branch switch.
>

But git doesn't exactly let you do this:
I modified some things in git-prompt.sh trying to implement some of what 
we discussed. Then staged the file and tried git checkout HEAD^^ (or any 
branch)

error: Your local changes to the following files would be overwritten by 
checkout:
         contrib/completion/git-prompt.sh
Please, commit your changes or stash them before you can switch branches.
Aborting

So I don't think it's all that strange to mark the branch as not quite 
safe to change. The idea (or at least my idea) behind these hints is 
that it reminds me to do stuff that prevents these "Aborts". I think 
that that is a useful feature for any user of git.

In this light, would you accept yellow in the branch color to indicate 
uncommitted staged changes?

Cheers

Simon
