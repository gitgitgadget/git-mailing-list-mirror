From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 3/9] cherry-pick: add --skip-empty option
Date: Fri, 7 Jun 2013 15:28:10 -0500
Message-ID: <CAMP44s05QSfR8DqbYtujo5ODfFkm0XFicH33hVF9L_dyC5=ieQ@mail.gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
	<1370509144-31974-4-git-send-email-felipe.contreras@gmail.com>
	<7vbo7jytv5.fsf@alter.siamese.dyndns.org>
	<CAMP44s3b2K0nbfuhNqB6FNevdPjVByQCpAie5nzAjx8bw5Y+RQ@mail.gmail.com>
	<7vy5anxcxt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3Gj-00019H-E5
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831Ab3FGU2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:28:13 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:53995 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab3FGU2N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:28:13 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so4681880lbd.15
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 13:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8nBa/INmaGo+fYrjsfVkfYquMh1dERN/BMgLeGx1GEw=;
        b=LP5EHHDbDftZk4unc3DEIj7m1KaHtDoKexar4v7mLdn9d5WFQQEndkRNY5kaLhPIRw
         MHSsJ2RKCrbF0eXuohVFJ+fVqq0gd6t+NIs76Nd6kHXcMvd5d7PIaYXXOgBXHtDUDDQ+
         zYO2vvlDMpXISSrReomz53t6or5owQwQND57DKti5iiPn5eIHNKOYvaTBaxSK7m1CMfh
         GrYcaUgkM99kMnz6omrZRoMbV+rjf3nKdv6Jdi+/efUgfZmmZCEzedrpedt4n3f9FZVs
         yRiWqMRhB+rFdkd8GqPR8AAFPlsXWCTVfFtqLJD2VxQfGxiMILgGusJaX16FRzWdPz9S
         Q3GA==
X-Received: by 10.152.22.73 with SMTP id b9mr171911laf.36.1370636891166; Fri,
 07 Jun 2013 13:28:11 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 13:28:10 -0700 (PDT)
In-Reply-To: <7vy5anxcxt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226697>

On Thu, Jun 6, 2013 at 2:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Jun 6, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Pretty much what it says on the tin.
>>>
>>> And a bit more, isn't it?
>>>
>>> The --keep-redundant-commits option implies the --allow-empty option
>>> and it was perfectly acceptable to give both.  By making sure that
>>> only at most one of -k-r-d, -a-e or -s-e is given, this forbids that
>>> usage.
>>>
>>> "It is implied so there is no *need* to give it redundantly" is
>>> different from "It is implied so you shouldn't give it redundantly".
>>
>> Remove that line then.
>
> That's what the submitter does.

Apparently "the submitter" does everything. It seems sending 800
patches in the past 3 months is not enough work for you.

And what's the point? If nobody is interested in shifting from shell
scripts to C, neither am I.

Consider this series abandoned.

-- 
Felipe Contreras
