From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t: don't redefine test_config() in various places
Date: Thu, 21 Mar 2013 01:29:54 +0530
Message-ID: <CALkWK0kwzE+Dk7qVim7S5ie_L+eGKS+iw+Q6HTUME0cHAcPdxQ@mail.gmail.com>
References: <7vk3p3jrrw.fsf@alter.siamese.dyndns.org> <1363767703-12936-1-git-send-email-artagnon@gmail.com>
 <7vsj3pewgl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 21:00:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIPBl-0000Ap-IL
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 21:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757538Ab3CTUAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 16:00:15 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:63819 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508Ab3CTUAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 16:00:14 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so2422702iee.11
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZUDTs//+kz5Zry9pPjiAoGirITR0gZjbd91Z2QsGbJ0=;
        b=NwApXba+HebfI+nsBn6gza6QZzF3Dhuu5se3VAIxT8Id2sEta8eJPgaS5VTO2pMoEK
         mrAdKnJ01kZSmaTQPtOU+ukE4OrvUbomCVBYir8UcBvTrGRZvcPaN7WZJaVEHGO/h3rM
         Rh4XAGmw6+qSSmGEvAVoH3ji/m8krB+I/B7oWJwHzv+8UUHowzoiTewGZHX58wCUm6fN
         azR26NVYSs6PCAzbWpLlbLljpwV8uzNsMlXZ+9SAJ/zJSVdH6VEalPdbCsvs5ZK7bMjI
         AlPLNdmdcCKUXDzIuKLy4LY4pVW8J3LTBT72bxlsZITrfu3FXKsvsl5Z0p3WdppILL9B
         MFuw==
X-Received: by 10.50.17.201 with SMTP id q9mr154296igd.107.1363809614145; Wed,
 20 Mar 2013 13:00:14 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 12:59:54 -0700 (PDT)
In-Reply-To: <7vsj3pewgl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218672>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> test_config() is already a well-defined function in
>> test-lib-functions.sh.  Don't duplicate it unnecessarily in:
>>
>>   t4018-diff-funcname.sh
>>   t7810-grep.sh
>>   t7811-grep-open.sh
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  Thanks, Junio.
>
> Heh, I've pushed out the original one after fixing them up myself
> last night.

Doing a fine job as the editor, as always.  I need to watch `pu` more closely.
