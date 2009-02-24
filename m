From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Tue, 24 Feb 2009 03:03:48 +0200
Message-ID: <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
	 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
	 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
	 <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
	 <7vljrxveqa.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 02:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbljb-0003Hx-7q
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbZBXBDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 20:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbZBXBDw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:03:52 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:49097 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbZBXBDv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 20:03:51 -0500
Received: by fxm11 with SMTP id 11so2373786fxm.13
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 17:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IhTr8txnt4T4B58aaf106FzzlGGpYWDy/p0Jd8Irfmk=;
        b=gLEqxWOKoGcy5NX9XXjCtUo6jqGSVRKnmdnMpGikOCQB5QyJAv63cAgVO5iQRlZHuZ
         t4U1hrsR5Q2sZOG+3O8wDxWNMM6ua8j1cxIzp+qsr+oKT3pZXa9VzSNA1qHtF1rzrTpM
         wHa1tyHScreBzZfVTurzji1NRPZI+OCJjvN2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BwDyKVEazXV7O6IKDvU4YneWbXBOabEBHXs3sa/6yW5u1IKz04UBP4DBUcEY4WvFRj
         hnGszYSRMMTb3hVf8lvLK692z1x85p1YLhKSF1NrqJ0PfieaaYFdwmu/h8ON3bhjUSQE
         YzNmKvtb5yyYAj1Cej/3p8wfM6ATHdO9AYlsI=
Received: by 10.86.92.7 with SMTP id p7mr3269166fgb.54.1235437428387; Mon, 23 
	Feb 2009 17:03:48 -0800 (PST)
In-Reply-To: <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111185>

On Tue, Feb 24, 2009 at 2:56 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Feb 23, 2009 at 8:39 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> It's not breakage that needs to be fixed, it's UI improvement,...
>>> ... Don't you
>>> think that --format=3Demail is more natural than --pretty=3Demail?
>>
>> That heavily depends on when you ask.
>>
>> If it _were_ during the period when we were actively building this
>> bikeshed, then I would have said "yeah, that color looks prettier".
>>
>> But a proposal to repaint the bikeshed in a different color long aft=
er it
>> was built needs to be supported by an argument that is much stronger=
 than
>> "I do not like the current one, I am improving it by painting in a b=
etter
>> color." =C2=A0IOW, you came too late to just bikeshed.
>>
>> People already are used to finding the shed in the scenery by lookin=
g for
>> that original color, however ugly the color might be. =C2=A0The answ=
er to your
>> question has to become quite different when you take that into accou=
nt;
>> otherwise you are being irresponsible to your users.

People somehow got used to the ugly color, they'll get used to the
pretty one, in fact, they would probably like it better, and maybe
even thought more than once on changing it.

If they're the kind of people that don't like new things they'll
probably not be using git anyway.

--=20
=46elipe Contreras
