From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Thu, 11 Jun 2015 08:03:16 -0700
Message-ID: <xmqq616ugudn.fsf@gitster.dls.corp.google.com>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<xmqqk2vbi7rf.fsf@gitster.dls.corp.google.com>
	<vpqoakmoaz7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:03:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z340q-0007aK-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 17:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbbFKPDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 11:03:20 -0400
Received: from mail-ie0-f194.google.com ([209.85.223.194]:33077 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028AbbFKPDS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 11:03:18 -0400
Received: by ierx19 with SMTP id x19so2444622ier.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9RRyx+RhdEg9bSA9N1KZXQqzotNWODHR9HM+eK0pR5o=;
        b=CN6cdQTdwFZia5Z4p5oBMMkWgUydpHxZcDTvIFg/9KPX62OD7z6k6Z5djF8Kv80xjI
         gPUYjO6Jwc2g7J3+kkpYYDESuMCJHWBZHKEPkO/mQEC7ty9h3kD8enosNlZ7ZMWMEWSU
         sLMPZKAlsfLW6AcPgwv45h7z1HIYJNXcgpJ6m6iujnE02+4/ilztOfDQP3EUf0LMGF1W
         IOvKmZpxsLVLnZ6usf2ZTvuMpg09d6U5kgbmZ2Z5G/uKKhLnd+QohLGaKkn69dyjNB2d
         8mdqJeRyO3kMOFNnALkhfVuXUpILNbhTvlIyaQd022KdGRuRlecCyjJCLD8n6ngMee6L
         II1Q==
X-Received: by 10.50.138.70 with SMTP id qo6mr34874503igb.15.1434034998414;
        Thu, 11 Jun 2015 08:03:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id o2sm687435igr.9.2015.06.11.08.03.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 08:03:17 -0700 (PDT)
In-Reply-To: <vpqoakmoaz7.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	11 Jun 2015 11:22:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271414>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:
>>
>>> -USAGE='[help|start|bad|good|new|old|skip|next|reset|visualize|replay|log|run]'
>>> +USAGE='[help|start|bad|good|new|old|terms|skip|next|reset|visualize|replay|log|run]'
>>
>> I think this patch makes the whole series go in the right direction.
>>
>> I wonder if you can skip the "we only support new/old if you are not
>> doing bog-standard bad/good" step and start from this "bisect terms"
>> one, though.
>
> While I think we should not hardcode too much in the code, I also think
> it makes sense to have hardcoded old/new in the user-interface. 

OK.
