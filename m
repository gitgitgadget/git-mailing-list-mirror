From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 02/12] ref-filter: introduce ref_formatting_state and ref_formatting_stack
Date: Mon, 24 Aug 2015 14:56:50 -0700
Message-ID: <xmqqr3ms2vvh.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<1440214788-1309-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 23:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTzjc-0002BZ-TE
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 23:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbbHXV4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 17:56:52 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33206 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbbHXV4w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 17:56:52 -0400
Received: by pacti10 with SMTP id ti10so33010560pac.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 14:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1QWByZZt98PMLiOM1kJVpjGH26uubJkmwb6kQTnNRd8=;
        b=0lpWrEuKACxCUJKgAGknxVSpz8Oi7MpyVON8Di++YM0C+V4a+o/mF2QBLvkIMJ6PB1
         fXMZVf+Kxq2fj62evHBXJXzOWg1GJGIemnBjTElF29fYfmwr4zvalZvuCjzbvGkz/R9/
         LKop30RcLd2sUUVj3pmYvZ1l89b53zB4fhE4YjRJe9AgHAHA+jDYzWtapMEveoQW8Ukv
         5iy3WFJmJd7o7ySrCSU8HW9KmEA1offWDW7X2ThogyogMLyLMj3nmNmLu6OKMM1vW6Al
         eHUtVWJLDVIIS46P60iJ/chYHS/tXqHMHQEM+iuD2xxGcC+3dYEvov5aRYb1I+ew0TEF
         VOmQ==
X-Received: by 10.68.93.133 with SMTP id cu5mr50149786pbb.71.1440453411597;
        Mon, 24 Aug 2015 14:56:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id y2sm18551263pdp.0.2015.08.24.14.56.50
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 14:56:50 -0700 (PDT)
In-Reply-To: <1440214788-1309-3-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sat, 22 Aug 2015 09:09:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276490>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void push_new_stack_element(struct ref_formatting_stack **stack)
> +{

Micronit.  Perhaps s/_new//;, as you do not call the other function
pop_old_stack_element().

The remainder of this step looks pretty straight-forward and was a
pleasant read.

Thanks.
