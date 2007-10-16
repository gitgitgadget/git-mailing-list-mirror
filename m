From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: should git command and git-command be equivalent?
Date: Tue, 16 Oct 2007 22:28:28 +1000
Message-ID: <ee77f5c20710160528k520704d7pd3cf99dea1f83a77@mail.gmail.com>
References: <20071016084800.270917E6F@mail.kooxoo.com>
	 <vpqk5pnmoah.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: franky <yinping@kooxoo.com>, git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 16 14:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhlXQ-0002f1-O4
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 14:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403AbXJPM2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 08:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757367AbXJPM2a
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 08:28:30 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:2717 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583AbXJPM23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 08:28:29 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1410099rvb
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 05:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eaLoZV77w8nmGjjzVzOQ4Av8n25x8EqofLkVPbmiJQw=;
        b=MVC4fr6W8KSOZ0Op09BhApC9MpWcCyBvvSub2NdoykV7jDF8lZIBr2gAb6ujSYfZqVjHzzQyhMKjiQUlzxZI7SHtgkDzAKeloScqjG4SyjlcQSC4ES2ba24lCfuFDrdFDokaTIwilc4Exm+baYnGyJbKgV/Hbw/RU2jpc0Zr62k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=upumgd/Iq5kqHoJENGnslvxpfTbZldpMGFsG47IseURDXF2M3AMEB2bE2zU9UOff9wHTPcPuDXzQ3YQDSqwxVCAExhN3cYhjby/IB/tEwVKEwYQufyIrPftmLHsiJM0S6h3OWHk9Ex+u7fZcW7ZGBofaA/8HQC6+tmVA7EZx5gU=
Received: by 10.140.199.19 with SMTP id w19mr3444031rvf.1192537708114;
        Tue, 16 Oct 2007 05:28:28 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Tue, 16 Oct 2007 05:28:28 -0700 (PDT)
In-Reply-To: <vpqk5pnmoah.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61152>

On 16/10/2007, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> "franky" <yinping@kooxoo.com> writes:
>
> >> Also, you can use aliases (for example, I type "git st" to do "git
> >> status") with "git whatever", but not with "git-whatever" (unless you
> >> define the alias in your shell).
> > I try "git st", but it complains "git: 'st' is not a git-command".
>
> Sure, I'm talking about aliases, so what I meant is that I had
>
> [alias]
>         st = status
>
> in ~/.gitconfig.

If you use the contrib/completion/git-completion.bash script, you can
type "git st<TAB>", and it'll complete it for you. Well, it did, until
git-stash came along and ruined it...

At any rate, the bash completion also completes things like branch
names, which can be immensely helpful.


Dave.
