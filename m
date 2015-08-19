From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 5/8] branch: drop non-commit error reporting
Date: Wed, 19 Aug 2015 21:25:29 +0530
Message-ID: <CAOLa=ZS2ohaMVAMxnR7EEeKKBoo=u36LXrRmvQvUHV=+BQtA_g@mail.gmail.com>
References: <1439925345-9969-1-git-send-email-Karthik.188@gmail.com>
 <1439925345-9969-6-git-send-email-Karthik.188@gmail.com> <vpqk2sr2tfp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:56:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5if-00034w-0S
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbbHSP4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:56:00 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33955 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbbHSPz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:55:59 -0400
Received: by obbfr1 with SMTP id fr1so7911829obb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2eoHxVynD+jp9zUq+M4wSnxfhmuOHwrCmYatkUi66NI=;
        b=mMglUxDDTjqw1KIqhLV/wbLGdfMWicm/J08T6uuZWE2tk0KPri2ogH823vMfBRmNPU
         bV/vOdBG/AJiT5K+ZPzaYBmrJMiFdC8pDjcfFumC6tjsZrHrygeFqK4ONJYmQExeM7uu
         C8RBHvs7DIihVrByE5GrK79SQO+n1y9qs8gHpD44WfK6WQxTcmjJJ/3NybjFzpsS7SGz
         xLfsOPGSihNbW4IaG+SjsidVTcX9Owm39V90PJ60xG9NLhfeVTUOE0eEuI8U7//T9YB4
         tpw8hm8zP3MQv7hGxq/+SBbMmX2VMrpYEAC/9H7nm+jhosbtKzHl0pO1wr5WJmf4bYpf
         JZRw==
X-Received: by 10.60.92.37 with SMTP id cj5mr11160301oeb.30.1439999759135;
 Wed, 19 Aug 2015 08:55:59 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 19 Aug 2015 08:55:29 -0700 (PDT)
In-Reply-To: <vpqk2sr2tfp.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276202>

On Wed, Aug 19, 2015 at 8:53 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Remove the error reporting variable to make the code easier to port
>> over to using ref-filter APIs. This variable is not require as in
>
> s/is not require/&d/
>

Will change.



-- 
Regards,
Karthik Nayak
