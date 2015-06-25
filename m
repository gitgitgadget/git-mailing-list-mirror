From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] refs backend preamble
Date: Thu, 25 Jun 2015 06:19:25 -0700
Message-ID: <xmqqpp4k0vtu.fsf@gitster.dls.corp.google.com>
References: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 15:19:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8741-0007Y3-6x
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 15:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbbFYNTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 09:19:30 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36596 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbFYNT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 09:19:28 -0400
Received: by iecvh10 with SMTP id vh10so54149844iec.3
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bd7syrlWR0ZJIHvV56xIV3i3dUgzCN5VS+TAJuk/W+k=;
        b=o+8NNeshATk37RCe4SamoYSsJ4wJKImt6sVs0bcSaWAPB/T5Xr3mi23/wBiJpWJ9ri
         tZ7dhRefBTO69DkfU62894pdO9p4cHHL2Z0FOnmsXAOwjuFbpigtjLn/7yJOcwqpJyhd
         FrzXatizhQpUSPgiEcz0VYq1v7wbhSksVtVt40AW2ggSVt1iacraaU6yY48lWorS2qic
         nAvBPDJb1HnNI22kQYuMe5Mc1fbZ7NOLnH1qWt0rJOvVnedWy/IQPu6UM8Zx1qST+svU
         081CENHQ3X14ulMMaNtt8v+PpfPzAy1dbdr0OujLzvXzvOdgV7CxdRHIm5DiwItkBtwN
         fofA==
X-Received: by 10.107.14.65 with SMTP id 62mr48893464ioo.67.1435238368228;
        Thu, 25 Jun 2015 06:19:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id eg3sm1509813igb.0.2015.06.25.06.19.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 06:19:27 -0700 (PDT)
In-Reply-To: <1435173388-8346-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 24 Jun 2015 15:16:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272675>

David Turner <dturner@twopensource.com> writes:

> This set of patches is a preamble to pluggable ref backends.  The
> intent is to use the ref infrastructure for special refs like
> CHERRY_PICK_HEAD where possible, and to use git plumbing commands to
> access refs and reflogs instead of directly writing files to the .git
> directory.
>
> This series is on top of pu at 9039c98c.

I won't queue this for now but will read and comment.

Thanks.
