From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: Re: [PATCH] rev-parse --show-prefix: add in trailing newline
Date: Tue, 10 Apr 2012 07:30:49 +0200
Message-ID: <4F83C589.20609@gmail.com>
References: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com> <7v1unwwwov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:30:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTfC-000271-1F
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab2DJFa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:30:29 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37256 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab2DJFaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:30:23 -0400
Received: by wgbdr13 with SMTP id dr13so4721487wgb.1
        for <git@vger.kernel.org>; Mon, 09 Apr 2012 22:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=dprQoGr799tXRIxnRF9uonqWjm7hSjOFx7f6GgAjqW8=;
        b=l6wuXSlQufcQjIgshqOuLH5bAf90zC/iOjBbP3FtUheZ2g13WnNaYy/nsrQf7r2/7e
         WB9aWI1ukCTmzXXKJdI94TT064+NZWUOlBFZEFnGKRJy0qPVj7BS9wk5QcdbY+PUyNVg
         xQoWp945WR/yhwHnJgRWWEDQnBo9bfh12tBP5yG6B9vkjtWIw7TgIjMuAkoJ+95sb5W9
         Bz2b4GyS3eJvI41EXUpkVQfa8n/liGcyNNsRwIjd5ciHVRhUb9pWF7IhMtRF7o+0FnZY
         V27/ohjJqZQCc4D0JtwxUyMrJb0QhyEsWePe1Ew6dEaVm0ascFW5FhmVIGweoAUBkE/f
         W7LQ==
Received: by 10.180.89.130 with SMTP id bo2mr3669680wib.17.1334035822476;
        Mon, 09 Apr 2012 22:30:22 -0700 (PDT)
Received: from [172.16.1.122] ([196.211.61.34])
        by mx.google.com with ESMTPS id ev10sm14921502wid.10.2012.04.09.22.30.19
        (version=SSLv3 cipher=OTHER);
        Mon, 09 Apr 2012 22:30:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <7v1unwwwov.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195057>

On 2012/04/09 21:07, Junio C Hamano wrote:
> fc68875 (t1501 (rev-parse): clarify, 2010-07-24) says it is a "possible
> bug", but I do not think the expectation of the new test added by that
> commit is entirely correct.
>
> Because the assignment will strip the trailing LF away adding an extra
> newline at the end would not matter in practice in many scripts, e.g.
>

True, and the current behavior does exactly what the man page says:
"When the command is invoked from a subdirectory, show the path of the 
current directory relative to the top-level directory."

So then perhaps the test should be removed?

Also, --show-cdup has a similar description for the man page but does 
output a newline when invoked from the root dir. Should this behavior be 
made consistent?

-- 
Ross Lagerwall
