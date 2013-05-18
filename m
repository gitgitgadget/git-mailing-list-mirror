From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Sat, 18 May 2013 09:23:35 -0500
Message-ID: <CAMP44s3oNyCzH=ySNuB0f6yn536S=pUKDETAhBOwk_siFn30EQ@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
	<CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
	<7vk3my33vb.fsf@alter.siamese.dyndns.org>
	<CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
	<7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
	<E74470E4201142788D36127322130401@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat May 18 16:23:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udi36-0003T5-Uk
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 16:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622Ab3EROXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 10:23:39 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:57229 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab3EROXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 10:23:38 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so5209304lbd.6
        for <git@vger.kernel.org>; Sat, 18 May 2013 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=N1QJ6THeww/Q5WIZVFnQwWOmfLkk9BfotgaXhdWGgn0=;
        b=h4xTtxZbkiO7Y0MT3HzfaVi1JnrWf9vn8m/oXZG1IIpegVltwOJDw80DToW3DPm2Eq
         6ykI9UgfOIsrUaKYVBuCn4XaIJDt7V5txUI9pUnHtQrdr0k6jZJyC2ZGbFdc9THRMtcJ
         hcoVaD55qoQOzHb455HIyXj65Kq1V/uekE/We90j+l2KCJsDWK5F61Wv01wDlvsBzYnn
         HbEfQebOdY0oCxUsgjgo9YXRCREVB1KYwvsrgX2MUDDWbiO+1lEdhrJef7cFvUEZbB6c
         jWxrc4MPzxDbeudSdi17Ep6PkKiYqPylINSb97zoOEsibfdCw3QpHplwcBn2Bahc1mYL
         pehw==
X-Received: by 10.112.135.70 with SMTP id pq6mr24653767lbb.82.1368887015577;
 Sat, 18 May 2013 07:23:35 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 18 May 2013 07:23:35 -0700 (PDT)
In-Reply-To: <E74470E4201142788D36127322130401@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224793>

On Sat, May 18, 2013 at 8:12 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Friday, May 17, 2013 7:30 PM
> Subject: Re: [PATCH 1/3] fetch: add --allow-local option
>
> [...]
>
>
>> So when "the user" is running "git fetch" on "mywork" branch that
>> happens to be forked from a local "master", i.e. her configuration
>> is set as
>>
>> [branch "mywork"]
>>        remote = .
>>                merge = refs/heads/master
>>
>
> Was the '.' example illustrative rather than exact. I see no case of using
> '.' in my configs. Or am I completely missing the point? (e.g. that the use
> of '.' an example of possible future usage)?

% git checkout -t -b feature master
# work
% git rebase -i

-- 
Felipe Contreras
