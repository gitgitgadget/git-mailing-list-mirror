From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [patch 00/15] Portability Patches v3
Date: Tue, 16 Mar 2010 07:18:48 +0100
Message-ID: <fabb9a1e1003152318m204f178cpbe9eb82cb2742586@mail.gmail.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 07:19:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrQ7f-0001Nc-Cl
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 07:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965933Ab0CPGTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 02:19:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:32838 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965916Ab0CPGTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 02:19:09 -0400
Received: by pwi1 with SMTP id 1so2459274pwi.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 23:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ORSTUbF7P/kcj1xqFSn7pq9RZFQcF10Fza4bPIeSoBM=;
        b=B13z1YFvhPqZvDZ7QmwsO/7sFSN7skSMpCbvlSvlBoccwPsvcdSIGk7a3CHx/x2ltM
         HWLRUqANaBP3dtfsUqAj1YCrrlhlDJjCT87Ur0sE+9Yd9hKPCaDzU+A/Iiq3YrW1QJGQ
         E3GgQFSgzKmrjObOwsxctakEnA7K5F+tx9u0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sRdYvCdMJ9DHxtnx9XmvZfUDxldlmd5LF0hlFnXyykbHNukaMtjVY7seVPopoUvMLa
         E5kJUU4TM99ySWZmDYOpq/e9/Z+DCVyu9Vx8zn/dNnutfLRSbCdnJLMihQ6LJCHtGm5A
         PQiM8yLP4dyGrJkUUvyKhqDboC11RHirobsTY=
Received: by 10.143.129.2 with SMTP id g2mr2479848wfn.273.1268720348661; Mon, 
	15 Mar 2010 23:19:08 -0700 (PDT)
In-Reply-To: <20100316054220.075676000@mlists.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142320>

Heya,

On Tue, Mar 16, 2010 at 06:42, Gary V. Vaughan
<git@mlists.thewrittenword.com> wrote:
> Here are the portability patches we needed at TWW to enable
> git-1.7.0.2 to compile and run on all of the wide range of Unix
> machines we support.

Oh wow, thanks! Glad to see you followed up on this, awesome!

> Note that I have not invested the time to figure out why the testsuite
> is mostly useless on everything but Linux and Solaris 8+, because I'm
> reasonably satisfied that the build itself is working properly.

I'm curious now, what kind of errors are you getting? Would you mind
perhaps posting a few to the list in a new thread?

-- 
Cheers,

Sverre Rabbelier
