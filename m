From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 20:00:41 +0530
Message-ID: <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
	 <vpqskf8z0rj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 31 16:31:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi7uU-0000eE-MC
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 16:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbZHaOam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 10:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbZHaOal
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 10:30:41 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:50351 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbZHaOaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 10:30:39 -0400
Received: by iwn42 with SMTP id 42so1828427iwn.33
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=jaUsoicwC5PLpg/olJ/MJIBn58GnWQmAQSJp59VCblE=;
        b=W/W94DfKFrY6JQPUUBuSyxhK/PufGtbWIfYi7qIUbutG9CqhVq0qLs4i925+vB6T8W
         kuv1nG/hTHM5kAKb4QGu62eTMvrY3iBVYS+v7Fkvgp+mvCqfxNCwAiIbAufZQBoeefQb
         UHZ33x0/aymB9TCexNhF48DT52QD1Mxamx7K4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=trPCuS4dShPkPNecp+tTtOuzuiU7u8AZBcy7uzN48ElYmfPkfl9+1X5znDyOwyDmtp
         m15V5Uvp+ST53uii1xtipVAQSaBtZ1s/bvjPNVvPG8/wP8qQbmurDg8gsVP4fqqGqRr/
         g9S0sRdBQovvIf5G5qG4xYNJ236WxO709tgnA=
Received: by 10.231.124.164 with SMTP id u36mr7183379ibr.21.1251729041741; 
	Mon, 31 Aug 2009 07:30:41 -0700 (PDT)
In-Reply-To: <vpqskf8z0rj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127484>

[apologies if you get this twice]

On Mon, Aug 31, 2009 at 4:52 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
> > Hello,
> >
> > Cloning an empty repo seems to produce a spurious error.
> > The repo still seems fine though.
>
> Can't reproduce here:
>
> $ git clone ssh://.../tmp/empty cloned
> Initialized empty Git repository in /tmp/cloned/.git/
> warning: You appear to have cloned an empty repository.
> $ git --version
> git version 1.6.4.187.gd399.dirty
>
> Maybe you have an older version of Git?

Had 1.6.4, just tried with 1.6.4.2 -- the error is still there, exactly so.

Anything I can do to provide more info?

To start with, this is Mandriva 2009.1, kernel 2.6.29, git built from
scratch locally (not an RPM or something).  Should I try some other
things like strace?  It's too minor to bother, if that's all it is,
assuming it's not a symptom of something larger :)


>
> --
> Matthieu
