From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Fix a bunch of pointer declarations (codestyle)
Date: Fri, 1 May 2009 12:07:38 +0300
Message-ID: <94a0d4530905010207r2da4157cpc6babd530e91f83@mail.gmail.com>
References: <1241168796-7222-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 11:07:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzoig-0003nn-SK
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 11:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbZEAJHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 05:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbZEAJHk
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 05:07:40 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:41558 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbZEAJHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 05:07:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1115640fkq.5
        for <git@vger.kernel.org>; Fri, 01 May 2009 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d0m5ojOd0ViwRl4Rs6D53WEyBS2xM+oMlvr62JroNXI=;
        b=JH6Z5+funotuNPYrHao/Mfnyx5iG7NclZ1/qd3Abqka/UPi/kVft7tQgq1vXa7cWyo
         F9cO6zTSuHfry6uzO/BNJjzQ2LiH6/kZQjbuCfKx9IHvZnkqqZ7Yz9rS36D0TwkAHeS2
         EGBUuytbzJ1TFgArfX7L3WzAB2aCJJClEQ3mU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wMq8AOsE5MxhRiP1P/IvVUS70ffbWbk5v3FAqzuI+XxEkv6Cy9f31feFe5uyG4xWru
         DgI20vse08008dRsNKxh4/qYdZomRZ1jdXqw7m+s/q7K57l3nHgSVGCUInqvuPxotXzl
         f+xBxsZ/lcbn/rhls6iVOB3tizioecBBy2MJ0=
Received: by 10.86.51.2 with SMTP id y2mr2706729fgy.3.1241168859144; Fri, 01 
	May 2009 02:07:39 -0700 (PDT)
In-Reply-To: <1241168796-7222-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118066>

On Fri, May 1, 2009 at 12:06 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Essentially; s/type* /type */ as per the coding guidelines.

FTR, I've made sure this patch applies cleanly on master, next and pu.

-- 
Felipe Contreras
