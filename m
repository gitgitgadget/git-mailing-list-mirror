From: sylvain@demarque.qc.ca
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 13:59:10 -0400
Message-ID: <20091012135910.ujqifycf9cwsk4ss@webmail.demarque.qc.ca>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 20:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPFb-0001D1-IE
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716AbZJLR7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 13:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbZJLR7y
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 13:59:54 -0400
Received: from secure01.megaquebec.net ([199.202.64.88]:36407 "EHLO
	mqplesk1l.megaquebec.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbZJLR7x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 13:59:53 -0400
Received: (qmail 19558 invoked by uid 48); 12 Oct 2009 13:59:10 -0400
Received: from modemcable009.10-130-66.mc.videotron.ca
	(modemcable009.10-130-66.mc.videotron.ca [66.130.10.9]) by
	webmail.demarque.qc.ca (Horde MIME library) with HTTP; Mon, 12 Oct 2009
	13:59:10 -0400
In-Reply-To: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130039>

Hello there. I know I was being goofy, but here is the real down to  
earth question :

Is there a known bug/feature that prevents Git from being used at "/"?  
It seems that there is a problem either at "git init" or "git add"  
when the repository is located at "/.git". (Git 1.6.4.4, see example  
below)

Thank you!

Quoting sylvain@demarque.qc.ca:

> Git is good, Git is great! All praise the Git! :-D
>
> What do you people think about this strange phenomena?
>
> localhost / # git --version
> git version 1.6.4.4
>
> localhost / # git init
> Initialized empty Git repository in //.git/
>
> localhost / # cd etc
> localhost etc # git add X11/xorg.conf
> fatal: pathspec 'etc/X11/xorg.conf' did not match any files
>
> Aside from the obvious question of why would I want to Git the whole
> tree ("But all files deserve the Holy Presence of the Git!"), why does
> Git refuse the love offering from "/etc/X11/xorg.conf"? Is it because
> it contains font directory configurations?
>
> Commit and [ENTER] to all,
>
> S! :-)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
