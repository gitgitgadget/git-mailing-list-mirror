From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: vc in emacs problem with git
Date: Thu, 27 Aug 2009 21:44:33 +0530
Message-ID: <f46c52560908270914o7027dc0bo873544dc0687cc48@mail.gmail.com>
References: <f46c52560908270828o574c0de6s17189a7326a1376d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: help-gnu-emacs@gnu.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 18:14:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MghcY-0004dg-79
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 18:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbZH0QOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 12:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbZH0QOc
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 12:14:32 -0400
Received: from mail-px0-f174.google.com ([209.85.216.174]:44731 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbZH0QOb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 12:14:31 -0400
Received: by pxi4 with SMTP id 4so1235832pxi.21
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=AcWp8P8zay8/G6az1H6bn195SnCmPlbECJClo28YXXQ=;
        b=C1+XpLGIZ6xhQV2wxRtzVKVllHA7h4z/xFAkaruJlgAUr8lg1je7xfjMADoEQ10/89
         0+87OYGzVrXbPuNQWYLSGs8duDfzE7iws8W4euvwZqH0L5FWdmblIi1gbg1g3sgn+nEt
         AgvtOPl04xN5OubJ7FU7kJ0PsF54rXOTMIRbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=u18A8ZPs6gGwsN4mwxv1FRdbd4NHlte2rlMIwxHBZffhFZcAy5ZKHnQgIosx/bc++i
         GpkX0DQjdnjMRFKPnvIAWREbV4cLNcJ7MkgyqU+6SlvIn7cGvaZaHWE+eHrIF5aZp4x/
         O9Irvu1Gn2Xr7U63Ub5Pkmsu0blyhEeDZpGf8=
Received: by 10.115.133.7 with SMTP id k7mr11926744wan.96.1251389673614; Thu, 
	27 Aug 2009 09:14:33 -0700 (PDT)
In-Reply-To: <f46c52560908270828o574c0de6s17189a7326a1376d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127167>

Just updating my own question:
when I do a C-x v v (vc-next-action)
which is supposed to be the most basic operation for checking in a file=
 I get

 Wrong type argument: stringp, nil

So vc can be assumed to be a broken I guess?

On Thu, Aug 27, 2009 at 8:58 PM, Rustom Mody<rustompmody@gmail.com> wro=
te:
> This is emacs 23 using the new 'updated-for-modern-dvcs' vc
> I see a mode line saying (note the colon)
> Git:master
>
> In the info on vc (Version control and the mode line) the emacs manua=
l says:
>
> =A0 The character between the back-end name and the revision ID
> indicates the version control status of the file.=A0 `-' means that t=
he
> work file is not locked (if locking is in use), or not modified (if
> locking is not in use).=A0 `:' indicates that the file is locked, or =
that
> it is modified.
>
> However at the shell a git status says
> # On branch master
> nothing to commit (working directory clean)
>
> If I close and reopen the file the colon becomes a -
> But I get a message:
>
> `working-revision' not found: using the old `workfile-version' instea=
d.
>
