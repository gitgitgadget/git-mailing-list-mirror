From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/5] Bisect terms
Date: Wed, 24 Jun 2015 10:27:03 -0700
Message-ID: <xmqqioad9fvc.fsf@gitster.dls.corp.google.com>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 24 19:27:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7oSA-0001Pq-9n
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 19:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbbFXR1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 13:27:07 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33053 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbbFXR1G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 13:27:06 -0400
Received: by ieqy10 with SMTP id y10so38007308ieq.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kwDOu6PEQ7GIoxFD4yrCjkuvaOA0kVFmAj3TnpSTb+o=;
        b=dPiCKoYm4MZqnXr5GvluvpZ7eUDeiN0ADcVEH7pRGMv/+G+bBfJJZH+2Qzf6fBjGe4
         xM6yVodRaelVM5X5F7YPnL28R+7FF2S1RixLVapUvfKRjxuCm3MtpRuvWtpDYaWgqa4b
         Ae0WkzjCrPk495konJmVBfHnGAsRDrVv7vA90EEmv0iXvBRFDFfvILPvQmalKHn2dSQI
         prpXl7RDhiXFXug3+7dqFON9sgzc4NN9VpgLwQ2aL7gXtukLiQnbP8+YpcwwyzkHb41K
         wIWaLDk6wxky2x1NcHdINBE7/GQJv/pu+JBZdjk8LRJD2X6j5fBF27+YkP/B+fLwSww3
         Twdg==
X-Received: by 10.107.5.210 with SMTP id 201mr49018448iof.88.1435166825271;
        Wed, 24 Jun 2015 10:27:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id 76sm15036336iom.12.2015.06.24.10.27.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 10:27:04 -0700 (PDT)
In-Reply-To: <1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 24 Jun 2015 17:17:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272568>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> This is a minor iteration over v7 to take into account Junio and
> Eric's comments, AND fix an important typo that I introduced in the
> strbuf code conversion (I used name_good instead of name_bad). This
> fixes the "git bisect visualize" bug I found earlier. I played a bit
> with the result and didn't find any bug.

It seems that [3/5] essentially is the same from the previous round,
though.  I'll have more comments on it In-Reply-To that message.

Thanks.
