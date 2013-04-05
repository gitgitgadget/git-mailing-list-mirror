From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Composing git repositories
Date: Fri, 5 Apr 2013 13:36:06 +1100
Message-ID: <CACsJy8C_dRqdPvAUW19zVLrJQGqFCRu_TaPMnRbkfgq+H9V2dw@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <20130331225747.GB11704@elie.Belkin> <7v7gkkern9.fsf@alter.siamese.dyndns.org>
 <7v7gkilry2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 04:37:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNwWe-0000sm-T2
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 04:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161355Ab3DECgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 22:36:38 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:64743 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161352Ab3DECgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 22:36:37 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so3551830oag.2
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 19:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ayWSDSzC0lfQiDPMlrkkw2466FtQaPT/LqTEWsctKFQ=;
        b=ysFoIk13A0eUhbMtoarPS/gycgr9yHwQWoIJywnOY4uH8OLDydKTiTVFYRGjh57pYx
         PbYBgsWXSe69zC73+4ga7lFf0eiLrfwRtpwzn2J1Uh+4xUZjwmcykgIsjKdqrKm2mNNe
         6W+A4ykDuRt1LVjgtb8uL2D4EAQilWcoY9mrrYjx6EVqy9qO60kSiULi7n441igVQjql
         Rj+MSf5z2sYnAkRmK4IAFDV7RC9Y3EdYGLIkxVfjCctCu93zIDa1HV+gqUMf52oaxRNh
         /3CgsQt7j4YFCVa9w5RSWOqAZCU8auZEPHvTuiL01oJy8pXcpD+sdSZbJC9+AQ+FrPKg
         5oqA==
X-Received: by 10.60.142.230 with SMTP id rz6mr477123oeb.22.1365129396809;
 Thu, 04 Apr 2013 19:36:36 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Thu, 4 Apr 2013 19:36:06 -0700 (PDT)
In-Reply-To: <7v7gkilry2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220134>

On Thu, Apr 4, 2013 at 5:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Not on the current design but the discussion before that round that
>> influenced the outcome greatly was this:
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/14486/focus=14492
>>
>> where we discussed a separate "gitlink" type of object.
>>
>> And obviously this discussion is also a must read:
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/44106
>>
>
> Found a bit more relevant and probably more important (at the design
> level) discussion history for people interested in understanding why
> the things are as they are (without which we cannot make progress
> while avoiding mistakes):
>
>  http://thread.gmane.org/gmane.comp.version-control.git/15072
>  http://thread.gmane.org/gmane.comp.version-control.git/31941/focus=32302
>  http://thread.gmane.org/gmane.comp.version-control.git/47466/focus=47621

Should someone add these links to the source code (maybe as a comment
in submodule.c, or above the definition of S_IFGITLINK in cache.h)? A
brief summary or outcome from these links in the comment would be
nice.
--
Duy
