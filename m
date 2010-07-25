From: solsTiCe d'Hiver <solstice.dhiver@gmail.com>
Subject: Re: [bash-completion] syntax error near unexpected token '<' on
 line 123 in bash_completion.d/git
Date: Mon, 26 Jul 2010 00:19:28 +0200
Message-ID: <1280096368.7211.2.camel@soho.example.org>
References: <1280056320.7883.9.camel@soho.example.org>
	 <4C4C982C.20904@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 00:19:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od9Xn-00046x-9I
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 00:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab0GYWTe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 18:19:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64717 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab0GYWTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 18:19:33 -0400
Received: by wwj40 with SMTP id 40so6275256wwj.1
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=ceMYs0iXkdC0OpBDWWu51nWa2ce+wBrHzkVPeLTI8s4=;
        b=NGeW6Fmqi45lz6s7/5zcTTGV4VoHS4JoIe/1NRw8jZH5eMO2Dz1wTTcQb9L8drIxeo
         SziP5ULhlg6quLjxXphgMYMxMHheeCbrHtlDJ4W7sNWwtKCVGltZBI7FXBtUupDqTWSq
         Z5eWqYtpOQbNRvCdbiTFfPqnCkk9GlDknt0Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=whC0xqd1jCBfi7PdLOOEbuwXa6JeGsqNXF4WuXCAf8Cbg4EML6qKZtfr3HE/sp4qk3
         bQZz2uyyKns2dg/UaDg/e28mLNdHMpRJP3qkLmhZoEak6eaJN/6SI0T1Ewu8MGEeMCJQ
         2BK+8l+C9PaOp73lonj1ZeMlivVjoALE3SvFI=
Received: by 10.227.146.73 with SMTP id g9mr6453157wbv.188.1280096372133;
        Sun, 25 Jul 2010 15:19:32 -0700 (PDT)
Received: from [192.168.0.50] (ARennes-553-1-38-213.w86-214.abo.wanadoo.fr [86.214.125.213])
        by mx.google.com with ESMTPS id g37sm2472386wbg.3.2010.07.25.15.19.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 15:19:31 -0700 (PDT)
In-Reply-To: <4C4C982C.20904@pileofstuff.org>
X-Mailer: Evolution 2.30.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151796>

Le dimanche 25 juillet 2010 =C3=A0 21:01 +0100, Andrew Sayers a =C3=A9c=
rit :=20
> bash 4.1.5 always prepends "bash: "
> to such errors for me:
>=20
> $ while false ; do echo foo ; done < ;
> bash: syntax error near unexpected token `;'
>=20
bash 4.1.7 does that too here.

> If this is the complete error text, then I suspect you may have someh=
ow
> got bash completion in a non-bash shell.
>=20
the complete message is:
/etc/bash_completion.d/git: line 123: syntax error near unexpected toke=
n
'<'
/etc/bash_completion.d/git: line 123: done < <(git config -z
--get-regexp '^(svn-remote\..*\.url|bash > \.showupstream)$' 2>/dev/nul=
l
| tr '\0\n' '\n ')

> Could you add this on line 98 and let me know what it says:
> echo $BASH_VERSION $BASHOPTS

When I add the above command at line 98, it shows it is really bash
running:
4.1.7(2)-release
cmdhist:expand_aliases:extglob:extquote:force_fignore:interactive_comme=
nts:progcomp:promptvars:sourcepath=20
