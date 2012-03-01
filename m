From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 1 Mar 2012 12:05:43 +1100
Message-ID: <CAH5451mbB8kU_0P=PwpyxT_3+s_UY1TxRF-sBTUZ5kxeZGHe3g@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <rmifwdti2ap.fsf@fnord.ir.bbn.com> <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com>
 <7vehtdqh46.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Troxel <gdt@ir.bbn.com>, Jonathan Nieder <jrnieder@gmail.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:06:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2uTD-0005XJ-QW
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 02:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966173Ab2CABGG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 20:06:06 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60480 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966166Ab2CABGE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 20:06:04 -0500
Received: by wejx9 with SMTP id x9so27409wej.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 17:06:03 -0800 (PST)
Received-SPF: pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.104.4 as permitted sender) client-ip=10.180.104.4;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of andrew.ardill@gmail.com designates 10.180.104.4 as permitted sender) smtp.mail=andrew.ardill@gmail.com; dkim=pass header.i=andrew.ardill@gmail.com
Received: from mr.google.com ([10.180.104.4])
        by 10.180.104.4 with SMTP id ga4mr21721355wib.17.1330563963424 (num_hops = 1);
        Wed, 29 Feb 2012 17:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=L3p10qnXaAGYaI5x+62PBQMLvdmNlI2fB1EMDoUYb08=;
        b=pW7LqLph8jQDhZf3NTuRSx7ZEhh2/2McuXWT9RkpDWNVhmZPpAc+zr7qtFfI3h5S/x
         pI2KIAdyJu3VkUmHNvxX6ufFv3euvDMDo5mtR4FabJT3wNxQLVLnUmn39sRIlIiILXw5
         Es9yget1H+5xO02C292TkBZvRxnjzTWTM3d8Q=
Received: by 10.180.104.4 with SMTP id ga4mr17376249wib.17.1330563963339; Wed,
 29 Feb 2012 17:06:03 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Wed, 29 Feb 2012 17:05:43 -0800 (PST)
In-Reply-To: <7vehtdqh46.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191871>

On 1 March 2012 11:50, Junio C Hamano <gitster@pobox.com> wrote:
> Andrew Ardill <andrew.ardill@gmail.com> writes:
>
>> Additionally, if we are not prepared to use non-Free tools, we shoul=
d
>> probably stop using github. (This example is a little trite, seeing =
as
>> there are non-github alternatives available for grabbing the source
>> code.
>
> Just on this part.
>
> Github is not the only place to grab the source code. =C2=A0Far from =
it.

I understand that Github is not the only place to grab the source code
(maybe it was not clear that I understood that), however the point was
more that even though Github is not-Free many people still use it to
develop Free software (including people developing git). As Free
alternatives to Github are available not many people mind too much (or
so it seems).

Why do people use Github at all? Perhaps, because it provides an
accessible, reliable, powerful and supported platform, with large
amount of penetration in the market and some very desirable features.

I believe that JIRA in the OnDemand package offers similar benefits.
Additionally, Free alternatives would still be available (the mailing
list). Perhaps there is too much controversy to anoint a JIRA issue
tracker as 'official', however I continue to hear people ask for a
tracker, and apart from Jonathan Nieder with the Debian bug tracker
see no one else putting their hands up.

In any case, I spun the instance up because nothing happens until
someone does something, and if it fails then at least we have a record
of trying it next time someone asks :)

I would love to see it succeed.

Regards,

Andrew Ardill
