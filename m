From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 01/11] t6301: for-each-ref tests for ref-filter APIs
Date: Wed, 24 Jun 2015 17:16:51 -0700
Message-ID: <xmqqoak48wwc.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZTbXCRFx6xEv+cB7DQhu92=ePb_MJ5zeEjsr_-=HPAU6g@mail.gmail.com>
	<1435175632-27803-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 02:17:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7urU-0005PI-9q
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 02:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbbFYARo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 20:17:44 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36701 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbbFYAQy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 20:16:54 -0400
Received: by igbiq7 with SMTP id iq7so108456470igb.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 17:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ClzcWZDk8YEaNKfTFlMC2wyq0pnsg9twZbk8bM/WQqg=;
        b=Ls8IZlMzTNGija/xUQfe690wneZ9EEnbIMHDpT1OtTWzKEoYAp313x0B95cCUDvf+n
         hdCA3iIZUt7kQaW+1AT7cKR4zbbwQ0urWhcBe8NM1G+QsEbAWHCCFIuABh/B8hzvKk87
         qfZVP9qbsU6XmGoZ8a5nQjJdvwwG0DmIyeFFSzOQ8yLbUpNNnAtBrhjznru1pm0FQHbw
         cVwJZB60ku1wKN40Gm2f3hcKPRArLvnXkNcdphGhMCSDeU9t46uk7+Gmgf1e1mFvSbEP
         4YJt5YMUVQHEtzLXQZuqLXLCLWKxgKalF94tqCGcTLIxtCYqmXPn2IYWX3EdIRaTQVhb
         w5xg==
X-Received: by 10.50.117.106 with SMTP id kd10mr534195igb.24.1435191412902;
        Wed, 24 Jun 2015 17:16:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id d4sm2181927igl.1.2015.06.24.17.16.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 17:16:52 -0700 (PDT)
In-Reply-To: <1435175632-27803-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 25 Jun 2015 01:23:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272630>

Karthik Nayak <karthik.188@gmail.com> writes:

>  t/t6301-for-each-ref-filter.sh | 19 +++++++++++++++++++

t6301 is already used in mh/reporting-broken-refs-from-for-each-ref
topic.  Please renumber.
