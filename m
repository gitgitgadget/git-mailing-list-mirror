From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 0/2] Getopt::Long workaround in send-email
Date: Fri, 13 Feb 2015 12:30:52 -0800
Message-ID: <1C7C5039-FF71-4978-B65A-9CCC94E70457@gmail.com>
References: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com> <1423858769-1565-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 21:31:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMMtC-0002CJ-Hb
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 21:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbbBMUa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 15:30:56 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55900 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbbBMUaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 15:30:55 -0500
Received: by mail-pa0-f49.google.com with SMTP id fb1so21089902pad.8
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 12:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=fcfd4suWPkzR3lDKhTBNOZ6hajb8O0mP0hF8IINO1vI=;
        b=Pv9RQyTbgBl4J0ltyg9hPpD2K3dRT3HooHE2yzuj5/NtlcDgy40cBMVzo+W48tpm39
         Y9CyqH/r0mV5KgIsufbb177+Kxyj8HZPMQ4x8E1Bb1MoxjYwK8PG0kvfnKjkZrxN23n7
         sL1whdqcpyu1cj/W6m414mjpp+AAMJ5JMbhLBBfdfldnXLmT71XNDNzLAxIyL+xE3Qpk
         2lbYZbXGnm3BSFRCrWsWQMdoq+rZdrr5o9y4nqPgNHaWrpKGWGWLAKKhYX2m7ah09cO2
         oKAThO5tZ4pHfKgMshi4riiIOS5BZcuTUSmJD70NTYRYmx0/2tMw++hNDk66080Idkd0
         lDoQ==
X-Received: by 10.68.164.194 with SMTP id ys2mr18345941pbb.20.1423859455266;
        Fri, 13 Feb 2015 12:30:55 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yf6sm7599361pab.26.2015.02.13.12.30.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Feb 2015 12:30:54 -0800 (PST)
In-Reply-To: <1423858769-1565-1-git-send-email-gitster@pobox.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263831>

On Feb 13, 2015, at 12:19, Junio C Hamano wrote:
> The first one is a replay of Kyle's workaround for older versions of
> Getopt::Long that did not take "--no-option" to negate a boolean
> option "--option".  The second one reverts the workarounds made to
> the test script over time, and should break if the first one does
> not work well for older Getopt::Long (I have no reason to suspect it
> would break, though).
>
> I am inclined to squash these into one commit before starting to
> merge them down to 'next' and then to 'master', after getting
> Tested-by: from those with older Getopt::Long (prior to 2.32).

I have no objection to them being squashed together.

-Kyle
