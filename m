From: Philip Kimmey <philip.kimmey@gmail.com>
Subject: Re: Git & Paramiko: failed to push some refs to ...
Date: Tue, 20 Jul 2010 09:12:02 -0500
Message-ID: <AANLkTikiM9hjqhH_J9kgQwVUmtKa0TUWTeR-w5O2FkB2@mail.gmail.com>
References: <AANLkTil0soA4pLGRZT-jgdOkB3s8qApG_h2a-UW2P_G5@mail.gmail.com>
	<201007201218.51717.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 20 16:12:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObDYP-0002G5-0l
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 16:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758371Ab0GTOMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 10:12:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46301 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757616Ab0GTOMF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 10:12:05 -0400
Received: by gwj18 with SMTP id 18so2623344gwj.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v2+nFCEcX1E7l8MkU9geST/vRzhpr5okbwHPFaVj5VY=;
        b=tpyUIky5s4eoEn9hk+rMM0ejMa8G3OX3Z6qo7rCnYLuMaBLlNysI4AgIF7D/+pSgOZ
         d54lVpniD0Z9dvnvOzF/zlRgpQo8kiXDJrZIBsVpIQbiaC7PNqARf+Xn0eBJSH2IoT/G
         8LTVBncM5zUS8qa1Fjc4CquFKWa+B+Omvjtx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MMod0bEgoFb3EkSQsCWFLwQJ8lGcGgpPabWlb1nkXR2+pf7KDSRckK+gDzy43iNs37
         fAjo0Dso1PlpUIEdpU0CIcibhi7xMRSNEzxxMHTnszBAT1DgkKp8Dxu11uuPCA4LCwgx
         N99ba/vsfxQHNdsVXdWw5dmomM0pYDBBzk5Os=
Received: by 10.150.218.18 with SMTP id q18mr389338ybg.62.1279635122604; Tue, 
	20 Jul 2010 07:12:02 -0700 (PDT)
Received: by 10.231.178.131 with HTTP; Tue, 20 Jul 2010 07:12:02 -0700 (PDT)
In-Reply-To: <201007201218.51717.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151314>

A *very* good guess in-fact!

I hadn't even thought of that! That is exactly what the problem was. I
return the exit code, and wham! Git is happy.

Thank you so much for the help, I've been trying to figure this one
out for several days!

-Phil Kimmey

On Tue, Jul 20, 2010 at 5:18 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Philip Kimmey wrote:
>> If you prefer you can see the outline of my question at stackoverflo=
w,
>> with better formatting than e-mail will afford:
>>
>> http://stackoverflow.com/questions/3262161/git-failed-to-push-some-r=
efs-to-with-custom-git-bridge
>
> That has a lot more information. =A0Please include it in the email ne=
xt
> time.
>
>> To git@localhost:/pckprojects/heyworld/
>> =A0 =A0d83f744..404debd =A0master -> master
>> error: failed to push some refs to 'git@localhost:/pckprojects/heywo=
rld/'
>
> A *very* stupid guess: =A0Are you reporting back the exit status
> correctly?
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
>
