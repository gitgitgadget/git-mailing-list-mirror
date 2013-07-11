From: Brian Gernhardt <mister.reus@gmail.com>
Subject: Re: t0008 hang on streaming test (OS X)
Date: Thu, 11 Jul 2013 12:14:39 -0400
Message-ID: <88B02BE0-7E79-4094-A41E-56350425F4EF@gernhardtsoftware.com>
References: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com> <CALWbr2zWVLGNAPFEc7QGjozxXFyuDLD639c=yZkzWhusq1kV8Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 18:14:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJVz-0001uc-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 18:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456Ab3GKQOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 12:14:39 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:65420 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183Ab3GKQOj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jul 2013 12:14:39 -0400
Received: by mail-qa0-f50.google.com with SMTP id l18so4304817qak.16
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=zY+2UONI19SrkyZujxFb/h3ATxvvMOTv7L6DeokGpag=;
        b=OF85XFgDx9ZjIkPFJT3CxgPGwirCESNF9Yh3zM5QfnIESGplaxXZSR/n4b8v8+2d2R
         ry9aFAWwWZtzrGhRBDGAgoslBfWM9HAUgtfOWrzQ2iGsGADTPYIrqYWexVhGZL0ydQUM
         x14CyGFd5UgNmfiVTPMSm7YzQvsfwy1VQqu5Ua9OT1uwqayCyqmODwkpcy+JTkJoyIHg
         LcNUXCmv6pQPTXz9dQcSJ0I0IppBAIjk8eDbUxAF4lWMXf7hLvNt6peKN77dfLGzoqzK
         VpjQozKp1Fr33Gv91Axk5Rel0uKjre6Jcpuk7NY6+oBCwnBKaofjlh0SAMDYHo2t1+i1
         6Tzw==
X-Received: by 10.224.79.203 with SMTP id q11mr34134801qak.35.1373559278438;
        Thu, 11 Jul 2013 09:14:38 -0700 (PDT)
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com. [142.105.190.134])
        by mx.google.com with ESMTPSA id a8sm30417682qae.11.2013.07.11.09.14.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 09:14:37 -0700 (PDT)
In-Reply-To: <CALWbr2zWVLGNAPFEc7QGjozxXFyuDLD639c=yZkzWhusq1kV8Q@mail.gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230113>


On Jul 10, 2013, at 4:35 PM, Antoine Pelisse <apelisse@gmail.com> wrote:

> On Wed, Jul 10, 2013 at 6:36 PM, Brian Gernhardt
> <brian@gernhardtsoftware.com> wrote:
>> I am somewhat stuck on how to fix it.  Any ideas?
> 
> I don't have anything to reproduce here, but usually I start
> investigating this kind of problems by attaching the hung process with
> gdb to see the current state (if it's stuck in a specific state), or
> to investigate the end-less loop.
> That usually help finding a good starting point.

Unfortunately, the hung process is /bin/sh (aka bash).  Using the "Sample" function of Activity Monitor gave me that 100% of the time was spent in libc's _open...  Which enlightens me not at all.

~~ Brian Gernhardt
