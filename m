From: John Tapsell <johnflux@gmail.com>
Subject: Re: Relative ls-files
Date: Wed, 23 Mar 2011 11:27:05 +0000
Message-ID: <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
	<4D89D052.5030801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:27:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2MDZ-0006BT-AY
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 12:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab1CWL1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 07:27:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36156 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501Ab1CWL1G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 07:27:06 -0400
Received: by iyb26 with SMTP id 26so8454822iyb.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QgJO9Dg0p8PMECXhOx/fQIEQC8uRGAEYVCuUctECNFU=;
        b=pxPkql3leWokwrL+MUfIc2T8wpkEboqqYgRSmrS2qRVCCVaY7r9HOg4jOt04n44zRR
         TVGNP0mvUkGrldUx74DZr/q5VCgtuY3yloB9nNuvkXAn/ZAVaIzZT1eWoxwNH4yeEhxm
         mwB0PToSgVY4YkHHLa1UspSJEjgbHXjFmCY7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WCOWUXYTQZI0AH11B/zmroBv2fhwYSDgeB9WW2BXo7BksU6d1KsfoBucVxNgGW27VP
         X0Cm8RoR/YjOKmGgxNQOd9sR3HZ8sD3Mmaj0xyxF4ADQC/Z95fbWcXy/0NfBDx6j6q7Q
         /TIr7raquv/0kdfwZxv5KdEuWY/e140gs1OxI=
Received: by 10.42.135.9 with SMTP id n9mr11217641ict.42.1300879625317; Wed,
 23 Mar 2011 04:27:05 -0700 (PDT)
Received: by 10.42.220.1 with HTTP; Wed, 23 Mar 2011 04:27:05 -0700 (PDT)
In-Reply-To: <4D89D052.5030801@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169817>

On 23 March 2011 10:49, Michael J Gruber <git@drmicha.warpmail.net> wro=
te:
> John Tapsell venit, vidit, dixit 23.03.2011 11:33:
>> Hi,
>>
>> =C2=A0 Could someone add a feature to =C2=A0ls-files =C2=A0to list a=
ll the files in
>> the repository, but relative to the current path? =C2=A0It would be =
useful
>> for many different aliases, such as "git locate".
>
> That is in the works, we just have to decide between two suggested
> notations:
>
> git ls-files :
> git ls-files :/


What's wrong with --relative  or something?

I've never liked magical strange notations.  ":" already has a meaning.

John
