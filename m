From: Tatsuhiko Miyagawa <miyagawa@gmail.com>
Subject: Re: gitweb, FastCGI and PSGI/Plack
Date: Mon, 10 May 2010 11:43:59 -0700
Message-ID: <AANLkTilXqAUs5-go-JHgTrQuslTyA1sZ3re5yuLtnxkz@mail.gmail.com>
References: <g2s693254b91005091428ib188cbd1le5ffa90eace741a8@mail.gmail.com>
	 <201005101232.32908.jnareb@gmail.com>
	 <AANLkTikH39rbm64sc0nn7eTBJSfxcqWpz6VXZBCQQIl3@mail.gmail.com>
	 <201005102040.36490.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Vereshagin <peter@vereshagin.org>,
	Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 20:44:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBXxa-0002Pp-TP
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 20:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669Ab0EJSoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 14:44:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56890 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab0EJSoB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 14:44:01 -0400
Received: by gyg13 with SMTP id 13so2143353gyg.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l/ug0exDeNQPi/WfJh8Fug3IWIBZRaPOS0L1Dw/gcW8=;
        b=EKQpwee4SubaHQVtCvSIc16aLKabkafCpW0JWpOy5tk7QNPdmyHz2LzwxouhDUssg0
         rQqEiPq8waESjlT3FICSWizl2YhDw4c9RYnxyq0SgpW+LvwthSgkfkGh2nljcAXsNpy8
         SLEk4F/2lUbbjVr3OXvn3airnQQlbyk4TgZiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qenJHnb9MaZDNZByKFbF+QlaUaLSwQ9spZa/8LFbfxNU451NTbVTRf82IHDxb4W/z5
         gTAuGxcZmCrUvZYCk208gSd+DYhOFqaXnaVjy85ItY9PenV/vv7ymEoqG+q8YVYV2/zE
         I5rtRxilMKm4RNi2si2MZtZ2bYACuPuv0CitE=
Received: by 10.101.6.18 with SMTP id j18mr518947ani.12.1273517039948; Mon, 10 
	May 2010 11:43:59 -0700 (PDT)
Received: by 10.100.228.6 with HTTP; Mon, 10 May 2010 11:43:59 -0700 (PDT)
In-Reply-To: <201005102040.36490.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146844>

On Mon, May 10, 2010 at 11:40 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> On Mon, 10 May 2010, Tatsuhiko Miyagawa wrote:

>> Yes, that makes sense - if implementing FastCGI is just switching CG=
I
>> to CGI::Fast and a while loop, implementing PSGI interface just for
>> that is far more complicated. I just argued about it because I saw o=
n
>> a separate thread that PSGI implementation is also on its way.
>
> What!? =A0No, currently there are no plans to add PSGI support to git=
web,
> nor moving gitweb from CGI (and mod_perl's ModPerl::Registry, and
> FastCGI now) to PSGI.
>
> This separate thread is about adding support for 'plackup' to
> git-instaweb (and perhaps also adding gitweb.psgi wrapper).

Yes, that's what i meant.

If you get plackup support by converting your CGI application into a
PSGI app, then adding support to FastCGI is just one command line
option away.


--=20
Tatsuhiko Miyagawa
