From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: accept indented comments (fixes regression)
Date: Wed, 30 Sep 2015 12:31:05 -0700
Message-ID: <xmqqpp0z7lhi.fsf@gitster.mtv.corp.google.com>
References: <1443600661-19391-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqd1wz9402.fsf@gitster.mtv.corp.google.com>
	<vpqwpv7hg41.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Galan =?utf-8?Q?R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 30 21:31:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhN67-0005hN-ET
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 21:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbbI3TbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 15:31:22 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36526 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520AbbI3TbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 15:31:09 -0400
Received: by pablk4 with SMTP id lk4so48633003pab.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GBZxZixqLZapmTWoylYPjHdrD105SWQDJ+w/cuw9ECw=;
        b=fWfa1VPa7MDn9DPqcd7iQX7050p6bDRAeB4AZ7XxwooCbPPGhveXbfO5zd8Z9febsI
         grvJMJb/lGA3uKuYXQjcE0UEtLJWGKA9SzZfgeWZTgoktAE4gb+4rjVm/E5uleQueViw
         5clTtQcj6zjlQ5a8rhxC5anOtmCUsxOgIbB00CeDsQwKcf2iXpohxkpA4+n33pgcqYq1
         GoGsW43NNiRQ3y4iaxEtKS/I8yN9eCqu8x8WmqnspQVpUOVA4iaNd0LIBoVxSAQ2z7je
         fjeadxgKNbuSiVk52Fp32np735d8vh6wZ5uvVTsffCM6YmnxeUsjutRc7DYbp+f/Bg/6
         VI9g==
X-Received: by 10.68.204.134 with SMTP id ky6mr6969109pbc.19.1443641468673;
        Wed, 30 Sep 2015 12:31:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id f5sm2187960pas.23.2015.09.30.12.31.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Sep 2015 12:31:08 -0700 (PDT)
In-Reply-To: <vpqwpv7hg41.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 30 Sep 2015 21:17:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278860>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Sounds good, yes. I'll send a patch with this and my updated tests.

Thanks.  I think our mails crossed, so I'd discard my copy that
lacks the new test you wrote.
