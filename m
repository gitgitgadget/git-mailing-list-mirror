From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: send-pack does not respect http.signingkey
Date: Tue, 21 Jul 2015 12:33:22 -0700
Message-ID: <xmqqr3o1uwzh.fsf@gitster.dls.corp.google.com>
References: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
	<xmqqlhef50kz.fsf@gitster.dls.corp.google.com>
	<CAD0k6qS_uQk5KZVJYA7BVZ9sRPRj=cZ3rbYRfJ3vhgSh2drEMA@mail.gmail.com>
	<xmqqh9p350ad.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSZtZN60ExQQfH0mq_rZrOA4Fw0ZeWfX_gr=2btbSYHQw@mail.gmail.com>
	<xmqq8uaf4xmo.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSq8+JMFZgvQuVptCxUknYtMa7xrojABEDYLQAw015qvg@mail.gmail.com>
	<CAD0k6qSjKnHMHXAQxJ97-dLcWVz+_ay+j6=X9j_yjx25sCwFrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:33:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdIA-0005sp-5O
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbbGUTdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:33:25 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33345 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbbGUTdY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:33:24 -0400
Received: by pdbnt7 with SMTP id nt7so54536348pdb.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DLIl6uhyI9VTPP9VMw5F9eQQ/wiVND/UOzuWQ2C0Z14=;
        b=tm8kg+vbvwJic/DdCDNF4NhKcasJMtjB/9cEL6CEytMwkBwbw/rNhjiMPwFbY0Zf83
         upw6hZc3xG2E93V5fMBnCYsptOzw6yLkU8xuuo63o1TJLLDdADdwjnZ+O0ptkffAZdeA
         RgpnYBmMLkEpDKlJA3j6cftAAaZMulfM1nC0uM2BPRPH9Cb0EqbZfgZcYcm26cD1yHGt
         ai8KzFuQl8Kpq084egGnVrMMqWicXMs1UlGEORnWpb7SucCOVN/rhPKad/Frrw5Sas6I
         4wV//iIjAC7MYVq373kVpeMv23Ok9043dLB9ZjlDJYZunsgAb8VyELCslMzLLm/UJnH5
         Ip7Q==
X-Received: by 10.70.91.12 with SMTP id ca12mr55501716pdb.135.1437507204442;
        Tue, 21 Jul 2015 12:33:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id oq10sm12015475pdb.75.2015.07.21.12.33.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 12:33:23 -0700 (PDT)
In-Reply-To: <CAD0k6qSjKnHMHXAQxJ97-dLcWVz+_ay+j6=X9j_yjx25sCwFrw@mail.gmail.com>
	(Dave Borowitz's message of "Tue, 21 Jul 2015 12:25:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274402>

Dave Borowitz <dborowitz@google.com> writes:

> Should I formally send a patch with your configuration one-liner?

Yeah, the log message, that explains the motivation of the change
and the decision to read which part of the configuration, is much
more important than the actual patch, so please do so ;-)
