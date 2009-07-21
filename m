From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: Getting untracked files
Date: Tue, 21 Jul 2009 16:48:10 +0100
Message-ID: <57518fd10907210848m3fef11b9y989d4026b44e19fa@mail.gmail.com>
References: <20090721152458.GH24439@bug.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Trstenjak <Daniel.Trstenjak@online.de>
To: Daniel Trstenjak <trsten@science-computing.de>
X-From: git-owner@vger.kernel.org Tue Jul 21 17:49:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHax-0003UC-DM
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbZGUPsb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2009 11:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755502AbZGUPsb
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:48:31 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:50971 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498AbZGUPsa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 11:48:30 -0400
Received: by gxk9 with SMTP id 9so5413253gxk.13
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=aLYb/6Av5wEyVQv42i1sACZrYG44R3blxLuANYJnqGc=;
        b=cjwVKqCPIqSjSXee6m1i81yLp4D6ntNu1fIBtGdKM8+xIIcciwIj3Y3cTVcrdfsAVp
         a3VJtwnxIcELIi6miZSh9n67YaAmxPw1vs/RnA9LPqHzd4Vi4eu2xqWi31aAydS61xXs
         3w3ULPkuY19qV8Fm22eZIWDEJggVTcflCTBvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=giQyz65PE2wQ1N1Tq3K9pzfXzgdbGQ7BsLgk5RG/3rWUWHBm12tTVox0XCZS+vEzJ0
         8jS7p7yJ6cNFHqxj4uKc/mDDU6SCA159aZz1eu7F+ag98TRRpvnVG/iCu5sSCegx4RrP
         HllEwNE+9VMBXO2G8QHSyERmIEdiOv5nkLhcM=
Received: by 10.151.99.16 with SMTP id b16mr9223382ybm.99.1248191310075; Tue, 
	21 Jul 2009 08:48:30 -0700 (PDT)
In-Reply-To: <20090721152458.GH24439@bug.science-computing.de>
X-Google-Sender-Auth: bdb871136f0270e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123672>

How about "git ls-files --other --exclude-standard" ?

On Tue, Jul 21, 2009 at 4:25 PM, Daniel
Trstenjak<trsten@science-computing.de> wrote:
>
> Hi all,
>
> is there a nicer way to get the untracked files then
> with grepping the output of 'git status'?
>
> Is there a plumbing command?
>
>
>
> Greetings,
> Daniel
>
> --
>
> =C2=A0Daniel Trstenjak =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tel =C2=A0 : +49 (=
0)7071-9457-264
> =C2=A0science + computing ag =C2=A0 FAX =C2=A0 : +49 (0)7071-9457-511
> =C2=A0Hagellocher Weg 73 =C2=A0 =C2=A0 =C2=A0 mailto: Daniel.Trstenja=
k@science-computing.de
> =C2=A0D-72070 T=C3=BCbingen =C2=A0 =C2=A0 =C2=A0 =C2=A0 WWW =C2=A0 : =
http://www.science-computing.de/
> --
> Vorstand/Board of Management:
> Dr. Bernd Finkbeiner, Dr. Roland Niemeier,
> Dr. Arno Steitz, Dr. Ingrid Zech
> Vorsitzender des Aufsichtsrats/
> Chairman of the Supervisory Board:
> Michel Lepert
> Sitz/Registered Office: Tuebingen
> Registergericht/Registration Court: Stuttgart
> Registernummer/Commercial Register No.: HRB 382196
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
