From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 01/22] refs.c: create a public function for
 is_refname_available
Date: Fri, 08 Aug 2014 13:27:53 -0400
Organization: Twitter
Message-ID: <1407518873.26542.20.camel@leckie>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
	 <1407516309-27989-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 19:28:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnxb-00086R-9j
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 19:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbaHHR2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 13:28:05 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:63369 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaHHR2D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 13:28:03 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so7547362pad.25
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 10:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=M9QxkkqxinXqw6imudg38xlTxB/xFEr+6Dzc9Q5N7mY=;
        b=BFM4olL5/fBSaTkKVaLA9aS4AWHTGGwoBENeAiJqDJqzTmRJnyQs9slzPlXiPR3RzO
         Yb1QPiuQ4HUqAwLn0AYQ1ACo9SrNX8ZL9vS5+nFmE0v3UC4+nAKnQZOTU/XRJq5/6qH7
         6IsBk2t1QjMXOAhO/rOhDThSIi4Uo2cS1vapymFuC4JCRNRRxWl1CsHUyU+u/a0oIyfZ
         +kAGxpHZG5R4maqywSr9XFZJnd7AB+e78gZf6VYkdbV4BoZjMRawj9mYjd9gfm9WinBL
         X1izTjM5oiMlpq1lskKZAwdamextO6/Fpaahea1ReiJ/53PYjyuCbHjDG9cJMmHLvnac
         fMgQ==
X-Gm-Message-State: ALoCoQnJclowhyvxRxQEESsuvamNcQy4+NjJ9dI8Iqb1mIsMrD2A4VnmvJnPVRM1A+bPH63eLaXP
X-Received: by 10.68.68.207 with SMTP id y15mr25525375pbt.25.1407518882385;
        Fri, 08 Aug 2014 10:28:02 -0700 (PDT)
Received: from [172.17.131.24] (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id a17sm3587278pbu.41.2014.08.08.10.27.59
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 08 Aug 2014 10:28:00 -0700 (PDT)
In-Reply-To: <1407516309-27989-2-git-send-email-sahlberg@google.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255049>

On Fri, 2014-08-08 at 09:44 -0700, Ronnie Sahlberg wrote:
> + * Check is a particular refname is available for creation. skip
> contains

s/Check is/Check that/'

> + * a list of refnames to exclude from the refname collission tests.

"collision"

> + */
> +int is_refname_available(const char *refname, const char **skip, int
> skipnum);
> +
> +/*
