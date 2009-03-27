From: "Etienne Vallette d'Osia" <dohzya@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 14:47:59 +0100
Message-ID: <49CCD90F.6090707@gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <37fcd2780903270524y39456c5fre0a2f8f9c5f4d160@mail.gmail.com> <49CCE520.17260.2586E134@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 14:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCRS-00069j-DI
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 14:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbZC0NsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 09:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbZC0NsH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:48:07 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:63493 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbZC0NsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 09:48:05 -0400
Received: by bwz17 with SMTP id 17so1006334bwz.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=0sYUGwU2dEotdNFqKfETaI+RPZA/geYC9BMOVPpdlfQ=;
        b=am/d697gJALbNBTdAiJkbFQPOsbjh1G9OyBIrJoV+7rx4EnQapuiGyne2cB4gIcAwB
         xd4E7HtSGvXY20GqBp9Rdx7Iwwqqa8maIBvGm00W2BWIVFojd7P/nkg5sx5TCtpnRBnH
         cU72Lr2K3tDX51OsUrQvu33Ytgy8S70yIqKlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=P70uGq4rTMUV6zQSP6LENW8PYOR4GZiZrex/rBN8fzIxloluS9KsL0jjLRTjpMMGA1
         S1eGewtMKt6IgR7D9NrxLM9JZqbq97Drvf+NeyY88NCXBxpNsYHj2RVZV0AUpIFBIfpn
         vw2axHBfmJzS0XLaUBiGQNmpMV6StLvSjVSLw=
Received: by 10.103.137.12 with SMTP id p12mr442166mun.94.1238161682013;
        Fri, 27 Mar 2009 06:48:02 -0700 (PDT)
Received: from schubby.inria.fr (schubby.inria.fr [138.96.218.89])
        by mx.google.com with ESMTPS id e8sm3095315muf.48.2009.03.27.06.48.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 06:48:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <49CCE520.17260.2586E134@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114890>

Ulrich Windl a =E9crit :
> AFAIK, "committing" in git is "kind of publishing your work" (others =
may pull it).=20
> I don't like publishing my mistakes ;-) Even if no-one pulls the comm=
it, your=20
> "undo" refers to "committing a fix for the last committed mistake", r=
ight? Again,=20
> I don't really want to document/archive (i.e. commit) my mistake. Or =
did I miss=20
> something here?
> I know: Other's opinions are quite different on these issues.

commit is local.
The good way is to commit in your local and private repository.
Then you can do anything, reset commit you have just done, etc
When all is ok, you push in a public repository.

With this workflow, no one see your local work and you can commit very=20
often, undo commit, rebase a lot etc.

The only result of a such job is a large number of useless objects in=20
your local repository. They will be delete automatically by git, so it'=
s=20
not a problem.

Regard,
Etienne
