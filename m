From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] send-email: Add sendmail email aliases format
Date: Wed, 27 May 2015 13:08:39 -0700
Message-ID: <xmqqbnh5lr5k.fsf@gitster.dls.corp.google.com>
References: <950e3a77f09d62f77c9a40c843284b3686bdb7b0.1432675817.git.allenbh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:08:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxhd9-0007Wg-UJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbbE0UIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:08:43 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35383 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbbE0UIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:08:43 -0400
Received: by iesa3 with SMTP id a3so22548494ies.2
        for <git@vger.kernel.org>; Wed, 27 May 2015 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Q9PWHOgy8zOjxYvyAYxBovVezmPknyn3wIgpXpQVcuo=;
        b=QJmfq8QTsRFFJRT1AYFLdj9NgLtIdkjo2jkIWyoOfyxnuT/J/rm62MdqMEqftASE7f
         rLb3ZGyN/B8+EjE4Toy/XfHOdajp+Gxt8kQIJOqpx3uQ1e1LeKoN9v8OZeDcs857vKkR
         k9aM9+c9WDS7AkHoSCOQcz4FAKFeumioSqavkqxwZGZOv04rwdCeLBx8qMQet2RS0S8L
         1Cy7C47wBcuoouUS3A/I3VLvH7Eft9RZv8YXYwmo8jZevHeFTnWU8rExEwP7lt4EuM3f
         LcUrx4ITUWXiVEBFl3W54YT4DsCEFPWBcTKV/2e64bOMAMPQdi4s9CGhU3hf0pd/Mi0y
         pPCw==
X-Received: by 10.50.43.227 with SMTP id z3mr6708030igl.12.1432757322244;
        Wed, 27 May 2015 13:08:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id u35sm30319iou.7.2015.05.27.13.08.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 13:08:40 -0700 (PDT)
In-Reply-To: <950e3a77f09d62f77c9a40c843284b3686bdb7b0.1432675817.git.allenbh@gmail.com>
	(Allen Hubbe's message of "Tue, 26 May 2015 17:32:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270078>

Allen Hubbe <allenbh@gmail.com> writes:

> Add support for the sendmail email aliases format.

Thanks.

>     ** Note: A general 'where to find documentation' paragraph will be added
>        by Junio, appearing either before or after this patch in the series.

You didn't have to do this to me; as long as you agree with me that
the paragraph is a good thing to have, it is OK (and even more
preferable) to include it in this patch.

That's called collaboration.

If other person's contribution was really significant and the change
can stand on its own, then a split two-patch series with the author
set to the other person may not be a bad idea, and if other person's
contribution was really significant but the change by the other
person cannot stand on its own, "Helped-by" in the log message would
be sufficient.  My contribution in this case is much less than that.

>     ** Note: A fix to other tests to eliminate the use of tilde for the home
>        dir will be added by Junio, appearing either before or after this
>        patch in the series.

That is a sensible thing to do, as it does not relate to this
change.

Thanks.  Will queue and let's start merging this topic to 'next' and
down.
