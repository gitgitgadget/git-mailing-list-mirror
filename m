From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [BUG?] Re: fail to svn clone debian's kernel repository
Date: Tue, 2 Mar 2010 20:54:54 +0100
Message-ID: <20100302195454.GB12942@vidovic>
References: <20090610160524.GA24435@pengutronix.de> <4B8B21A8.6000603@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 20:55:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmYBV-0004ME-F4
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 20:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab0CBTzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Mar 2010 14:55:07 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45971 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab0CBTzF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 14:55:05 -0500
Received: by vws9 with SMTP id 9so234868vws.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 11:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8GSj+l8pIs81Jlv2MO17AwkPUJ87yuXS1Qbk92eM8Ec=;
        b=etq4jF/9OpFqrBIbohJ09mmnkP17ylI076fsTLylBz+6BjjZjSLkg7W7Xi05puXG3z
         oDhA7RVxLBQeDD0qnw17SR4LkKXXW5WuEBl5SZxe0SasU2o9iPiutT2MB5VWscKxlhbW
         v5uEhk1ol73Xx72AY61GdciekkBmAmwCwBvOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cstZfEMu83HkZus842k4H6GXi1q6yyWbyaftz0GVzXbCXloyfCQjll/+8yv6OXjtjN
         5BuTQFbaIcpDy8veGHNWSeGRrgVlM0PCDZLM3LWns7vtYypUW1gZL0IW/fsjknzlurKg
         +HoPFAuiv4ROZwaK9+/zuHstcRg0d77qoWQPQ=
Received: by 10.220.48.143 with SMTP id r15mr3231340vcf.95.1267559700884;
        Tue, 02 Mar 2010 11:55:00 -0800 (PST)
Received: from @ (91-164-132-214.rev.libertysurf.net [91.164.132.214])
        by mx.google.com with ESMTPS id 27sm38646000vws.7.2010.03.02.11.54.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 11:54:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B8B21A8.6000603@hartwork.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141412>

The 01/03/10, Sebastian Pipping wrote:
> On 06/10/09 18:05, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > using git v1.6.3.1 from Debian I fail to successfully run
> >=20
> > 	git svn clone svn://svn.debian.org/kernel/dists/trunk/linux-2.6
> >=20
> > It runs for some time and then ends in:
> >=20
> > 	...
> > 	r4695 =3D f552d98386b301cbeaa3b5a20f9e9d5d3c9c4886 (git-svn)
> > 		M	debian/arch/alpha/defines
> > 	r4696 =3D 18c0a37de057d24955b66e8f49db0791f6018288 (git-svn)

<...>

> > 	Invalid filesystem path syntax: Cannot replace a directory from wi=
thin at /usr/lib/git-core/git-svn line 4388
>=20
> I have run into a similar problem, both with Git 1.7.0 as well as wit=
h
> Git via Git.
>=20
> Has anybody been able to work around this?
> Is anybody working on a fix?

I've stopped cloning at r10252 with current next version. I didn't
notice any problem.

Does the tests pass for you ?

  $ cd t
  $ make

--=20
Nicolas Sebrecht
