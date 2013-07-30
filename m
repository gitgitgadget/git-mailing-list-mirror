From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Specify UK English for the documentation source files.
Date: Tue, 30 Jul 2013 17:52:28 +0200
Message-ID: <20130730155228.GB19369@paksenarrion.iveqy.com>
References: <51F7D2FA.7020208@xiplink.com>
 <1375197114-10742-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 17:50:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4CBW-0006P6-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 17:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453Ab3G3Pt6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 11:49:58 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:62055 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab3G3Pt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 11:49:57 -0400
Received: by mail-lb0-f170.google.com with SMTP id r10so1065988lbi.15
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OQPwPJG06j10mO/sNENGPHDHOrailviWmanCDfsJh3g=;
        b=k0LXIx/TbXD/vmGQlJMG/VFpyYN1o7wLpSWo+vPFBMjH2nuIQblmOnLLgW5EeMtXju
         zS7jvMX63s+eLNKMHIG83PWHWFPue5qleXJ1DZmTAnlQS6uPRL3h7zpAcO5Yj9WFH2Wd
         vZ/EqaKEFQmajNzIn4wsmO/0T+/wh0+icG/ubfkj9ShDszBnYaaACC2OZjbHA9wEoIpP
         Ug7Ac6AbSWUfGpmMxHE2ChPBjzeCavmBORgsiuY2WJgp9X07BT0UFtdCr7zdDkBld2M1
         jV4IANskN1ZXtrEuSVkki6gZrPkl4SrJ2r8qs67BsPgufIyA8DvfWwbhnJFcBXCRhk81
         8TOg==
X-Received: by 10.152.170.197 with SMTP id ao5mr29634983lac.35.1375199393495;
        Tue, 30 Jul 2013 08:49:53 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id js17sm8702647lab.5.2013.07.30.08.49.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 08:49:52 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V4CDs-00022O-Sf; Tue, 30 Jul 2013 17:52:28 +0200
Content-Disposition: inline
In-Reply-To: <1375197114-10742-1-git-send-email-marcnarc@xiplink.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231370>

On Tue, Jul 30, 2013 at 11:11:54AM -0400, Marc Branchaud wrote:
> This will hopefully avoid questions over which spelling and grammar s=
hould
> be used.  Translators are of course free to create localizations for =
other
> English dialects.
>=20
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>=20
> Although I'm Canadian I figured en_CA would be a little too parochial=
=2E  I
> don't have a strong preference for en_UK over en_US though.
>=20

Since the settings (for example color) use en_US, I suggest _not_ to
specify en_UK as documentation language. Either set en_US or rather
don't set anything at all but go after "google correct". That's the mos=
t
populair alternative. For example colour gets 422 000 000 hits and colo=
r
gets 2 260 000 000 hits. We should use color even if it's not en_UK.

It's a more pragmatic approach and most git users aren't native english
speakers anyway.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
