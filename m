From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Revert "remote-hg: update bookmarks when pulling"
Date: Thu, 16 May 2013 18:04:41 -0500
Message-ID: <CAMP44s3HKgWE=8SU+aBMBWzwe-fQ8Rjf0yGmGQxcdedhYCNJmQ@mail.gmail.com>
References: <1368708195-1044-1-git-send-email-felipe.contreras@gmail.com>
	<7v4ne27ubp.fsf@alter.siamese.dyndns.org>
	<7vbo8a6b9c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:04:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7E8-0004dh-CH
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193Ab3EPXEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:04:44 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:60351 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab3EPXEn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:04:43 -0400
Received: by mail-la0-f46.google.com with SMTP id fk20so3600491lab.19
        for <git@vger.kernel.org>; Thu, 16 May 2013 16:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0q6Nr1xRd5X9pErwHlJMJQGmk4WSwkeWdzwpWIJjP28=;
        b=c6JWJxuzFhTtsrwwDGi6N9N+/kBemunOxJRYMBk6v5nkTisTlaUujAbSGnCAYLVsJ0
         vJ2hiZ8Pe+XNb3/x1IY7TP/ta2D/zrQ/P0ST2YJ6+NHgfkgqKh3LkubdNPZ21vEkJEEn
         kKPGdSNhRayxk2RYsu3qQW+/v8hh579jVR24tlMp+BJXcmfOODl6TC2YidFWMHCFyj07
         HCpTJnS8OuULYeHQQGe3Sd0wD1d2Up8CmhQGPtTc6PILGWy1BWNhXzTVzQA23IqAEJWK
         K88SND6/7wOaVcZ2vJKbQ4YfqlDeiSMFklUUtfRx1i+A3Zv0Q0UMvWz2a3GzjX6RNPRQ
         E68g==
X-Received: by 10.152.120.4 with SMTP id ky4mr21533776lab.5.1368745481907;
 Thu, 16 May 2013 16:04:41 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 16:04:41 -0700 (PDT)
In-Reply-To: <7vbo8a6b9c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224627>

On Thu, May 16, 2013 at 1:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> This reverts commit 24317ef32ac3111ed00792f9b2921dc19dd28fe2.
>>>
>>> Different versions of Mercurial have different arguments for
>>> bookmarks.updatefromremote(), while it should be possible to call the
>>> right function with the right arguments depending on the version, it's
>>> safer to restore the old behavior for now.
>>>
>>> Reported by Rodney Lorrimar.
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>
>>> Intended for master (v1.8.3).
>>
>> Hmm, is this the one we merged yesterday?
>
> Just double-checking.

Yes.

-- 
Felipe Contreras
