From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] format-patch: add --filename-prefix to prepend a prefix 
	to output file names
Date: Wed, 10 Jun 2009 20:56:50 +1000
Message-ID: <fcaeb9bf0906100356h430f370m88ec2800d3d50865@mail.gmail.com>
References: <4A2E576D.704@op5.se> <1244629715-30444-1-git-send-email-pclouds@gmail.com> 
	<h0o36t$7it$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 12:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MELUc-00045U-Jq
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 12:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZFJK5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 06:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbZFJK5J
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 06:57:09 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:23304 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbZFJK5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 06:57:08 -0400
Received: by an-out-0708.google.com with SMTP id d40so1134266and.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=G1oxybgR3Dgt4cWf/ZQ6VjeqZeCC5o6+ZbHcEIcqESQ=;
        b=mg0KKw66XT9gEFoArklSimAzLpCSjNnfe06EC+7F6MJa6AVghJZNBOr/ynF0KNkpcx
         yeLuWVk43mgztR+J/C25rpkGOuZ8/has6+umQJ2pwcvzsx58V5dqA7lUJdH+k7xijq27
         ExCAisCf2JWRfm2ZjZb5KySOELR+CrmZuVFV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fwARFl01TRqlcjWLmP97q3TdWPVLChhc0MbWZicYLxdRNpuTu7PvQUt5RCUEhonJG0
         KFUC+pQiLXwoscXnzkjCyPB3neR+i8GaRZOedvYLByjEw2J+qcKu6IHQauZRgkhQPElX
         P/5yRu5OjjjImxqr3ICBI6eP8Yiqah8RvWoME=
Received: by 10.100.205.15 with SMTP id c15mr1128557ang.5.1244631430149; Wed, 
	10 Jun 2009 03:57:10 -0700 (PDT)
In-Reply-To: <h0o36t$7it$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121272>

2009/6/10 Jakub Narebski <jnareb@gmail.com>:
> Nguy?n Th=C3=A1i Ng?c Duy wrote:
>
>> +--filename-prefix=3D.<pfx>::
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Prepend specified prefix =
in front of generated filenames.
>> +
>> =C2=A0--suffix=3D.<sfx>::
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Instead of using `.p=
atch` as the suffix for generated
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0filenames, use speci=
fied suffix. =C2=A0A common alternative is
>
> I think it should be
>
> =C2=A0 --filename-prefix=3D<pfx>::
>
> (without the dot '.').

Right. I remember I got rid of that dot in the synopis. Obviously I
missed another one.
--=20
Duy
