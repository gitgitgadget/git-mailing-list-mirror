From: demerphq <demerphq@gmail.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 12:28:39 +0100
Message-ID: <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
	<4D89D052.5030801@drmicha.warpmail.net>
	<AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:28:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2MF3-00074M-Lq
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 12:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646Ab1CWL2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 07:28:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65513 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501Ab1CWL2k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 07:28:40 -0400
Received: by ywj3 with SMTP id 3so3276702ywj.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 04:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zHNhOYSC88tnwvt+tPBkGuHt1TR9rD7Vha5LNUzBRH0=;
        b=vFCTL/VlhORjGIfRn+c6rC1lqckqiPlflEGhh25emPPa+3+E1LNLzx8ZB/i13qBpa/
         LbkaJ027QN69U+jww2adSeJ0NJGpLASvpNom+5/YLLY2PVUfiOro2FruybmwDfGdEqWt
         IvjV+ZgPrLNHEacRODYW54Uq9QV/gtAgv8XZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WD8bZsMjs5jO5U15v2gnVwvoZSLBkPwfA8svsAG6zJmSHanX3RDWV45ECnv29FRs/r
         l3LG6aBLLw37d2X1cQib/doskdVpgbM3SRATAtSZHkA8E/PD9xB0cyty+uI7tWnFrgag
         TUJDY5fecsCENZYS2Z9dSP0TuZaGVXnibRhA8=
Received: by 10.236.183.196 with SMTP id q44mr8370983yhm.304.1300879719803;
 Wed, 23 Mar 2011 04:28:39 -0700 (PDT)
Received: by 10.236.108.35 with HTTP; Wed, 23 Mar 2011 04:28:39 -0700 (PDT)
In-Reply-To: <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169818>

On 23 March 2011 12:27, John Tapsell <johnflux@gmail.com> wrote:
> On 23 March 2011 10:49, Michael J Gruber <git@drmicha.warpmail.net> w=
rote:
>> John Tapsell venit, vidit, dixit 23.03.2011 11:33:
>>> Hi,
>>>
>>> =A0 Could someone add a feature to =A0ls-files =A0to list all the f=
iles in
>>> the repository, but relative to the current path? =A0It would be us=
eful
>>> for many different aliases, such as "git locate".
>>
>> That is in the works, we just have to decide between two suggested
>> notations:
>>
>> git ls-files :
>> git ls-files :/
>
>
> What's wrong with --relative =A0or something?
>
> I've never liked magical strange notations. =A0":" already has a mean=
ing.

+1

yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
