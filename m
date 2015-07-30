From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Fix handling of remotes with single-character names
Date: Thu, 30 Jul 2015 15:12:02 -0700
Message-ID: <xmqq4mkl70st.fsf@gitster.dls.corp.google.com>
References: <cover.1438117334.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 31 00:12:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKw3f-0003o2-UV
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 00:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbbG3WMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 18:12:06 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35208 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbbG3WMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 18:12:05 -0400
Received: by pacfg11 with SMTP id fg11so2691024pac.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=91bYB9Gmc7dpshH0kvydEzURjZEOutF6nvNzhKskZR4=;
        b=GvH976X59IKeLLOg9zHchRwLbLzamwvBGDgGRmmrB8ckUttmO1DNEURjYyrmt1kE84
         JYbItyrM4rjez8Q68tTt0RJPjQQmkfVOTbL+AM3PeNxy8gTkRHI7LMQvWHxZJwdVRmfd
         LTteo+mmcS3p8jtl5SthPSye+4knY07jQ7YjEcJ80zno1vqAEKqkK+BNsjU3R4h0vHX3
         fti0k7BEmh13tGENy9uCtvBRvxFKKLy3Qn54sTNyjO70gR+Ycv4xyOIGEDAMRcb/NgT/
         a0Hd45POvfnWJsPntHvfRBFBcsa/RCLQYl7JbttCl8ZjNPG6647PkhvIjW5MWGPkN6aB
         NM6Q==
X-Received: by 10.66.66.166 with SMTP id g6mr112635204pat.157.1438294323910;
        Thu, 30 Jul 2015 15:12:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:106d:d8d6:d21e:17fe])
        by smtp.gmail.com with ESMTPSA id ow5sm3923400pdb.30.2015.07.30.15.12.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jul 2015 15:12:03 -0700 (PDT)
In-Reply-To: <cover.1438117334.git.mhagger@alum.mit.edu> (Michael Haggerty's
	message of "Tue, 28 Jul 2015 23:08:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275029>

Thanks, queued.

By the way, do you plan to revisit two rather large-ish stalled
topics of yours queued on 'pu' any time soon?
