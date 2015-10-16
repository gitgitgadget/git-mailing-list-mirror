From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] usage: do not insist that standard input must come from a file
Date: Fri, 16 Oct 2015 13:08:37 -0700
Message-ID: <xmqqk2qmefui.fsf@gitster.mtv.corp.google.com>
References: <xmqqvba6ekip.fsf@gitster.mtv.corp.google.com>
	<20151016200452.GA1901@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 22:08:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnBIy-0002an-0X
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 22:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbbJPUIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 16:08:39 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33876 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbbJPUIj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 16:08:39 -0400
Received: by pacez2 with SMTP id ez2so13308280pac.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tgSfqU7GjKEUT7UXLcn/1F06P4lVDfRBHsR2Gu45IjU=;
        b=xAX/7hvPOshSruxD2bSHExLCoxxQDZkocifyJZYTu7QVDQYfThjd3uUOUjuSmyHjAI
         9cUK2DDQuDBwyS7CbM3uMeUDOI4XywD+g8c4FsEMSuJcjpJccQ3SRe/mKdsZd8xza0P6
         WprUx2U/Y+nHk7c48HXnkwM3itXe4CqNS6qKDnQ5iu/mAzqKk/XyoxRHy7oetzODF2Yj
         PUxUXV8kB4AK6eZJh62DRC9B+EI8N/ZiIE9x6E6hMwEyNYdyeSunmFQN9p1Y8mVhrJCF
         BAmcsWQdXf6dtGIgrbZAtAtfaU6Y8Ba/z5e45iPojk8IIqOqeHNI0twjwt4ZKNMnTfaW
         qhJA==
X-Received: by 10.66.165.5 with SMTP id yu5mr18410166pab.109.1445026118764;
        Fri, 16 Oct 2015 13:08:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b1ee:7c8f:ac32:e39f])
        by smtp.gmail.com with ESMTPSA id xg2sm22752800pbb.2.2015.10.16.13.08.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 13:08:38 -0700 (PDT)
In-Reply-To: <20151016200452.GA1901@google.com> (Jonathan Nieder's message of
	"Fri, 16 Oct 2015 13:04:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279763>

Jonathan Nieder <jrnieder@gmail.com> writes:

>>  --stdin::
>> -	Read file names from stdin instead of from the command-line.
>> +	Read pathnames from stdin instead of from the command-line.
>
> Here I have to read the description of "-z" to understand that pathnames
> come one per line.  How about
>
> 	Read pathnames from stdin, one per line, instead of from the command
> 	line.

Thanks, that would be better (and for all the other one-per-line
type of stuff).
