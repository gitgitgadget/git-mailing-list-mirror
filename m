From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/3]
Date: Tue, 12 May 2015 22:51:59 -0700
Message-ID: <xmqqoalpautc.fsf@gitster.dls.corp.google.com>
References: <1431481799-23560-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Wed May 13 07:52:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsPaS-0007QE-LQ
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 07:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbbEMFwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 01:52:04 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35369 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbbEMFwB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 01:52:01 -0400
Received: by iebpz10 with SMTP id pz10so22713308ieb.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 22:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NFtiRLqSMYzATd9A9uHZchI3kdu07tfcccTDniieDrA=;
        b=dJ821iSmizZMEoEoj29+fXIhZEc+BGNJEuqr3leYaI6WiTqlZAYybQjqgiWvUNfb2s
         xlOPPivtIpjr4eD8Kqq7q0llq6QO0OQOtsX3MmRfQbrSTy7PytRxFV+L6xGH46Sxpi0s
         kG7DoALZZpsD76crAEmUItWJcISzLBea0Y94WQaGCVvImCsEMw3EUA59NU3huk0xRqNt
         cVCbKvWqsxxJYBaEPcV6+d5p/xk/9Hr/dNuQu5IDiIzv+1ljNeI/VZ/cQB5n3JG2ztND
         cgEq12Gkz3RKd8EPzd/Q7N+uDYN4lBMT4LeS7DZ/TG1AI6wrqks5grlKl84xnLz1n+d3
         nCGQ==
X-Received: by 10.42.128.84 with SMTP id l20mr7339825ics.21.1431496320945;
        Tue, 12 May 2015 22:52:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id fs5sm2916584igb.0.2015.05.12.22.52.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 22:52:00 -0700 (PDT)
In-Reply-To: <1431481799-23560-1-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Tue, 12 May 2015 21:49:56
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268939>

dturner@twopensource.com writes:

> This version of the patch adds improved error outputs for various
> weird situations that can come up during symlink resolution.

Overall these looked sensible.  I have been resisting the temptation
to merge this to my tree since around v5, primarily because I did
not want to resolve merge conflicts with kn/cat-file-literally more
than once, but I think this version looks solid enough that whatever
rerere will remember will be applicable to later iteration if one is
ever needed.

Hence I queued it on 'pu' for now; I haven't checked how the doc
formats, though.

Thanks.
