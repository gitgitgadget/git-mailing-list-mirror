From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Wed, 19 Aug 2015 21:27:25 +0530
Message-ID: <CAOLa=ZTsgG4_hVV7+gEBt8AXWkYWi6AoB3Kj9wTYJ4KK60vE_g@mail.gmail.com>
References: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
 <1439925345-9969-4-git-send-email-Karthik.188@gmail.com> <vpqpp2j2toq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:58:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5kV-0004h7-Lh
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbbHSP54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:57:56 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34876 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbbHSP5z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:57:55 -0400
Received: by oiew67 with SMTP id w67so5677790oie.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i/E4vdsDfNZSaf4jiAMulZu2Bx+FyVCKSwFyFg3AXrQ=;
        b=nI0moxFOCr+ZH832wrgxC3xiuKAks83yzoFLlNnhjRtVBRR1MiaGv+cwm2WkpVWrSN
         5CAV1Jh4QqdZXKmct4P8t0pqbiJQ3tGLJJKDuHgx3x2WqP24zcmt+//rBcft60AebBcU
         /qI3ZkTC2uvwKYUpT0SYBnlnbC7g0L6PowqJmCa1eQJ92jaBD5qrxVn5CsqOh9QaEjZt
         P5EM70H2fVXIv+Yb+VIs1H5rQ16wRyBs2eQbEMZBWCr9fMNcUegpCXGO1E7dDZKJ0QL/
         EAVMKPegN6azh3n4fEOabww4wL3l8uHNbtGIaJXuEFrrRJENaxZsp8MhFhyaCFnh3cLO
         dqIA==
X-Received: by 10.202.92.65 with SMTP id q62mr4101323oib.11.1439999874712;
 Wed, 19 Aug 2015 08:57:54 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 19 Aug 2015 08:57:25 -0700 (PDT)
In-Reply-To: <vpqpp2j2toq.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276203>

On Wed, Aug 19, 2015 at 8:48 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +     /*
>> +      * First we obtain all regular branch refs and if the HEAD is
>> +      * detached then we insert that ref to the end of the ref_fist
>> +      * so that it can be printed first.
>> +      */
>
> Nit: the end of the sentence reads funny (why put at the end "so that it
> can be printed first.").
>
> Perhaps "... so that it can be printed and removed first.".
>

Will change, thanks :)

-- 
Regards,
Karthik Nayak
