From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 05/16] remote: remove dead code in read_branches_file()
Date: Sun, 23 Jun 2013 14:07:36 +0530
Message-ID: <CALkWK0=pgivbq0D3Q29H4+RM77s67EALharbVCwAGFqjBPQgwQ@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
 <1371813160-4200-6-git-send-email-artagnon@gmail.com> <7v1u7vkslz.fsf@alter.siamese.dyndns.org>
 <CALkWK0mYmhnOL-F+StuKWSeQ48EsQSAnS0_6u-B8KKq+RrOW5A@mail.gmail.com> <7vhagpfdwp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 10:38:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqfoU-0001lC-PZ
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 10:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205Ab3FWIiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 04:38:18 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:61448 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3FWIiR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 04:38:17 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so22945972iea.3
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fOVP7cUjEjltZyWmvlcyvEtoPRR6isblOi35BDDuRLA=;
        b=ACWJ++SbE76mJSndfdRULqx80EcNb2CuhrzHKjsItnBtZv8kAAOumO3YpQ3FEe3Yba
         InfAzMz1vdMOcu7EJnkftyNuqZoxGatSP7lbRysS9jimd0c/K9/dXy+BqX5kpHQqK/SU
         2QsOQkrdeqfEWzjjsWS9D9X6lbV+1p556i7EB+DfARG0It8quzPz84pCo5qF+V1URYWr
         GBS+M16EBk9XhCwINpCqRjWgkY/mq8Z13dUBo5ZJ/nuLfGe1zn7jWH6DUY49hdqRBAjq
         uV57qs2cjrLAZ8IM6TLv1Xb82fdwgzqf9J573GaqReX5U3zlBgBZL5VsgEpI4LMpcdIj
         6Kig==
X-Received: by 10.50.1.37 with SMTP id 5mr2960446igj.29.1371976696951; Sun, 23
 Jun 2013 01:38:16 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 23 Jun 2013 01:37:36 -0700 (PDT)
In-Reply-To: <7vhagpfdwp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228734>

Junio C Hamano wrote:
>>> Reminds me of the strategy to deprecate functionality in X (cf.
>>> http://lwn.net/Articles/536520/) ;-)
>>
>> Leaving dead code around to confuse readers? :\
>
> We broke the use case to access jgarzik/netdev-2.6 only by having
> jgarzik remote accidentally, and waited for quite a while (since
> early 2008 until now) to see if anobody screamed.  Nobody did.  We
> now know we can remove that feature.

Did we _not_ leave dead code around to confuse readers (no comment or
log message indicating intent), or am I missing something?

> That is exactly what Keith is describing, isn't it?

Wasn't that a joke?
