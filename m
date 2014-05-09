From: Stephen Smith <ishchis2@gmail.com>
Subject: Re: [PATCH] How to keep a project's canonical history correct.
Date: Fri, 9 May 2014 06:41:57 -0700
Message-ID: <BB377FC6-CE4A-4A7F-BAC7-7141BD9776C5@gmail.com>
References: <xmqq4n119wgk.fsf@gitster.dls.corp.google.com> <1399615721-566-1-git-send-email-ischis2@cox.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Stephen P. Smith" <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Fri May 09 15:42:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wil3v-0000cf-Qv
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 15:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbaEINmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 09:42:03 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:60614 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaEINmB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 09:42:01 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so3758657pdi.9
        for <git@vger.kernel.org>; Fri, 09 May 2014 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=ULTUeDD8JHm2W4/Matu3bnHuYLSS+BhA7/6OBd1MvBE=;
        b=aU3nQ2ZwF25Uj1XbtpH7NiR4eHCzCY1iQKQ/rlauxIwUhniC69jnbHl2H0wJbFHa4z
         u5BFeYUqiCjFkQKXDC/van4jzYTa6hXyT6yqJaBWqHuKAgfMCIU3xqO8EKe35bilVfSd
         7/anjqTTrQPGQHW5VCzPSBsY95Op+gSrKuwjedyxOuUx+U+HMQU504IfqY5Vd8xyFrbB
         0WtzJimnPvGlmaa47aEeIpiiJIxeMIrt0BBHMazCqfsNSzIDDRkHOVWr39J7nth1/s+y
         9EvH2/9vuan/SLhPhU95kTYs0q1ycf4Vb2PAra25b9dXfDmGxQfwxCAUQt2mc2rJQuC4
         +pgQ==
X-Received: by 10.66.163.2 with SMTP id ye2mr20704263pab.110.1399642921090;
        Fri, 09 May 2014 06:42:01 -0700 (PDT)
Received: from [10.42.75.160] (mobile-166-137-182-051.mycingular.net. [166.137.182.51])
        by mx.google.com with ESMTPSA id ix7sm7720496pbd.36.2014.05.09.06.41.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 May 2014 06:42:00 -0700 (PDT)
In-Reply-To: <1399615721-566-1-git-send-email-ischis2@cox.net>
X-Mailer: iPhone Mail (11D201)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248558>



> On May 8, 2014, at 11:08 PM, "Stephen P. Smith" <ischis2@cox.net> wrote:
> 
> During the mail thread about "Pull is mostly evil" a user asked how
> the first parent could become reversed.
> 
> This howto explains how the first parent can get reversed when viewed
> by the project and then explains a method to keep the history correct.
> 
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---

The reason I resubmitted as a brand new patch was because I was using the message ID from the original topic as requested. 

In my repository I did a "git merge --squash" then the format patch.  
