From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already
 checked out
Date: Wed, 27 Aug 2014 18:58:35 +0700
Message-ID: <CACsJy8A3+9Rzz7ZEC3jgz0aQngT06Xi85gf6u2KS8VQUqkChvg@mail.gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406115795-24082-4-git-send-email-pclouds@gmail.com> <53CFBD2A.9030803@drmicha.warpmail.net>
 <CACsJy8DwPM68j-=LDDbq1H_bT1gD=aLQ8x6C1qiwF79=ai14dg@mail.gmail.com>
 <xmqq8uni8mx4.fsf@gitster.dls.corp.google.com> <53D1FE76.5080708@drmicha.warpmail.net>
 <xmqqmwbqzptt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 13:59:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMbsy-0007KA-Tk
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 13:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933374AbaH0L7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 07:59:08 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64107 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbaH0L7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 07:59:07 -0400
Received: by mail-ie0-f179.google.com with SMTP id rl12so100191iec.24
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hGF44gekI71J3TELixk69xBCiI/kL4+hC41sMf3j65Y=;
        b=lSlNa4h9d/TJGOf8i99EyVb+XznEGEwzL2OFvGNbyERHzYb/6EDBxGQaICFKGBUk6W
         FvUGmRVlDhc0drcQgLqFTGdBWxCN7BU92IEz40fbdkJ3COFgv5umbuRCWxBLcdNXhZHL
         CnBcLxBxAWeJpJyQEJ9YWNVVw1pTgdy4uUu/17+rv0ur2kvY9rGnnWutvGgXijezbC8h
         ApgGNAM/8knN2tFhUMVQ+h5rpDcdWgrmVz/YNm1cuy5Qg1iKhBZOorMr81UKFZYQMN8V
         z0aoLx4hhrirXlIlnkKuF780XbushmHVR8lJo7PFYvKQg19rRqZLRruyvBunTio9KWGC
         MpTw==
X-Received: by 10.42.216.198 with SMTP id hj6mr2914582icb.65.1409140745445;
 Wed, 27 Aug 2014 04:59:05 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Wed, 27 Aug 2014 04:58:35 -0700 (PDT)
In-Reply-To: <xmqqmwbqzptt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255991>

On Thu, Jul 31, 2014 at 1:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> As an error message that is completely sufficient.
>>
>> The advice messages are meant to teach the user about the normal parts
>> of the toolchest to use in a situation of "conflict", aren't they?
>
> Not really.  They are to remind (to those who learned but forgot)
> and to hint (to those who haven't realized they have things to learn
> in this area).  Wall of text that tries to do more than that, like
> "teaching", risks not getting read by anybody.

Last call to all. Keep this 'advice' or drop it?
-- 
Duy
