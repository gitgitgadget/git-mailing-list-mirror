From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] Can we ignore case for commiters name in shortlog?
Date: Fri, 30 Nov 2012 20:35:47 +0530
Message-ID: <CAKohpomGKdeZ6d6_OWYrORy+Cg0yX570jLed9wxW7d+Weytuqw@mail.gmail.com>
References: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com>
	<alpine.LFD.2.02.1211292231520.4576@xanadu.home>
	<CAKohponGXq=P88Y=cmUPbRCeJ--VkMvJyw5th1T-WdGQnn4xWg@mail.gmail.com>
	<C9C7BAF7-D552-41CF-B45D-413B9B69C054@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Fri Nov 30 16:06:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeSAG-0000p9-I3
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 16:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481Ab2K3PFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 10:05:49 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:35306 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab2K3PFs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2012 10:05:48 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so402814iay.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 07:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=GqTs2iNcTCB9lmalAzpN3crbjZizSBmt0kp8yH5ZEfU=;
        b=S93lV39wQ4ikCcgAOYo/cbMnDilQEoCN6XYzikLb5NTsiRhSlhH2NyFAKgWZAqRNaE
         GjCIj2jQ4VSsRALnb1yKCSi9c7dxgylD1ORtQpWeN5wJXakuMAozanHNolEUcQZNDrG5
         suKF+iJxvzKMWlcc1ozAB15/q+ZISNOoQv3ZgPB4+KdfMsSb25MWG1fV+k+Av611G2ht
         c1zIEoAWBZpIqQ//Gvbb1uOHj8wlzXwS2wrqZMMEeOKHuuXuj6RNvDc5MFIszEpJR8QV
         t9K7ePHr1u65ihMsc0Aa5UpHa90A7jUq0r2UNt5/dzga6jdUKg2dewrP6+LNHABEbQ50
         0/Pg==
Received: by 10.50.213.34 with SMTP id np2mr1243077igc.57.1354287947990; Fri,
 30 Nov 2012 07:05:47 -0800 (PST)
Received: by 10.64.51.134 with HTTP; Fri, 30 Nov 2012 07:05:47 -0800 (PST)
In-Reply-To: <C9C7BAF7-D552-41CF-B45D-413B9B69C054@quendi.de>
X-Gm-Message-State: ALoCoQlyBS/e0kmHEwfCGKeAABL6T3uVLQyKGLiusVAPl/iz074fZZn6PekJQID9hLaDf7n4+ZQZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210927>

On 30 November 2012 16:49, Max Horn <max@quendi.de> wrote:
> I don't see how wrong case is different from any other form of misspelling. And mailmap is there precisely to handle such problems. Now, if these case issues were for some reasons very frequent, it might be worth adding dedicated support for it. But this seems dubious to me -- do you have any evidence for this? Indeed, do you have more than just the one example?

I don't have another example, but i have seen it many times. This happens
when people use different repo's to send patches and by mistake have mentioned
names in different case in them in their local .git/config files.

--
viresh
