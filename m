From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Thu, 16 Apr 2015 19:14:36 -0700
Message-ID: <CAPc5daUrKzdjdk7Fx4CmG4U9HFcATP8y79YRjOvzb1RBUqYTiQ@mail.gmail.com>
References: <552E9816.6040502@gmail.com> <1429117174-4968-1-git-send-email-karthik.188@gmail.com>
 <xmqqtwwhjg8b.fsf@gitster.dls.corp.google.com> <xmqqiocxjeqn.fsf@gitster.dls.corp.google.com>
 <552F6429.9050304@gmail.com> <xmqq618wjiwn.fsf@gitster.dls.corp.google.com> <8B5A4F0C-B550-4875-AE4C-3C38CDB25CDA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 04:15:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yivo6-0006Hj-Ij
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 04:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbbDQCO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 22:14:59 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35072 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbDQCO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 22:14:57 -0400
Received: by oign205 with SMTP id n205so61766826oig.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2015 19:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8fqaQ2C6dkPYuPyhZB6OT+v3n45K5l6yYoS+usLZa30=;
        b=rGDoXwGmJ0sb4BBHrejMDjHnlHEW3Rg7B7dKtue7650KjLiSqdCR7VkZOql4N97fTV
         KYPBYXjB9fr4bT0f/DjIpNsKyaB3wY9FgdRbXmqKGDr6DpZiOGbqkQNeRLMUMZ6BNvQh
         qAXAS9iysHCH5BPFTk9yd64YBxGVKtEf0ymDBU8EaKETQySi6NXlT1nYnCNDCS9Av2Bc
         l8gl1oHymvH/sOyOUcVllVIJNv3bl0wjOs75mRLDtvXrr0k0wA7y9Zr0k4ETyPu30XTb
         lev/H1Xl0jBTtYxHHu0hTU7k0CO9ly6XBe4zcfCGOQayjV4XaXKSvP5wJZ79I0b5kvmw
         oAeA==
X-Received: by 10.202.79.210 with SMTP id d201mr590220oib.65.1429236897183;
 Thu, 16 Apr 2015 19:14:57 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Thu, 16 Apr 2015 19:14:36 -0700 (PDT)
In-Reply-To: <8B5A4F0C-B550-4875-AE4C-3C38CDB25CDA@gmail.com>
X-Google-Sender-Auth: sfuQ-EY-Tyv1PsYn7FSKyUfuWt0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267347>

On Thu, Apr 16, 2015 at 7:10 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> On April 16, 2015 7:05:04 PM GMT+05:30, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>I meant just a different message.  The point of -e is to see if the
>>thing exists.  It is good to mention _how_ the result is reported
>>back to the user (i.e. via the exit code, not via an output to the
>>standard output "exists" vs "missing", for example), but that is
>>secondary.  Telling how it reports is meaningless without telling
>>what it reports in the first place.
>
> I see what you mean. But I think it's beyond the scope of this patch series.

It is perfectly fine to leave it as-is; that is why I said "This is a tangent".

Thanks.
