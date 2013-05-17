From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Fri, 17 May 2013 11:34:55 +0530
Message-ID: <CALkWK0k6D+hOw2iQ=tJ+_bkKOA-7dKkEsG9XBSBqkg9hDm-bGA@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
 <1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
 <CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
 <7v7gj77nt9.fsf@alter.siamese.dyndns.org> <CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
 <CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
 <7vwqqy7v8g.fsf@alter.siamese.dyndns.org> <CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
 <7vzjvu6faq.fsf@alter.siamese.dyndns.org> <CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
 <7vfvxm6biv.fsf@alter.siamese.dyndns.org> <CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 08:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdDnQ-0003J4-FB
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 08:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab3EQGFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 02:05:36 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58703 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab3EQGFf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 02:05:35 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so8467108iea.18
        for <git@vger.kernel.org>; Thu, 16 May 2013 23:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2X4URHE1H/AKh/jua8KKHN/ySNyqTKggAtjg9DuKzps=;
        b=m7pTL7d3JU1CCorONrmuehR8N39tzdbqNAV+kB58+SnBkUdhaeS/Mc4glPGte52hSZ
         2UihVUHzEPKPH5AozNAVDoIywC2Q9sNEJJEcI0/Ov45RyE6JmO/h9D2mSuHZRSpwN1fw
         /LL6207CJjcI/HKkMD6sDTvpDyIvlvO4EDf6MGzzmf/0jBE63WNftILmjJ/P/A6Qe/k1
         9CKRTPsqQ1p5H/kVNIewmYNfJOtBab+b8m4QPiIPU+vBNjYxcLcxZiSlWf8LBABH2m4z
         7cNwPUzhXa2R+b4lEsoOc1Qp2zK3VpJVW4RlT1FyXUcRsP7TT7LQorxT617VP3cPv3xx
         LFGg==
X-Received: by 10.50.147.71 with SMTP id ti7mr12034937igb.49.1368770735513;
 Thu, 16 May 2013 23:05:35 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 23:04:55 -0700 (PDT)
In-Reply-To: <CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224652>

Felipe Contreras wrote:
> This is what Linux's checkpatch throws:

Perhaps it's time to include checkpatch.pl in our tree and update our
CodingGuidelines?
