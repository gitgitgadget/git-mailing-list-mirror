From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t7400.24 git submodule 'update --init' test fails on some
 machines
Date: Wed, 17 Feb 2010 04:23:16 -0600
Message-ID: <20100217102315.GA6364@progeny.tock>
References: <20100213090544.GA29850@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 11:23:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhh3s-0004FU-Kd
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 11:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab0BQKXL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 05:23:11 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:62941 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab0BQKXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 05:23:09 -0500
Received: by iwn15 with SMTP id 15so6178886iwn.19
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BpPCCG2R5wCwxh94RqNAjzwBz1mIoSRNlepKf8vLfv8=;
        b=gMz4tTQxwARbKfv12PvDxDJPov1iNL6qL1EbzR1RH6mDmRlO9+USWcjFkMXWepOel2
         IrByrJjNWTCCa+ZnOlMZP0RFzYd6uHM8JMsVHYX+zuSzcu6tdj8zvoVCeXZCaRnegavT
         5u8wH/D7eFGcMwlwrW/Dt0hkIPaCWCw+0YszI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=X2ymlwT3ljE+rWjPB9u1jJ661GKQxqZ2woDP1UVDwHKK2K8MSxdvs/D7KtCwupnWGZ
         knqlkFwDp2rjq48wM+MpcmFz+GplD52TwxEqLLylVOCKCiitcbXcYSRrHk2C4miXGWyJ
         /OaGi+B3sKFu/USJRhGxMs2cM6aiYroFyj78A=
Received: by 10.231.169.71 with SMTP id x7mr3839005iby.18.1266402185819;
        Wed, 17 Feb 2010 02:23:05 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2285280iwn.3.2010.02.17.02.23.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 02:23:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100213090544.GA29850@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140227>

Jonathan Nieder wrote:
> Some machines I don=E2=80=99t have access to have been hitting a test=
 failure
> when building git 1.6.6.2 and 1.7.0-rc2.  I am looking for ideas.
>=20
> The failed test is #24 from t7400-submodule-basic.sh:
>=20
>  test_expect_success 'update --init' '

Looks like it was an infrastructure problem of some kind.  I still
haven=E2=80=99t figured it out what changed, but all the affected platf=
orms
dealt fine with 1.7.0.  There was no need to bother you.

So sorry for the noise,
Jonathan
https://buildd.debian.org/status/package.php?p=3Dgit-core - build logs
