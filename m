From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Mon, 26 Jul 2010 15:13:53 +0200
Message-ID: <201007261513.57045.jnareb@gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com> <AANLkTikx5EtQ0yvdkqN1Q1QAudFZfbd+_jpoa9ztLrz1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 26 15:14:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdNVW-0005Kx-7q
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 15:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab0GZNOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 09:14:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59229 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab0GZNOF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 09:14:05 -0400
Received: by fxm14 with SMTP id 14so83240fxm.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nfvMwY6B1mINjucDdQKjYCIkHi6VsR4aAeW8XRVsn3E=;
        b=eb92MVFkgoRwIs++WkQunzXQ8/OzAl0NSdadSCy+dCnMD/dx7+rtYpVUy31wvDwnMA
         RSmIVrOMpxBs50lVT/VuEUmDWFRazdPJm9B7/etPrSHyroGOjas+jjL4BcKRtL/+zHn3
         +9UowhPx/pary07BrKSLmVz/4Gk/ofPN8t4bU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IVxIHxiCjw31sfEgSbEV9a6/pT05aWmBK4jltBkUpeS9e1bElZC67hm5vSmv2w3XpF
         Gx28sSjqRQo04+1FEC4EdKC0x+EK6XDlAuBtKzGk285jbWxjnLegXAkBZWz++z07huIG
         KuVmp8gM5PfC+s5blkh2uxx88bY+nr0UNbDJo=
Received: by 10.223.113.65 with SMTP id z1mr6389535fap.38.1280150042971;
        Mon, 26 Jul 2010 06:14:02 -0700 (PDT)
Received: from [192.168.1.13] (abvc184.neoplus.adsl.tpnet.pl [83.8.200.184])
        by mx.google.com with ESMTPS id r8sm1378533faq.10.2010.07.26.06.13.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 06:14:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikx5EtQ0yvdkqN1Q1QAudFZfbd+_jpoa9ztLrz1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151834>

On Sat, Jul 24, 2010, skillzero@gmail.com wrote:
> On Fri, Jul 23, 2010 at 6:20 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> On Fri, Jul 23, 2010 at 8:58 PM, =C2=A0<skillzero@gmail.com> wrote:
>>> On Fri, Jul 23, 2010 at 3:50 PM, Avery Pennarun <apenwarr@gmail.com=
> wrote:

>> This is indeed a problem with large repositories. =C2=A0Of course,
>> splitting them with git-submodule is kind of cheating, because it ju=
st
>> makes git-status *not look* to see if those files are dirty or not.
>> If they are dirty and you forget to commit them, you'll never know
>> until someone tells you later. =C2=A0It would be functionally equiva=
lent to
>> just have git-status not look inside certain subdirs of a single
>> repository.
>=20
> I think it's only cheating if you're using all of the submodules. The
> main purpose of submodules for me (although I don't currently use
> submodules) would be so I don't need to keep modules on disk that I
> don't care about. If a developer is working on an app, they don't nee=
d
> the OS directories/modules so they get much faster git status/etc and
> there wouldn't be other directories to have dirty files in. [...]

There are two issues that make submodules or git-subtree a better
solution.  If you work with subprojects via upstream subproject=20
repository, and you don't always need / want all subprojects,=20
git-submodule is better.  If you always have checked out all subproject=
s,
and you edit them in superproject, git-subtree is better.
=20

--=20
Jakub Narebski
Poland
