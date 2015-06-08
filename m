From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/9] add options to ref-filter
Date: Mon, 08 Jun 2015 12:34:08 -0700
Message-ID: <xmqqmw0a9eq7.fsf@gitster.dls.corp.google.com>
References: <5573520A.90603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 21:34:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22oR-0006RM-Gt
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 21:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbbFHTeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 15:34:15 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33931 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbbFHTeK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 15:34:10 -0400
Received: by iebmu5 with SMTP id mu5so247015ieb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=D3xiGtTwOJPAM3i61lqv2OMsqbVUf6zV/xKdBG/+woU=;
        b=oR8CNdbILLPzchbGWIrx8jSqBxcNKOszfB4E+7R6uM5wEowqQrbQtIPB68EuRTcipF
         IrEirUZVJ+wYveaK18n1y4knS87pD89jgUys/atGt4rs+cWlHlT4NpY22F1olOUOJEKs
         v11KbWdbPWL/h9pDfk2xWS4uvf69MTwxu0evvV6/x8JwhE5QUtPc8jeHaLyCgQUZ5pCF
         CjoyN84Ksk+tauc8ZYIbZC0rTHrGkbWS7um5pRiCBHBiVCC4WhcuiYtGAsOPvUYlMFLo
         6DMECBIP8iUiZyu1gpVrbqKX5xw3q+ZAKKZleTAWxBkCWFvhcThzn0tidGP11aZ2sZvY
         fJLw==
X-Received: by 10.50.66.174 with SMTP id g14mr15569707igt.7.1433792050081;
        Mon, 08 Jun 2015 12:34:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id lq3sm990433igb.3.2015.06.08.12.34.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 12:34:09 -0700 (PDT)
In-Reply-To: <5573520A.90603@gmail.com> (Karthik Nayak's message of "Sun, 07
	Jun 2015 01:33:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271117>

Karthik Nayak <karthik.188@gmail.com> writes:

> This is a follow up series to the one posted here
> http://thread.gmane.org/gmane.comp.version-control.git/270922
>
> This patch series adds '--ponints-at', '--merged', '--no-merged' and
> '--contain' options to 'ref-filter' and uses these options in
> for-each-ref'.

The structure of the series looked sensible (I stopped at around
7/9, though, for now); even though a few style violations were
somewhat irritating, overall it was a pleasant read.

Thanks.
