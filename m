From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] merge: merge with the default upstream with no argument
Date: Thu, 5 May 2011 23:26:01 +0300
Message-ID: <BANLkTik+Kg6Z9jdueMB_LBOAX=NYaPE5Gg@mail.gmail.com>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
	<7vpqphasbr.fsf@alter.siamese.dyndns.org>
	<7vd3lharwf.fsf_-_@alter.siamese.dyndns.org>
	<BANLkTimXFt-RFSPOfv8Ge+boPS_e3NLXkA@mail.gmail.com>
	<7vy62l833b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jared Hance <jaredhance@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:26:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI57h-00035b-CT
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab1EEU0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 16:26:04 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37111 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1EEU0D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 16:26:03 -0400
Received: by fxm17 with SMTP id 17so1780889fxm.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xTE4EwHnK8KbvBlR7OfRXKT8VUMXASqxyVWqtGMDc8Q=;
        b=KFnPQCsatdNmcLsHdRUd2TflIKdeC9KT/Qqh+vmYLlsHLm4fCO4unLfhVZ2wK8tGoU
         n0nXDAbI1ICaBxylxlzgR97QnGtvKzeScbsig2yypZdQU6SRpw2FJXkE+YL+bwooGDNs
         U2SKu8nx000vTTLy0Lm2/69UZAHDxpgMpIRww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TMIhSLxnQ2kHnrG8reMK+YbPsyeKCgnR+s+VAb6zFDaggf91Wvyn2L8a86LeHRtXqT
         cuKhKgV7bG4p1otzxJbuaYmMmwVk7ILcqjHc/qAcgX9TS8DAK+vpVZFpmo1WtMUdNWDL
         o1vmAonf48r2HkehWwaSDkfOt6TAE0SXex+lw=
Received: by 10.223.110.21 with SMTP id l21mr1968400fap.70.1304627161924; Thu,
 05 May 2011 13:26:01 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Thu, 5 May 2011 13:26:01 -0700 (PDT)
In-Reply-To: <7vy62l833b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172906>

On Thu, May 5, 2011 at 8:33 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Mar 24, 2011 at 9:39 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> "git merge" without specifying any commit is a no-op by default.
>>>
>>> A new option merge.defaultupstream can be set to true to cause such=
 an
>>> invocation of the command to merge the upstream branches configured=
 for
>>> the current branch by using their last observed values stored in th=
eir
>>> remote tracking branches.
>>
>> FTR. It's actually merge.defaultotupstream, not merge.defaultupstrea=
m.
>
> True but that milk was spilled long time ago. =C2=A0The doc and code =
at least
> have it spelled correctly, no?

Yeah, but in case somebody read  this thread, as I did.

--=20
=46elipe Contreras
