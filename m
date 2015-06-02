From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 15/16] Documentation/technical/pack-protocol: Mention http as possible protocol
Date: Tue, 02 Jun 2015 15:00:39 -0700
Message-ID: <xmqqiob5zs6w.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-16-git-send-email-sbeller@google.com>
	<xmqqmw0hzsc6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 00:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzuEo-0003SP-5y
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 00:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbbFBWAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 18:00:42 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33617 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbbFBWAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 18:00:41 -0400
Received: by iebgx4 with SMTP id gx4so232179ieb.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PPqiKBYe2mVEM293ETv9NXA7JM45onwRdELtoLWcUE4=;
        b=FS/q6McgGEWhdPs1k/UYubqyG2zkAcJbnKwwcd2AsjS0N7OHwgh0XwuG+E1TX9NoCn
         /hANLdIbrtdopoyqnScuvJvrhlp7a3SZDLXL4cPokhwv5f0DfeQkq2mcWUvAbFW5vXoK
         OyYPqva2B3a56rfWGufIiNkivMIo2Q4NOeI8WVntfKXKXUXsNqRHltSrl5ld9k3ttmyJ
         YvTi4T5aIwWN1Ty80iRFoETWI1D6TaHMPPB+gm6ZqpVI3GAjENgHda1pLQoMfC7jQnRv
         eXvJRe8xjSR/WvyekE+weHXFDiYQj9KKzFMUrfiK2Zro9fh+wWYg2edUBrw/rcICbqhV
         Madw==
X-Received: by 10.43.167.137 with SMTP id ne9mr36523175icc.7.1433282440849;
        Tue, 02 Jun 2015 15:00:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id rr5sm10848225igb.7.2015.06.02.15.00.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 15:00:40 -0700 (PDT)
In-Reply-To: <xmqqmw0hzsc6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Jun 2015 14:57:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270614>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> This may go unrelated to this series as well.
>
> Yeah, this can come before this series as a good independent
> clean-up.

I'll pick this up and queue (with s/: Mention/: mention/) separately
for 'next'.

Thanks.
