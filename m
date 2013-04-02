From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] git-send-email.perl: implement suggestions made by perlcritic
Date: Tue, 2 Apr 2013 13:11:47 +0530
Message-ID: <CALkWK0mz3Oj+3zsx2JSs8ufh=yPOAZ9hiSb6a_pBJptJqdp5zg@mail.gmail.com>
References: <7vfvzgn3ob.fsf@alter.siamese.dyndns.org> <1364474835-23416-1-git-send-email-artagnon@gmail.com>
 <7vsj3fs22i.fsf@alter.siamese.dyndns.org> <CALkWK0nGZUV9umbe9UoV79QU+ojCc-=j+RFpCNn_vjM_QTPyPQ@mail.gmail.com>
 <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 09:42:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMvrt-0000fi-5D
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 09:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab3DBHm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 03:42:28 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42782 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115Ab3DBHm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 03:42:28 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so117440iec.18
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vGhZZfCyicMj99n5fCfSzr1W4KXiPBgF3ynrfOWB2a8=;
        b=wd7N9N9oK6attOP4uNOefr1YvbF/ds56Hm5gu2lUPUF7D80rNKNJK9Npt1lLqWSkW2
         xqmlRfgUUNvEtz57yNFLuBuRXQHSN6zJxxT6hVn7E+rPuS8nab2NNof4b8eXjOMk0Iui
         ObG+GXHYhaa2N73ssDZuE0OIajHazfnSLfpOFrm/TIlFbO/ZhSKABC2w8taonvf2PCml
         S+JkAPw5V6jXG4MOfX7s6tM/W16l+XWS54m2j8KdpwWeKNzrphZukcgVLed3FnZ75UM/
         6mgrjN/8vncdpNJeEsxAsY5VoHkM1GuZWZ/Ewj/jmNnZC36tC+JaGHZAZnvEKCi2sqCG
         f3Xw==
X-Received: by 10.50.17.166 with SMTP id p6mr4699769igd.12.1364888547625; Tue,
 02 Apr 2013 00:42:27 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 00:41:47 -0700 (PDT)
In-Reply-To: <7vr4ivni5g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219750>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> Ouch.  Please drop this patch; I'll resubmit when I feel confident
>> about my change.
>
> No, let's not do that.  I will forget and end up spending time to
> read the same patch again.

All three look good to me.  Thanks for doing this: I learnt quite a
bit from your commit messages.
