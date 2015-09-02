From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7060: actually test "git diff-index --cached -M"
Date: Wed, 02 Sep 2015 12:24:23 -0700
Message-ID: <xmqqtwrcmxp4.fsf@gitster.mtv.corp.google.com>
References: <1441217575-45474-1-git-send-email-matthieuprat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Prat <matthieuprat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 21:24:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXDe1-00027l-K0
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 21:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbbIBTY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 15:24:26 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36518 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033AbbIBTYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 15:24:25 -0400
Received: by pacwi10 with SMTP id wi10so20580209pac.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HCvNNTYy5T3QWy0f85w3GIW5iHRa41bdnaGOngtFiMc=;
        b=hE9yk/QSJt5/pFRvtV1sWLspsKzW4uHC4N/SsztuzpXHQowa4N/jD6jIo6lh6nixMY
         9L8fWx4vURNahNvxC3L4cdFmXMbHo8OZFBPsHNkhd3U8WYrLweyZ03AH3wEwEHfoWAwD
         H4y1KcAZXBMXYliF48N6vbZE8c+CnxWba1FLN/BrcS9deBsLCRMEdw8Fvd9L7PXkjg9J
         Jo2BMSHnsu/r0KIAAyQHR5wnD6d+RNLqdiPKwHDktE268/8aPRWSsxFqejFPIuua0J9T
         K/G7/UllRXL94zQRNrzDI9Wd2vBmwOUzvyk/oiicD1SZldh0JOe3Jq/kQuNgY6yJZCEE
         QExA==
X-Received: by 10.68.249.36 with SMTP id yr4mr58615282pbc.18.1441221865082;
        Wed, 02 Sep 2015 12:24:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id ff4sm18932628pab.2.2015.09.02.12.24.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 12:24:23 -0700 (PDT)
In-Reply-To: <1441217575-45474-1-git-send-email-matthieuprat@gmail.com>
	(Matthieu Prat's message of "Wed, 2 Sep 2015 14:12:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277116>

Matthieu Prat <matthieuprat@gmail.com> writes:

> A test was designed for "git diff-index --cached -M" but the command is
> run without the "-M" option (which makes the test essentially identical
> to its preceding counterpart).

Very true and it seems that it has been that way from the day these
trio of tests were introduced by d7c9bf22 (diffcore-rename: don't
consider unmerged path as source, 2011-03-23).

Thanks for a fix.  Will queue.
