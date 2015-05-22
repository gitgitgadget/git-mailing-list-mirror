From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] rebase -i: demonstrate incorrect behavior of post-rewrite
Date: Fri, 22 May 2015 08:59:05 -0700
Message-ID: <xmqqd21sfvsm.fsf@gitster.dls.corp.google.com>
References: <0000014d7bc3f6bf-72bd5f07-9e26-411a-8484-e9b86a1bf429-000000@eu-west-1.amazonses.com>
	<0000014d7bc3f7a5-332dd95f-907f-4f46-a5d6-6b9e5dc70b0a-000000@eu-west-1.amazonses.com>
	<xmqq1ti8heu9.fsf@gitster.dls.corp.google.com>
	<vpqd21soead.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Roberto Tyley <roberto.tyley@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 22 17:59:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvpLw-0001hy-BF
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 17:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757237AbbEVP7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 11:59:09 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34019 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422689AbbEVP7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 11:59:07 -0400
Received: by ieczm2 with SMTP id zm2so34480184iec.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mMLFcp+A8H8qSjQNz9gmYPIT/dYkDmXADvpRu+6hn1w=;
        b=dC+AzTRlX5trafyC0uyAFLT149LBsI+ybpSmBAvq155cGEbP/pZEUJ+ItF22hiqUwW
         Af7bF+A1mdREOF4gF7NRy/Yfau0Iw1G4Tq6qWY03+8RibU6aN1YTFFq4IoWbwNNCmGuk
         6Bv3IDrY7pc6dShvjvg02RJFsgdekSe+NuxYItsEBhZKTldvbAOfIY6k/wCRov5uC00l
         Tm4Ywi2MMGHrAoqoMtWhJ7+Mjovh7Z9TcUpjFo2cdGmsUxS1zGI+j9VZ+ziiJZFx71Cf
         Ozd+radSZrXwFXkZcEPMmxv0q3WoslOTkv6AvoJ5LkyiNLnqm+hLx0/JMkoGjUkXYO1n
         1vGQ==
X-Received: by 10.107.15.149 with SMTP id 21mr6597676iop.44.1432310346472;
        Fri, 22 May 2015 08:59:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id fv2sm4224671igb.22.2015.05.22.08.59.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 08:59:05 -0700 (PDT)
In-Reply-To: <vpqd21soead.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	22 May 2015 16:52:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269730>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> And please sign-off your patches.
>
> Ah, I was testing submitGit, and forgot that send-email was usually
> doing this for me.

Ah, should have noticed from the message-id.

Roberto, isn't your threading of multi-patch series busted?

Why is 1/2 a follow-up to 2/2?  Do you have a time-machine ;-)?
