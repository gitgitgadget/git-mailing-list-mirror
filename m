From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] path: optimize common dir checking
Date: Mon, 05 Oct 2015 13:36:15 -0700
Message-ID: <xmqqsi5pxdc0.fsf@gitster.mtv.corp.google.com>
References: <1441073591-639-1-git-send-email-dturner@twopensource.com>
	<1441073591-639-3-git-send-email-dturner@twopensource.com>
	<5611E7B1.3090001@alum.mit.edu>
	<xmqqd1wtz0w2.fsf@gitster.mtv.corp.google.com>
	<1444075810.5158.7.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:36:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCUg-0004fC-5H
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbbJEUgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:36:18 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:32853 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbbJEUgR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:36:17 -0400
Received: by pacex6 with SMTP id ex6so186700747pac.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZTfIeVKW/GG9MA3TYeD9IKFCzjNsdpYqzxgM6Q4dnLo=;
        b=yfzy8eF1C5TXf1liBrVTYk7nDJXkfZ+UD0MxfVP8itfqxRm1LQbTCd9eeAPuDqCrDK
         aFr7lcZyPLfIIx1VTG/Jd25effDJh8VcKNo1fGlrIPjJV4duplW0v1u21kAYa9BCcgeX
         IfVYW7MA+8zVxe4LeiRHcfC8JU7Bz2ihbFoAfD3HUrVWO4kwsxh6hSbRfOMgUQYKFj0b
         Bs8LkTTwzAgqJNejsYO1QZd5NZBXVYEzikCBVnU0QpZX4l2pb6F5tiw+xBrPGIfBheDQ
         IfjkK1M72g4GufsaGlwrxujDaZknsVWc9Koy/LaSV4MGnmrCJaXXgj65dbWbtF8yTTnd
         p5TQ==
X-Received: by 10.66.157.135 with SMTP id wm7mr10902187pab.22.1444077377234;
        Mon, 05 Oct 2015 13:36:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id te7sm29219182pbc.87.2015.10.05.13.36.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 13:36:16 -0700 (PDT)
In-Reply-To: <1444075810.5158.7.camel@twopensource.com> (David Turner's
	message of "Mon, 05 Oct 2015 16:10:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279087>

David Turner <dturner@twopensource.com> writes:

> But this is a benchmark of just git_path.  I don't happen to see any
> cases where git_path is taking up an appreciable amount of runtime.
>
> I only added this because Junio requested a speedup.  So I am perfectly
> happy to drop this patch from the series.  

Ok, then let's drop it for now.  Thanks.
