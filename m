From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Thu, 08 May 2014 17:42:22 -0500
Message-ID: <536c084ecb546_4f6fd2f30cdd@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <xmqqha515ebt.fsf@gitster.dls.corp.google.com>
 <536adf96f37ec_3caaa612ec69@nysa.notmuch>
 <xmqqtx902k45.fsf@gitster.dls.corp.google.com>
 <536be16ba5ef1_3ce710a12ecdb@nysa.notmuch>
 <xmqqppjn29o3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 00:53:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiXBl-0001XN-QM
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 00:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbaEHWxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 18:53:13 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:39810 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823AbaEHWxN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 18:53:13 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so2790155ykb.35
        for <git@vger.kernel.org>; Thu, 08 May 2014 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=LdBxQXug1oDyCc/ZQMC0Pvt/w93+rWffh2HMIV+86IM=;
        b=XNXfnTGrI54fmkNBEykKp6RMCE/keOD7gptSHSRHMNiXLYvtqiPja3pSLttYUlnkZZ
         /QMP8C4A6V9dfuk8HBjFk6bqvO68VorrqO8BPHYBqq2UgF8w1ySU+iQE2hAYuYvsi7Vt
         u/sGG7k2EYwOLSTPYtrUGW0z+8HkC/MFAbF5f65jzMvtFIFFvwAbmJAUL6YX2haqKF93
         XNF1NBbRKVWcmxZlD7Lfg77aUlmqF+qZDTop1hE2BqOPpFT42nq9LlVbfMP+/bBPjL7Y
         BQd/3eKX98sn9kjpZ7fiTPzp5GR1ulvTJ73Tdi2mLKbbDbPuLcevWsdQ1zVpJQdHWP1z
         VTQA==
X-Received: by 10.236.90.225 with SMTP id e61mr9195246yhf.15.1399589592672;
        Thu, 08 May 2014 15:53:12 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id y3sm3442433yhd.28.2014.05.08.15.53.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 15:53:11 -0700 (PDT)
In-Reply-To: <xmqqppjn29o3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248461>

Junio C Hamano wrote:

> > I don't want to do anything for a "contrib" tool.
> >
> > It's already broken in v2.0 anyway.
> 
> Yes, this is not even an old regression.

Yes it is. It has nothing to do with with Mercurial v3.0, that's a
separate issue. We've been doing a workaround since v1.8.3, and that
workaround will break things in v2.0.

I already said this multiple times, but let me be clear once more:

MASTER HAS A REGRESSION (for all versions of Mercurial).

> If you no longer want to have it in contrib/, I can drop it in future
> releases (but not in v2.0), so that people can find the latest and
> greatest directly from you.  Otherwise, queuing a fix on 'pu' and then
> to 'next' in preparation for an early graduation for the release after
> v2.0 (and as a fix, it may want to go to older maintenance releases)
> is also fine by me.

Are you saying that the graduation plan is going to continue and they
are going to move out of contrib and be distributed by default?

If that's the case I'll resume the fixes because the current sitution is
not good.

-- 
Felipe Contreras
