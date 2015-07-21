From: David Turner <dturner@twopensource.com>
Subject: Re: What's cooking in git.git (Jul 2015, #05; Mon, 20)
Date: Mon, 20 Jul 2015 20:50:32 -0400
Organization: Twitter
Message-ID: <1437439832.30911.12.camel@twopensource.com>
References: <xmqqwpxuwh8d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 02:50:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHLlU-0002rJ-9f
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 02:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482AbbGUAuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 20:50:32 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34522 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995AbbGUAub (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 20:50:31 -0400
Received: by qkfc129 with SMTP id c129so80827533qkf.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 17:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=HgkmX7VPfc/PPtUmcSbvd/5/Nl559uaDVWT4+3ZhCj4=;
        b=CMDOSyNp+oTeWbpMXM/lkHBjMU9hEP0OyP78Oe/e7CAcbIyqNB+1yaOiVSJHKNbh39
         BpAK7WPbHQvvXo59j9CYvp2rkpUgVXh8DVi68OvpEFOgMBL1LB6EH+dJOKgQSM6VK0yt
         XtA63NByM2G3jTJwsZAh/YbZpFDqNeUxuOCSNiR3Ngs/uNBI7VcoS3Gme7kuoIvQZo+3
         8VosczAjRtuIUpF8HvJJMqg2OtD7ds7bBYix6gLp6pmuxkWLmWLSDuRH91P4LuWOsRp5
         ztUdUxtndKvFnxE+IuSDxGnkL435eZ9xr+U7DAO6Gas7ZVMJ3S1pNtY7hWs4BF96OWQq
         Cung==
X-Gm-Message-State: ALoCoQmNqVVOsr8MT9fli+ylDyPuMMm/bgk9d+SNTR9e9j1/WLxUJAuR8l/8vbJx0Z8Ms89tSfA3
X-Received: by 10.140.17.139 with SMTP id 11mr49768861qgd.65.1437439831072;
        Mon, 20 Jul 2015 17:50:31 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 84sm11823862qha.47.2015.07.20.17.50.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 17:50:30 -0700 (PDT)
In-Reply-To: <xmqqwpxuwh8d.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274365>


> * dt/refs-backend-preamble (2015-07-13) 7 commits
>  - git-stash: use update-ref --create-reflog instead of creating files
>  - update-ref and tag: add --create-reflog arg
>  - refs: add REF_FORCE_CREATE_REFLOG flag
>  - git-reflog: add exists command
>  - refs: new public ref function: safe_create_reflog
>  - refs: Break out check for reflog autocreation
>  - refs.c: add err arguments to reflog functions
> 
>  In preparation for allowing different "backends" to store the refs
>  in a way different from the traditional "one ref per file in $GIT_DIR
>  or in a $GIT_DIR/packed-refs file" filesystem storage, reduce
>  direct filesystem access to ref-like things like CHERRY_PICK_HEAD
>  from scripts and programs.
> 
>  Still under discussion.
> 
>  Will hold.

What's left to discuss on this one? I think the latest version addresses
all concerns, but I'm happy to do another reroll or discuss further if
necessary.
