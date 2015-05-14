From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Show all branches and ahead/behind states
Date: Thu, 14 May 2015 17:55:38 +0200
Message-ID: <1431618938.31573.3.camel@kaarsemaker.net>
References: <CAHd499AyEDNM7mDstFugD0Ah46=gAS=BRocDmpmOK-1k+qMCmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 17:56:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsvUJ-0007nt-C2
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 17:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934161AbbENPzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 11:55:45 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34678 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933596AbbENPzm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 11:55:42 -0400
Received: by wguv19 with SMTP id v19so18198254wgu.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 08:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=kF1PydjjMMUcFBgwkbJ8uCQEyo8yh9N/wc6UZK3W7d8=;
        b=K/OIzMo6TcBDaxdKazrWYILzh2QBGybRo73eNc4R1TqRRQe1A5OWU7YAYRvGn8zlLM
         8n6xoVTRjfzpugnIS4ewVostJmLhvgFO31aMMvkapdJqHFpYFLB5X/gMNwzl7hQ3slHE
         lK4x+nbhvYidFXlhIQAQT/FgG7HoPkVbAhU4ObuvCIKpDp1SpljFIoUNpe9AasIT0VKN
         w55bpIHELVKWTE7Ecdl4+NfJjLeOowUXWyFtPtJaU/pgcTfZT7qOs33hHJiIfxdLf7uF
         Yqsu4dB+8+zHRnwjvI9FhosyKb2/eTsj/tqxijl4zuBibkzYAEMRVIgHNXDpc7qOTfSM
         zV+A==
X-Gm-Message-State: ALoCoQmt//+DjHMU4OqsXj+toVePryM8GuMhLlRqtzPyA0EYuwmizNPvLHsU5v8Xs3JGq4y215M8
X-Received: by 10.194.89.130 with SMTP id bo2mr1506607wjb.17.1431618941100;
        Thu, 14 May 2015 08:55:41 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id g5sm38796714wjq.6.2015.05.14.08.55.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 08:55:40 -0700 (PDT)
In-Reply-To: <CAHd499AyEDNM7mDstFugD0Ah46=gAS=BRocDmpmOK-1k+qMCmw@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269041>

On do, 2015-05-14 at 09:57 -0500, Robert Dailey wrote:
> Is there a script or built-in functionality in git 2.4.1 that will
> allow me to list all local branches with the ahead and behind status
> of each? Basically the first line of:
> 
> $ git status -sb
> 
> But for every branch would be roughly what I'm looking for. Any ideas? Thanks.

git branch -v (or -vv) is what you're after.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
