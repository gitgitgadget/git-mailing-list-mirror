From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 4/8] branch: move 'current' check down to the
 presentation layer
Date: Sun, 13 Sep 2015 18:52:38 +0530
Message-ID: <CAOLa=ZTQjtEi4G7_T6gRzrmL=EocJxw69qR=n7vjLWCvbu2JMw@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
 <1442129035-31386-5-git-send-email-Karthik.188@gmail.com> <vpq4miyv7kn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 13 15:23:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb7FS-0003N9-K0
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 15:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbbIMNXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 09:23:10 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35764 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbbIMNXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 09:23:08 -0400
Received: by vkao3 with SMTP id o3so33921328vka.2
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 06:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3Lo/EdU4NSCOH95dqi885bRjtFr69C7htZnjiWeOSYA=;
        b=faHqfJ1OvUDlFg1W0vz0ozy/dm8/Hc0D9ZUN0UkLsqZkKMSw8VJkC6/P8fYKyRqfw6
         +huV/83VxAdT+ZBlBkpUUR0yf42YsaQHgDZIVS76UPLmQ9PfMbDkCBLAnAohzb0AFrnZ
         Ma/uCNkcPl7EUW7l6z9hppOZcgFhz5mnp/C43WgQhoDBufyvsuSrgICXuoAtaHDikD6G
         U0yDxX/OKzCItuGNSZ2JO4sk2kTWOuvjwCQi4uPPOOArSZfVDPuGMPTDvskx7gU537Ng
         ea9uJi+cq1LaDS/aILYMkDQZJra0C7XWIaY6hviJ25PWE6BderTaSsZZDTNr0uRLCMFe
         9URw==
X-Received: by 10.31.149.143 with SMTP id x137mr8408506vkd.17.1442150587900;
 Sun, 13 Sep 2015 06:23:07 -0700 (PDT)
Received: by 10.103.23.66 with HTTP; Sun, 13 Sep 2015 06:22:38 -0700 (PDT)
In-Reply-To: <vpq4miyv7kn.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277783>

On Sun, Sep 13, 2015 at 5:45 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> We check if given ref is the current branch in print_ref_list(). Move
>> this check to print_ref_item() where it is checked right before
>> printing.
>
> You may want to add a sentence saying why this is good. Given the
> context, it's relatively clear that this makes the code closer to the
> shape expected by ref-filter, but if you imagine someone bisecting or
> blaming and finding this commit in another context, that person may
> appreciate more explanation.
>

Will do.

-- 
Regards,
Karthik Nayak
