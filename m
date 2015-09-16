From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/67] war on sprintf, strcpy, etc
Date: Tue, 15 Sep 2015 18:54:28 -0700
Message-ID: <xmqq4mivt9gr.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 03:54:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc1ve-00037U-6g
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 03:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbbIPBya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 21:54:30 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36837 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbIPBy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 21:54:29 -0400
Received: by padhk3 with SMTP id hk3so192782098pad.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 18:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Piabux3cjLtwonuiW7ZP0vYhZVcyJKSExZpdCMghFzg=;
        b=kcPAnESaR2E9zjMzxs0n47+p7rk6eS/xSLLbH56GZ7INvD7XUuLMU1s4HZ5sph5UXI
         LVQfvAuQmwWDTllgn/KTWHzOgsUe/NfqD213ZuHlSlXpJVleQO4mCH4IwOaLNWp9OJBn
         orD1efJIIMjNtQvh9ks3U/sKM7gHAO9Ww1RPbnb3YtwPosCMYoCNIaNWBJTrM8Wzts4H
         Z/yUCxxjqTyToAr+bENFxPOCMcK73wmBbwLW6RPJBHlTckGbrcMEBo98lMiuJEyjfhZw
         5Mkd+UfWRhNyxwIRGpcl/hlKLm/b5EwMIA2lvcYZ8PsSsHze2anzz4PR/Ueift3h8k8o
         ujsQ==
X-Received: by 10.68.254.99 with SMTP id ah3mr53551138pbd.15.1442368469512;
        Tue, 15 Sep 2015 18:54:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id c16sm24422119pbu.37.2015.09.15.18.54.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 18:54:28 -0700 (PDT)
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 11:21:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277997>

Jeff King <peff@peff.net> writes:

> Obviously this is not intended for v2.6.0. But all of the spots touched
> here are relatively quiet right now, so I wanted to get it out onto the
> list.  There are a few minor conflicts against "pu", but they're all
> just from touching nearby lines.

Thanks.  Looks like a lot of good work you did ;-)
