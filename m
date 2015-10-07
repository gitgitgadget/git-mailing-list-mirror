From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] quote: move comment before sq_quote_buf()
Date: Wed, 07 Oct 2015 15:46:57 -0700
Message-ID: <xmqqoagas3dq.fsf@gitster.mtv.corp.google.com>
References: <1444255550-27631-1-git-send-email-chriscool@tuxfamily.org>
	<1444255550-27631-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 00:47:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjxUH-0007hT-9k
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 00:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbbJGWrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 18:47:01 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36435 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbbJGWrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 18:47:00 -0400
Received: by pablk4 with SMTP id lk4so33698573pab.3
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 15:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nZ9mLuJ5e3q3IYkWx3v+D219yAxHO7oJLacnzH6QDJY=;
        b=QvdRJK3GEevFkelD9uym9v15yt8xYpDggi6KP/2wDDCXioIxg/CkQs5VldaABQ8Dw7
         LZ68XuZmIufBgyjhIzSTpE5K++Yv3IQLxTOjgVlNFFDvvmI7yHz/mgyocpENnF6l2T9q
         vq93ezcnaeOsX6FMRwTVLJNTavKegd+OyuXB+K0f4tLiEDKGxPVbILC8W6qLmGr/sv4I
         dq9UBHnswBni148c5ayA0dmmZoZiLyAXOycNk7GWvM4l/aCzBFR6L2ry0IlKdIkWDuy6
         SSqyRbFbSwjO+GCM2ZCgEaKej74+7AFPNboYMIh7pbASY/W3YrAc5vI10ulBI7g/bij7
         Biqg==
X-Received: by 10.68.180.131 with SMTP id do3mr3880231pbc.133.1444258019494;
        Wed, 07 Oct 2015 15:46:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8f0:649c:42a6:426d])
        by smtp.gmail.com with ESMTPSA id wi10sm9220160pbc.31.2015.10.07.15.46.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 07 Oct 2015 15:46:58 -0700 (PDT)
In-Reply-To: <1444255550-27631-2-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Thu, 8 Oct 2015 00:05:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279207>

Thanks, will queue.
