From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/5] A natural solution to the @ -> HEAD problem
Date: Thu, 2 May 2013 03:19:35 +0530
Message-ID: <CALkWK0nYPe2hXLhAqK-GnMZ64N43cTCmdfFhvYdvm92nrQKRNQ@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 01 23:50:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXeur-0008Po-Me
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 23:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766Ab3EAVuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 17:50:17 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33137 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757727Ab3EAVuP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 17:50:15 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so2498028iec.0
        for <git@vger.kernel.org>; Wed, 01 May 2013 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wXYb9HlY27v0SKOkhoa0AgW+vU9cmrc+oXoDYOQ+eX4=;
        b=OEvlCHE+MTVvYXqOcCBMlAVcgRrVLQKlmDDuYosInDCbYqfu4JozABFVrxeWduROQM
         mrj4x6o8rW+odpZvZIr+KRHRT/FB/5D71PAry7yf7wqjI/mDR8u3cexvIL2wdvwYavWs
         oMMDMgODmYNPP2Qz/xQdjtZuMyrEWtxfXOmSLIseqbge5ShtbYTNBFSGz4JUNUx/xEUh
         Rj09HqtSAi3rwcd33n0NLTwoOK1gkMkJ3LfQC1GzcfrxD3vdAYj6Uc9fVTG8/ztEioJt
         6sOEnMHUDttgBt/B/puKVdJEhhCI209w6aGLEDd/mHpriUgGrl6yMKapRX6NQAAQPmDJ
         zFqQ==
X-Received: by 10.50.57.116 with SMTP id h20mr7538167igq.49.1367445015194;
 Wed, 01 May 2013 14:50:15 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 14:49:35 -0700 (PDT)
In-Reply-To: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223148>

Ramkumar Ramachandra wrote:
> Ramkumar Ramachandra (5):
>   t1508 (at-combinations): more tests; document failures
>   sha1_name.c: don't waste cycles in the @-parsing loop
>   sha1_name.c: simplify @-parsing in get_sha1_basic()
>   remote.c: teach branch_get() to treat symrefs other than HEAD
>   refs.c: make @ a pseudo-ref alias to HEAD

For your convenience, pull https://github.com/artagnon/git/tree/implicit-head
