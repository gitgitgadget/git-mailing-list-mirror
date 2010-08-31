From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git strangeness
Date: Tue, 31 Aug 2010 00:55:00 -0700 (PDT)
Message-ID: <m3bp8jnrnh.fsf@localhost.localdomain>
References: <AANLkTikrJ+hizEicws8PZAry-WOzOYoXAEW9b1L8OYcR@mail.gmail.com>
	<AANLkTim27gLuAwxrNZFmayufF3ctKDU5vmUSN4v4bQPY@mail.gmail.com>
	<AANLkTi=JQ0rAYmAz=uJc5riZC+UwxhEvsXCvzQ6310O8@mail.gmail.com>
	<AANLkTinwK0R4BGUn_ehBOvO7HrwUZZ6Va3okoiu=eu7P@mail.gmail.com>
	<AANLkTina6iVO4Ekv1gVOoBFTV3t1F55sqEkwvf-Rrm_6@mail.gmail.com>
	<AANLkTinPizD8JECut5Yc2pgzne4=QL6arcHiG8iUUcKB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>,
	Perl5 Porteros <perl5-porters@perl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 09:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqLi4-0000yG-TH
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 09:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905Ab0HaHzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 03:55:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49515 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897Ab0HaHzC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 03:55:02 -0400
Received: by fxm13 with SMTP id 13so3752771fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 00:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=NgjYBx27LChObUC1dd246yPohXlG/3as0V/5IXYUz04=;
        b=iY1WlXuF+ad1we5VgbjRZwTRrFeZdzuITT/iDXVpcO7U7G+GgbMDj3CZsBiDCEXP/C
         7dkU35WzZE7UGoOyv0epG/cf27e9AHC0ypyQ+Z5KL13huG4A2UaR3XY0jYSXQ6mlYqog
         oqdZCon7mIcsl9t+HsHLm+uxsmvO5UvGta7hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=io4RnLZ5mXe6B1YD4G6MqdxAPD2qMStFF5fDqZQ4O2yLEmcgUHedc/1eDfSE/rthmz
         eNZ72iTUA54iKhWQ6uYlCNWQgSCoHKXqUDlC+sR1DlIC4Rx/tIQQHbQrzKB3BO/4tyit
         /JPSJvopDgrgeI8/tXD3osI0sFBYsGn10p2HE=
Received: by 10.223.116.3 with SMTP id k3mr4941714faq.81.1283241301363;
        Tue, 31 Aug 2010 00:55:01 -0700 (PDT)
Received: from localhost.localdomain (abws159.neoplus.adsl.tpnet.pl [83.8.242.159])
        by mx.google.com with ESMTPS id t6sm3821434faa.27.2010.08.31.00.54.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 00:55:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7V7sxar017394;
	Tue, 31 Aug 2010 09:55:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7V7shcl017383;
	Tue, 31 Aug 2010 09:54:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinPizD8JECut5Yc2pgzne4=QL6arcHiG8iUUcKB@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154886>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Aug 23, 2010 at 19:58, demerphq <demerphq@gmail.com> wrote:

> > Select "pickaxe" in the drop down on the perl5 gitweb, and then sea=
rch
> > for PERL_STRLEN_ROUNDUP
> >
> > The url generated is:
> >
> > http://perl5.git.perl.org/perl.git?a=3Dsearch&h=3DHEAD&st=3Dpickaxe=
&s=3DPERL_STRLEN_ROUNDUP
> >
> > Currently its running for me, and obviously wed prefer that we dont
> > have N-gazillion people doing the search at once....
> >
> > Ah, it just finished... Same problem. I get the error:
> >
> > XML Parsing Error: no element found
> > Location: http://perl5.git.perl.org/perl.git?a=3Dsearch&h=3DHEAD&st=
=3Dpickaxe&s=3DPERL_STRLEN_ROUNDUP
> > Line Number 81, Column 1:
> >
> > And the last couple of lines of the HTML are:
> >
> > </td>
> > <td class=3D"link"><a
> > href=3D"/perl.git/commit/7a9b70e91d2c0aa19f8cec5b0f8c133492a19280">=
commit</a>
> > | <a href=3D"/perl.git/tree/7a9b70e91d2c0aa19f8cec5b0f8c133492a1928=
0">tree</a></td>
> > </tr>
> > <tr class=3D"light">
> >
> > seems to me like it timed out while searching....
> >
> > Makes me think the search logic would work better as an incremental
> > asynchronous fetch....
>=20
> Ah, sounds like it's running a really expensive operation and then
> running into the cgi time execution limit on the webserver (or maybe
> in gitweb), so when the connection closes the browser ends up with
> invalid XHTML.
>=20
> An async fetch would only make sense in that case if your gitweb and
> webserver timeouts made sense, i.e. the gitweb timeout was say 1-2 se=
c
> less than the webserver timeout.

Ah, modern gitweb supports incremental blame, in that it seeds the
view with file contents, then runs "git blame --incremental" in
background on server and updates 'blame_incremental' view with
JavaScript, but does not support incremental pickaxe.  Perhaps we
could borrow code from git-browser?

By the way, gitweb should have caching real soon now (TM)... :-)
--=20
Jakub Narebski
Poland
ShadeHawk on #git
