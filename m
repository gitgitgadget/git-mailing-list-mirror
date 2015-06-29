From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Mon, 29 Jun 2015 11:14:21 -0700
Message-ID: <xmqq6166bcw2.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRHoFgELMtxbZpfTvu5-S7nMTguiuOiMQDnoOs3tHXb8A@mail.gmail.com>
	<1435222633-32007-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 20:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dZd-0001GM-Cm
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 20:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbbF2SOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 14:14:25 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37456 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbbF2SOX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 14:14:23 -0400
Received: by igblr2 with SMTP id lr2so58495671igb.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XqI4asH6qQpYyRHw6RCgEAcardofSqhkMA6j3AIRVyU=;
        b=BWthoCjU1z4B1vRh7jnkaHXqDznQEYYkxoxQu1XdcbZChW55xjokKumdJzhYCgYwzy
         u3C7SryqZAe1ePJWzLWxhTLxxSOeVq/Ltj+2o7gFG2LmvxhNFxyL0k9u2XX23OGgxK+f
         WC0olj8qkHxyrwxAyEvBHs2DUfJ7cQiB5eP6IsNjM9yCziXmKGsGyyH4gKLl6HsCwrrl
         sufkToHHJKbDI46P7UBAqjnZVzXRk7N7Ms3nTBronfGe6iH2sEuAKXxyeGxz3HD5KmNA
         lbVQBmcqcCRFlBTBUVWG19+Ls0odLN3igPDIqWJ7vp6uWZWCxx87uYrj07KNcGFGs7EQ
         mQ9A==
X-Received: by 10.50.43.227 with SMTP id z3mr17304388igl.12.1435601663013;
        Mon, 29 Jun 2015 11:14:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:946c:210:22fc:378d])
        by mx.google.com with ESMTPSA id m92sm5057984ioi.41.2015.06.29.11.14.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 11:14:22 -0700 (PDT)
In-Reply-To: <1435222633-32007-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 25 Jun 2015 14:27:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272989>

Karthik Nayak <karthik.188@gmail.com> writes:

>  t/t6302-for-each-ref-filter.sh | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 t/t6302-for-each-ref-filter.sh

non-executable tests: t6302-for-each-ref-filter.sh
