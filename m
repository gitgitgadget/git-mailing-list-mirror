From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #01; Wed, 4)
Date: Thu, 5 Dec 2013 09:01:09 +0700
Message-ID: <CACsJy8BR-DPSxdNzJupHsktP1nPW79TJ_8N__xfOaAdP4MBp5g@mail.gmail.com>
References: <xmqqiov4hz07.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 03:01:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoOG9-0007pF-RE
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 03:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933402Ab3LECBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 21:01:42 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:35726 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756337Ab3LECBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 21:01:41 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so7285579qac.14
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 18:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/YLhmFX59oMidTz9cnRrR22n/KxtUv/LlsJUnwzruRU=;
        b=rcgq3KGJxOGJ+dHv8rS1r5WCjjdkwxVKNq4rC4gPKZQxXdXvRzF/CdGJ2sHVdeoucU
         zdsxqDWXtDIJMTfVHwk0hF0HAKp4WUL/q9SOevqJs9a+CXOUBwdAg3OlpBH9M+sQtCe2
         KHufUyV6V0oO7+IrGeAkKbFoRJ4hUaerZW1oVPYZ2PT+R02qoQitkohaMQFqjQPix+2/
         OnvTc5giUnwpoeFvY/pzzs8vbS1fdhGgSzT7PybdcwC1jWTXL0O47wJsnBM/YfQaFq0Q
         YmBUoYND8ZlTt2qC6ME3yxPqjjPIYrUt4TUiS24z03TZCRxjieIyGZlP1HnbV/CnJM5C
         Vgig==
X-Received: by 10.224.24.131 with SMTP id v3mr140723766qab.48.1386208899642;
 Wed, 04 Dec 2013 18:01:39 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Wed, 4 Dec 2013 18:01:09 -0800 (PST)
In-Reply-To: <xmqqiov4hz07.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238837>

On Thu, Dec 5, 2013 at 8:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * aa/transport-non-positive-depth-only (2013-11-26) 1 commit
>   (merged to 'next' on 2013-11-27 at b01f05b)
>  + transport: catch non positive --depth option value
>
>  Will merge to 'master'.

Don't. It breaks smart-http [1]. I'm starting to think catching this
at fetch/clone level is probably better. But I need to add a test case
to exercise this backfill_tags code in smart-http first.

[1] http://thread.gmane.org/gmane.comp.version-control.git/238714/focus=238720
-- 
Duy
