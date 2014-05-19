From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: Any difference to unstage files using "git checkout" and "git rm"
Date: Mon, 19 May 2014 21:27:47 +0630
Organization: CognitiveClouds
Message-ID: <2484900.5bGOI3HfEm@linux-wzza.site>
References: <6833494.47nikG189t@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 18:03:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmQ26-0003B2-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 18:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbaESQDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2014 12:03:18 -0400
Received: from nm24-vm4.bullet.mail.sg3.yahoo.com ([106.10.151.83]:21255 "EHLO
	nm24-vm4.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753122AbaESQDS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 12:03:18 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 May 2014 12:03:17 EDT
Received: from [106.10.166.120] by nm24.bullet.mail.sg3.yahoo.com with NNFMP; 19 May 2014 15:57:24 -0000
Received: from [106.10.167.141] by tm9.bullet.mail.sg3.yahoo.com with NNFMP; 19 May 2014 15:57:24 -0000
Received: from [127.0.0.1] by smtp114.mail.sg3.yahoo.com with NNFMP; 19 May 2014 15:57:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1400515044; bh=tCBT8WDInUbt1Mwe4LF8h6ss8RbuL6JitpqZ/j5dKdY=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=Aw3qel9HHjUEzWkALf62Ej6XBHMd6vrDCFO3CuWtGpb5K5NQFTHsxqf1enHJ3nfGuxRz/yNFskA3gQiTA7w3ojvBW5H558FEhnQ7x210d/+Qx1rZv50HVYSwqYo4TCbswiWzppI1uGBCipP0gQFD4kZD0zC4PpTEtkeYqaEjsyk=
X-Yahoo-Newman-Id: 219415.2082.bm@smtp114.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: iShf7gwVM1nCOGdOaVpWvHX1i5uY49Alu.EymhhN7Cr_ySM
 QbACBgTAquqcX53l5dUwXLhBz_0To5t.lUHUEUEjjAmxHs2LPbP_K0Uvv77h
 Wo_eQoFskbHWzmH_gvdKDilydb6Vib9ao6PjGyU1.4_NW6dTIL2GR5RrztSF
 QdVGdRtfO8Z2idGF0mV7ufDB8L7NqjlEYDO6gZcc7JiEBIyXEFum7Wv.0HYZ
 k8RThvZ.VdU29u8dNavOH4lEzxu7gaI9.DA5_I3LMvoBm7O7xLxdhrmMs4fm
 GI3F3klPja1UZY4U7RsqFA9swMwoqyUa_HsVQMPFJu0oXpgd4fLPY4tNtXLA
 u0SqmDl4hUw7viUeAm_1ToewAYdQlVB6XwR6yXJlkPGWIyLiU4bzwbRV9kKM
 Jmjy2Mq4pxQPTzEGr8m4X1phTIhTjPUuGHLssCS.yZ.1oz3vezlPvpk8pTvU
 QO878njsrzZymxN4P.lPzVFf6jaIP9rJzm74tbprTCdbHx11tehh9ZFxC6J7
 6Zzigx9sgqY3WMggnmEHFoxNfdKsxEv1gXg7NoeiWXmMDWDgv0KCpDr.VqUt
 WMw--
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@117.254.174.115 with plain [106.10.150.171])
        by smtp114.mail.sg3.yahoo.com with SMTP; 19 May 2014 08:57:24 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-7-default; KDE/4.11.5; i686; ; )
In-Reply-To: <6833494.47nikG189t@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249594>

On Monday, May 19, 2014 09:12:47 PM you wrote:
> Hi,
>=20
> Is there any difference between the below 2 commands ? I didn't see
> anything.
>=20
> git rm --cached  -- <file1> .. <fileN>
> git checkout  -- <file1> .. <fileN>

Please Ignore the previous.

I apologize to rewriting and increase the load of this mailing list. I=20
actually wanted to ask the below=20

git rm -- cached  -- <file1> .. <fileN>
git reset HEAD  <file1> .. <fileN>=EF=BB=BF

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Regards,
Arup Rakshit
