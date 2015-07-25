From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 02/10] ref-filter: make the 'color' use ref_formatting_state
Date: Sat, 25 Jul 2015 09:45:21 +0530
Message-ID: <CAOLa=ZT0LALR0gQaRfVnpyhScSKrSLP+QPQioe+uEH+KJYs=Ow@mail.gmail.com>
References: <1437764685-8633-1-git-send-email-Karthik.188@gmail.com>
 <1437764685-8633-3-git-send-email-Karthik.188@gmail.com> <xmqq1tfxkz44.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 06:15:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIqsO-0007P8-OL
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 06:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbbGYEPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 00:15:52 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36671 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbbGYEPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 00:15:51 -0400
Received: by oibn4 with SMTP id n4so28921786oib.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 21:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=in9mbVbch+K+qlIN906aDbk2xjZPksVlY/hvTcURQE4=;
        b=LCIZye5MBpmuhqB4nWvjcIoz6+PUPSl9lwvnQA/jdT1MtdDwq3EEDTyiXzH2tlywkt
         GuTT0n6QtH/WGf/s7kR+NPnpvjrwp55ckPpWbRBd3t5YGNJ/hMzvnTfP+guUZdCoXTXq
         tLOR/weyqtWlgWVGqbtaGoOU2H792Z4koT/k8QB/jBHBU16Kfkz1yRDwL8v9eBBV7Y3S
         aGVZvpfhJ1nZyG5eSi2vGGkeCmfNRTn8HvK8ek2dh4lvIh0LCrGrlIuY82rqYDX12Y9W
         Sz9RkuQIPVrBACir8w2J5HmegmxmTVgM98YQqkNnStZn5Q0KQ8JvwJ+RmvhZJPDyDkse
         FM+Q==
X-Received: by 10.202.92.6 with SMTP id q6mr17303380oib.11.1437797750698; Fri,
 24 Jul 2015 21:15:50 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 24 Jul 2015 21:15:21 -0700 (PDT)
In-Reply-To: <xmqq1tfxkz44.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274611>

On Sat, Jul 25, 2015 at 3:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Make color which was considered as an atom, to use
>> ref_formatting_state and act as a pseudo atom. This allows
>> interchangeability between 'align' and 'color'.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>
> I think 1/10 and 2/10 are the other way around.  Preferably, these
> would be three patches, in this order:
>
>  (1) prepare the "formatting state" and pass it around; no other
>      code change.
>
>  (2) have "color" use that facility.
>
>  (3) add a new feature using that facility.
>
> The first two may want to be combined into a single patch, if it
> does not make the patch too noisy.
>

Ill reverse the patches and merge the first two as you suggested.
Thanks

-- 
Regards,
Karthik Nayak
