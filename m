From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: My custom cccmd
Date: Mon, 2 Nov 2009 16:25:57 +0200
Message-ID: <94a0d4530911020625i250c5d44rbf6dfc68fc69b520@mail.gmail.com>
References: <94a0d4530910150620g733bdf0aq88660053f869b0a9@mail.gmail.com>
	 <7vk4yw4dy3.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910151437s780bd96anca82d2b26ef99e0a@mail.gmail.com>
	 <94a0d4530910250804w3a7da36eke10710eb1cbb03c1@mail.gmail.com>
	 <7vzl7c4i81.fsf@alter.siamese.dyndns.org>
	 <94a0d4530910300139l2f20e3aaw2f89e0b809a7246c@mail.gmail.com>
	 <7vr5skim76.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 15:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4xrP-0005db-G6
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 15:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199AbZKBOZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 09:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755212AbZKBOZy
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 09:25:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:27937 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128AbZKBOZx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2009 09:25:53 -0500
Received: by fg-out-1718.google.com with SMTP id d23so750065fga.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 06:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gLAsPGlLrUBV+LDcAI0Njw251sgKyIBr1K4e3SdNN+Y=;
        b=E1f3WUf83JIcm4DaDUoAVPc1wL6oS7JJt+e68eMhj5t23LtiUzWvgD0F7GWi5Y8CBx
         thpCF9v86i8sAoiWM9Oe2rnFIOnDqeZ5U/mF92Z2KFPzfy/hSjjFOm4/QEen5kYaGEG6
         DVY/suwU6JiEzMB9+qSZ9VksxoCZIDCcdeOT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ge2tBRul4O0h5tkYlCoXeCtMsBRosxr9mjJQAE/n7AHgn33ac+5ibjxaGh2Xyp4zVW
         IcKA/W2cQbdoSoASiu4S63/kjAf6MhLBy61HTXJfkYHTbs3zPjaykuOz5BK5NcsrZiPG
         edwhq9K1aktLBTG7CXKgJ0eLZ3q1QPHdw2Nyw=
Received: by 10.86.11.6 with SMTP id 6mr2261632fgk.27.1257171957515; Mon, 02 
	Nov 2009 06:25:57 -0800 (PST)
In-Reply-To: <7vr5skim76.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131909>

On Fri, Oct 30, 2009 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Oct 27, 2009 at 11:53 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> It might make more sense if your tool told you about such a case di=
rectly,
>>> rather than helping you find John so that he can tell you ;-).
>>
>> But that's not the purpose of the cccmd tool.
>>
>> I agree that such "patch series simplificator" tool would be very
>> useful, but that's out of scope for this. Isn't it?
>
> Exactly.
>
> So you agree that you _do_ want to "discard the previous commits in t=
he
> patch series", because not doing so would mean the result would be a
> half-cooked "patch series simplificator" that tries to do something t=
hat
> is outside the scope of cccmd, right?
>
> The "discarding the previous commits" happens to match what I suggest=
ed
> earlier that lead to your "explored this a bit more":
>
> On Thu, Oct 15, 2009 at 11:37 PM, Felipe Contreras <felipe.contreras@=
gmail.com> wrote:
>> On Thu, Oct 15, 2009 at 11:09 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> =C2=A0#2. If you have two patch series that updates one file twice,=
 some
>>> =C2=A0 =C2=A0 changes in your second patch could even be an update =
to the changes
>>> =C2=A0 =C2=A0 you introduced in your first patch. =C2=A0After you f=
ix issue #1, you
>>> =C2=A0 =C2=A0 would probably want to fix this by excluding the comm=
its you have
>>> =C2=A0 =C2=A0 already sent the blames for.
>
> so I think we are in agreement.

Cool. Is this script something that would make sense in the contrib sec=
tion?

--=20
=46elipe Contreras
