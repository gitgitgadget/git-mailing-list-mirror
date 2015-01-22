From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 1/4] apply.c: typofix
Date: Thu, 22 Jan 2015 15:48:30 -0800
Message-ID: <CAGZ79kYpaDs10J8WxdWwW1ojeeddQ+squUXYg1yuYVxOhzK__w@mail.gmail.com>
References: <xmqq1tmnwypp.fsf@gitster.dls.corp.google.com>
	<1421967505-16879-1-git-send-email-gitster@pobox.com>
	<1421967505-16879-2-git-send-email-gitster@pobox.com>
	<CAGZ79kYR7AcgTghwLoTejvaB=BRW+YxJdHZtjteXVbcrNqh8LQ@mail.gmail.com>
	<xmqqd266s7qa.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 00:48:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YERUJ-0004rf-SB
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbbAVXsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:48:32 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55245 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbbAVXsb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 18:48:31 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so4428637ieb.2
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 15:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BdnUagsT1g1wz5up3uG5LyQdykz1Co9PxP5PczbDTpw=;
        b=McGm9WPTdBUWyPNg005BAP2KAnhwDtpmjXhpMjs1QV+LQRGUutkzH6qulG1fFzPel1
         TE0HdqTYe3Il9oBI8ngJcWP0P4cl94nCbIJgMxa/zHjcwwduj6Zvc3SvZ2SjJoF4qbQt
         udtmDZNRISajBHkUTcAxChU0rssFOljFsTrAiiI/8vagluspFefKRyzSbNbqzzRcom/o
         s9iLaDbg4MNl1gfk3RKtvwoVUFXq1Bo4QpDEKagofx2N4rYQki7a4JkF79pKELbc3xOm
         i/6pFTLk77uaoBg6QANcqqgvhpbQRDO/lZ3Zncud5ViTaW0BTLZr5GBq2RkLNovMkxA1
         PKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BdnUagsT1g1wz5up3uG5LyQdykz1Co9PxP5PczbDTpw=;
        b=iiIqBem9bhEn3808u4NRYL6M4I9CWTf9SNF/F245NaoruU5eLqgSuGsEn1y+SrdSRl
         d01320K6ZS6mQty3Mx0/P2g2U9xQsCoEm7sKF3J1CywAi0KQM5bmBClMrplBpDKyVdSM
         6NM8m8IVh1Jv51eMvOz/vcshLDT+G0TKi9LXobZcNNDmBytq/xxLb2++d2YctbA+Ksm0
         eEnwBKl0gIoJXkhER4XuIbtTjbFPiIMwjKjzgmYUCB8W5igZhD9KJsQFc+dmnk3E5x/c
         /Lja3L36uwp1f6pfVcn8+IAWGfMOOPQMXMrclaca6U5UmoiDUT+oaOm9EqdW/e0ElnV2
         +bAA==
X-Gm-Message-State: ALoCoQnxkIzgmNO/wHqWE+vEWCc/18VMGK3dZR7OXnRJGccfHKXpKBcsZUYAo9DcyfZqml9Uy4XP
X-Received: by 10.50.79.196 with SMTP id l4mr16184650igx.14.1421970510589;
 Thu, 22 Jan 2015 15:48:30 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 22 Jan 2015 15:48:30 -0800 (PST)
In-Reply-To: <xmqqd266s7qa.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262895>

On Thu, Jan 22, 2015 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> -        * it might with whitespace fuzz. We haven't been asked to
>>> +        * it might with whitespace fuzz. We weren't asked to
>>
>> (not a native speaker):
>> A quick websearch reveals "We haven't been asked to ..."
>> is quite commonly used in the web. So it's more of a grammar fix or a
>> rewording of a comment instead of a typofix(which I assume are miss
>> spellings)
>
> Correct; it is not grammo or typo fix, but is a rephrasing to match
> the tense with what follows (i.e. we weren't asked to ignore; we
> were asked to fix).
>

Ok, I realized I missed my conclusion in the first mail: The commit message
and what the patch actually does, do not match.
