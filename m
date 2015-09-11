From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 00/14] port tag.c to use ref-filter APIs
Date: Fri, 11 Sep 2015 20:38:16 +0530
Message-ID: <CAOLa=ZQppSg0-kc5nCfRYfHMoD5ehTTOigKz48G01vn1Mn=FTw@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com> <vpqr3m6nrf9.fsf@scolette.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 11 17:08:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaPwZ-0005lF-V3
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 17:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbbIKPIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 11:08:47 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35363 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbbIKPIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 11:08:47 -0400
Received: by obbzf10 with SMTP id zf10so7324000obb.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 08:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mh/AxWNMTZo+xYXYRwPw3dF+rMAp12JGAE8plIBOo2o=;
        b=0h3Ee1BjASP6D+6wF1Wmj3Z8qg+4PskjV1+f0STUXBr7ovbDaJ+Cx1C/s0FjNYR4N9
         qusnjBZi9LJSpwE/KZI7gQEKOo5qvXPG/HckuAdSDtWNxtqbEM92HiDGqS+g+CHhY1hf
         6rm+wWeiwUTgPoVJR13OFmTM0LoTmbDgogjS8Pv0f2X3S3fQSde6ZrNJp2B35oK8f+Ti
         zDG8QWHRoRYv1nA9YdYuaxfUtTyOk0fKTCaHvW3SclP859LYACvunb//oDlyOz3il/sg
         3v1Kk39X2AIO+DOK6fmeS5tdAvm0PlZS0X2wbaZQstpEAzJ0hD2tyL7/DQG+Lg/s41+D
         5Nmg==
X-Received: by 10.182.214.105 with SMTP id nz9mr159092obc.41.1441984126272;
 Fri, 11 Sep 2015 08:08:46 -0700 (PDT)
Received: by 10.182.59.15 with HTTP; Fri, 11 Sep 2015 08:08:16 -0700 (PDT)
In-Reply-To: <vpqr3m6nrf9.fsf@scolette.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277666>

On Thu, Sep 10, 2015 at 10:27 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This is part of the series of unifying the code used by
>> "git tag -l, git branch -l, git for-each-ref".
>>
>> The previous version can be found here (version 16):
>> article.gmane.org/gmane.comp.version-control.git/277394
>>
>> Changes in this version:
>> * The arguments of the %(align) atom are interchangeable.
>> * Small grammatical changes.
>> * Small changes in the tests to reflect changes in the align
>> atom code.
>
> Clearly, we're almost there. I did a few minor remarks. I suggest
> (admitedly, Eric suggested of-list to suggest ;-) ) that you reply to
> them by re-sending only individual patches that changed (replying to the
> original patch) so that we can check the new patches individually. I
> think we can do the finishing touches for each patch in a subthread of
> this patch.
>

I replied with suggested changes by you and Junio.
Let me know if any other changes to be made :)

-- 
Regards,
Karthik Nayak
