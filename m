From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? git config and --unset are not inverses
Date: Wed, 29 Jul 2015 12:10:18 -0700
Message-ID: <xmqqlhdy93vp.fsf@gitster.dls.corp.google.com>
References: <CAD0k6qR0J0ks2mL9TTd4wD7qrzKwadFGC=ecJRCsTcSS0ioo_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:10:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKWkH-0000SZ-1J
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbbG2TKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 15:10:22 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35185 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbG2TKU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 15:10:20 -0400
Received: by pabkd10 with SMTP id kd10so10118912pab.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mM1/tPh31zkdZbm0IT8YksyOEPLqOEPX3jvp78VLyME=;
        b=UuxiSukA+Uw7jD3ZPPhZM/BtJEtwXqQJodwe6LpfNcqphq/hEdA7LdHlFkEng5y0Fj
         +LmLWBleVArnTHUoJD91BeSubiBYs0fT+uFoJBrNFY6PofBUFkVwMvg0Sw2zBiJeHpzf
         O9AjuYjfhIZ9pzOjPXETS3Z1Boin5nUsM6XjSJvWBOT/8V6qyYsZ+nNXg5WJzG1N6ZjD
         JtnBYELQBckAd25asrtcr8vn6h+H9LVIfu1qeKCCZkheeFMGg4qh4SgJ2PpHbv5SYI28
         3a2semh64S1gytWzXOIIQykyjG5JxKCgSNa6TTporkddLBdeG6spkKQ77IKTgbxaOG3/
         1lcA==
X-Received: by 10.66.118.237 with SMTP id kp13mr97769812pab.9.1438197019996;
        Wed, 29 Jul 2015 12:10:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c0b:2701:e242:17dc])
        by smtp.gmail.com with ESMTPSA id xs13sm42287583pac.3.2015.07.29.12.10.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 29 Jul 2015 12:10:18 -0700 (PDT)
In-Reply-To: <CAD0k6qR0J0ks2mL9TTd4wD7qrzKwadFGC=ecJRCsTcSS0ioo_A@mail.gmail.com>
	(Dave Borowitz's message of "Wed, 29 Jul 2015 11:59:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274940>

The most recent round of the discussion is here:

  http://thread.gmane.org/gmane.comp.version-control.git/219505/focus=219524
