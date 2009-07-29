From: Pat Notz <patnotz@gmail.com>
Subject: Re: git-reset any branch head
Date: Wed, 29 Jul 2009 06:33:50 -0600
Message-ID: <1cd1989b0907290533q1553773euce67dff47db546a7@mail.gmail.com>
References: <loom.20090729T095925-556@post.gmane.org>
	 <adf1fd3d0907290416q341ea6abi97828e75c50b7191@mail.gmail.com>
	 <loom.20090729T112521-558@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?B?Wm9sdOFuRvx6ZXNp?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Wed Jul 29 14:34:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW8MH-0003d1-9F
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 14:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbZG2Mdv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 08:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754624AbZG2Mdv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 08:33:51 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:53949 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623AbZG2Mdu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 08:33:50 -0400
Received: by ewy26 with SMTP id 26so782053ewy.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 05:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d1noXnjtgMs5nOF6kSvqdxCm+nPyTdFATOSuWKzkQl0=;
        b=grX9R0Jc6ByvOX7oPiAMPsRMi1cnRlFwPwd+J3RIoJMhNTEE9f2WyRW3foAwtDkEIj
         9+8vZPf9WFEoleyFzhxKRV9t6bgMU9anMwqpB4Lwbi0MbKTTYG8vy4GTLykBJg3oL2db
         UGaqXuv7ca9bYy2lpuBZl5WScMxqydqkDTYwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SUCXGABRk12Lr9muHp31DDVknZd2wOoH7ehm0N615XeC2c2Ezw75DeEyKm0ypSymYQ
         geyPCXdqy2Q+HX203JSSCgvBCnUwozT906cNAmNk/6XQvMpEEeQ49liPXQYBoR1a8m1P
         /girlCPey7s9j3i8NNAiOhEyQlHlWuhtHhmXc=
Received: by 10.210.39.8 with SMTP id m8mr6092356ebm.11.1248870830088; Wed, 29 
	Jul 2009 05:33:50 -0700 (PDT)
In-Reply-To: <loom.20090729T112521-558@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124346>

On Wed, Jul 29, 2009 at 5:37 AM, Zolt=E1nF=FCzesi<zfuzesi@eaglet.hu> wr=
ote:
> Santi B=E9jar <santi <at> agolina.net> writes:
>
>>
>> 2009/7/29 Zolt=E1nF=FCzesi <zfuzesi <at> eaglet.hu>:
>> > Hi, sometimes it would be nice to reset not only the current,
>> > but any given branch head. What do you think?
>>
>> git update-ref
>>
>> or do =A0you mean with porcelain commands?
>>
>> HTH,
>> Santi
>>
>
> Suppose I have 3 branches A, B, C, and A is checked out.
> I would like to set B's head to point to C's with a command like:
> git-reset --head B C
>
> Currently I can achieve it by 2 commands:
> git-checkout B
> git-reset --hard C
>

I think you simply want:

   git branch -f B C

~ Pat

> Z=E9
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
