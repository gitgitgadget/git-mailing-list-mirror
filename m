From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 05/13] ref-filter: implement an `align` atom
Date: Fri, 4 Sep 2015 23:32:13 +0530
Message-ID: <CAOLa=ZTx_CG_RrHHDLadWmx5UvuE9GMaf4nwcWr880vQ-eM3Pg@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-6-git-send-email-Karthik.188@gmail.com> <CAPig+cRfYow-wBvorX44E4ROH=nvQdS=3zBaEVVbQZf86JFELw@mail.gmail.com>
 <xmqqtwrblbdy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:02:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXvK4-0005Zp-9E
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 20:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760133AbbIDSCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 14:02:44 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33256 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbbIDSCn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 14:02:43 -0400
Received: by oixx17 with SMTP id x17so16331678oix.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 11:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/3mvMt239uxWjXbB0w36J3k1onH8FSolUA1l36RsI6Q=;
        b=d/mshS4CMuVQXrjEXMZmNIKRd+c6TSRpY5jnmDCfXnx9bMiiMkuXJPTpkMjfCJ3P+A
         FgzFdIK4iJGaxn2jn4w1wZu3L/IAn82aE5cs1+2WZ17V3Sq34CROe99JBlsfSUJAhvyL
         MQaj9sfZHECxz9L8eAWgVVYpclVzKX8Lgp5esJRIQW1XOCGJUiKSWKFN/P4/js0zEiKu
         impanipibRfanhZbsAPJQMYaVP3yfwD19yDB/RUbDVIWD7/XZ1+TWfW7gEmVPX68OS77
         d9emKSMZFobCA2dK99gt9V1FX7iirUf4FsgGTbDBdWdQCnNIrPSg9btqE4WFFICDydsX
         sPiw==
X-Received: by 10.202.92.65 with SMTP id q62mr4237632oib.11.1441389762945;
 Fri, 04 Sep 2015 11:02:42 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Fri, 4 Sep 2015 11:02:13 -0700 (PDT)
In-Reply-To: <xmqqtwrblbdy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277325>

On Thu, Sep 3, 2015 at 9:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Sep 1, 2015 at 2:26 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> Implement an `align` atom which left-, middle-, or right-aligns the
>>> content between %(align:..) and %(end).
>>
>> Spell this either %(align:) or %(align:...) with three dots, not two.
>> I, personally, think %(align:) is sufficient.
>
> I agree with you that double-dot does not signal "some things are
> ellided here" to a usual reader.
>
> I actually think consistent use of %(align:...) is needed, simply
> because my knee-jerk reaction to "%(align:)" was "huh?  where does
> the need for the trailing colon come from?", not "ah, you try to
> imply that there must be something more by having just a colon
> there".
>

Yeah, it makes more sense to keep the triple dot.

-- 
Regards,
Karthik Nayak
