From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/3] submodule--helper: Have some refactoring only patches first
Date: Mon, 31 Aug 2015 13:15:47 -0700
Message-ID: <xmqq1tejuscs.fsf@gitster.mtv.corp.google.com>
References: <1441048767-29729-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:15:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVUf-0004Vb-SF
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbbHaUPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:15:50 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35859 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbHaUPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:15:49 -0400
Received: by pabpg12 with SMTP id pg12so17200482pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JQD57g/ACF3efXDg0t130FVupBGY6JMIVEfEXq85rUg=;
        b=uzaHOUh8W7XC/gyy9yvlWGTIpecuVRjwJStt5AAUBbuAzE0YC1PqctDg+/pf7dWyVm
         PAuKG5XKpsbmOdGkYNugqirtGsbAUoKu6nzKqHbqzCRVdIqA8U3P/0xzmH7tijHfzjQE
         vCe8rlH+AQNvJI09mcjyhEBKSAuh7itlj4fVELqXDp1u9Yce4mVA34KJLjnjFZmVuyeQ
         rlZdqFsfM/BcS6tlG08lN+VGEmw5MiH26bVzVgzWImnGAaNdGgt+gKCSnvSY705JRPvc
         Cuh0EYi9c+YBnzb82oF9wuvwd8vs2qMo+BsIv10/dDrgHEVq+PKuV6a3s4deK8psyv14
         9c8A==
X-Received: by 10.66.158.3 with SMTP id wq3mr40870191pab.38.1441052149138;
        Mon, 31 Aug 2015 13:15:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id qf7sm15514124pbc.18.2015.08.31.13.15.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 13:15:48 -0700 (PDT)
In-Reply-To: <1441048767-29729-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 31 Aug 2015 12:19:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276934>

Stefan Beller <sbeller@google.com> writes:

> One of the mistakes I made last week was mixing these quite stable patches
> with highly RFC/WIP patches and not pointing out loud which is which.

I think it was very clear which is which to people who have been
following (which are the only people you would care about anyway),
but I agree that it would be easier to follow by others if you made
two series, i.e. solid bits like this one, marked with "PATCH v$n",
and the WIP part as a separate series, described as building on the
v$n reroll of the other series in its own cover letter.

Thanks, will replace.  Let's move this part to 'next' and start
cooking.
