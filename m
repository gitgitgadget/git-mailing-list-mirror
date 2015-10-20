From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] stripspace: Use parse-options for command-line parsing
Date: Tue, 20 Oct 2015 08:47:50 -0700
Message-ID: <xmqq37x5a6e1.fsf@gitster.mtv.corp.google.com>
References: <1445008605-16534-1-git-send-email-tklauser@distanz.ch>
	<1445008605-16534-3-git-send-email-tklauser@distanz.ch>
	<xmqqoafyg2sp.fsf@gitster.mtv.corp.google.com>
	<xmqqd1weg1s0.fsf@gitster.mtv.corp.google.com>
	<20151017103134.GD2468@distanz.ch>
	<xmqq6125choi.fsf@gitster.mtv.corp.google.com>
	<20151020084823.GP2468@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 20 17:48:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoZ8x-0003mY-QW
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 17:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbbJTPsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 11:48:00 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34917 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbJTPrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 11:47:52 -0400
Received: by pasz6 with SMTP id z6so25000918pas.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=KW2qF8dU+/myT5IsC721P+HgQKjKOMeqjvSdCMPcHyI=;
        b=CrVW90Dsz3OGio/JzfK86vVejRYbQE3nEw4U26zkJ1h6LmGqpOwsqxw5/VclgBK0rJ
         j5p6uSXSLRHtzrpyfKRX+RwP/8LbOHofGc21F0Wqs9qbfdkyPBm97mUq7FAq4+XqxTQX
         9bsqk64VItJ4s48C0HYzRNxoZdOin2rnGqAhVJA7+GxqScTkYFceGwSEC0eGeIpS7WrR
         kPiXU0YJ4geHlIlIv6lugeMVbBj40rLAPJSuls0Fx993qWxekcquwYQOmg7Coo7pUtvP
         8nLe71iLrk4/TulQRZ1eCwNnIlgRXgP5sboysuxm/uxveiyuPCxdhMvejJRS9Kr9IOX4
         NpGA==
X-Received: by 10.67.4.9 with SMTP id ca9mr4829377pad.90.1445356072408;
        Tue, 20 Oct 2015 08:47:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id i9sm4448030pbq.84.2015.10.20.08.47.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 08:47:51 -0700 (PDT)
In-Reply-To: <20151020084823.GP2468@distanz.ch> (Tobias Klauser's message of
	"Tue, 20 Oct 2015 10:48:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279918>

Tobias Klauser <tklauser@distanz.ch> writes:

> On 2015-10-17 at 23:24:13 +0200, Junio C Hamano <gitster@pobox.com> wrote:
>> Before starting v3, please fetch from me and check what is queued on
>> 'pu'.  It may turn out that the fix-ups I did while queuing this
>> round is sufficient, in which case you can just say that instead ;-)
>
> Now that patches 3 and 4 will be dropped and no changes being necessary
> for patches 1 and 2 (except for your changes that I see are already
> folded into 'pu'), do you want me to submit a v3 of the series? Or is it
> enough if I ask you to drop patches 3 (stripspace: implement
> --count-lines option) and 4 (rebase -i: use "stripspace --count-lines"
> when counting todo items)?

Yes, the latter is sufficient and preferrable (less work for both of
us, without losing anything to help other people to review and
discuss who may want to chime in).

Thanks.
