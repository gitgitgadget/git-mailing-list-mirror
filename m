From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: handle multiple worktrees
Date: Tue, 28 Jul 2015 15:00:21 -0700
Message-ID: <xmqqy4i0aqoa.fsf@gitster.dls.corp.google.com>
References: <xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<1438118624-26107-1-git-send-email-dturner@twopensource.com>
	<1438119752.18134.43.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 00:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKCvE-0006XW-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 00:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbbG1WAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 18:00:24 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36177 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbbG1WAY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 18:00:24 -0400
Received: by pachj5 with SMTP id hj5so75994050pac.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Od1//4Caq69cmuMvjTtoJ83x+MbPgrA1jyTwy346GqU=;
        b=SnRLlcY1u6CiK2rzOKZv4nUm5I782uGWnsmY76tDDA8yTnYOxBs3O2ylov+I+v7aNN
         5+bh2RZIq56ZxhVhRvK35xkbOhucqanP+mNenk0vzNP8nEu8n9ZXJNKhTf068J0iy4Tp
         xtGzL17FJpBbK9Fhp5OgLMSnsMjI4cFd/EbELcNk9PPMxmjZ+MwnhzPKx0PBljlDgSf1
         jHPrXAdcW2Km4yaCL62lXOw36TNPwKi7Plgkj5q7pAEX5m9m6qglMJ1OybqcWAwF0ao3
         +IksrhTDTd/DhRnM6PcbfvlB2RsgqSq5lLuslFkoM2zlcro40j7HOWkmpvxLPzTJbaQk
         +soQ==
X-Received: by 10.66.248.9 with SMTP id yi9mr84644645pac.149.1438120823461;
        Tue, 28 Jul 2015 15:00:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id y2sm26883680pdi.80.2015.07.28.15.00.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 15:00:22 -0700 (PDT)
In-Reply-To: <1438119752.18134.43.camel@twopensource.com> (David Turner's
	message of "Tue, 28 Jul 2015 17:42:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274858>

David Turner <dturner@twopensource.com> writes:

> Sorry, this one is on top of next.

Thanks, but I'd appreciate if you can be more specific next time.

A topic that truly depends on everything in 'next' cannot graduate
before all the others do, but in this particular case, I think this
change only needs to depend on Eric's es/worktree-add-cleanup and no
other topic, so it is more manageable ;-)
