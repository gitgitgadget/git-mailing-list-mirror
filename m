From: David Shen <davidshen84@googlemail.com>
Subject: Re: ignored files stilll listed in git ls-files
Date: Fri, 6 Mar 2009 22:02:03 +0800
Message-ID: <53e35fd50903060602n2573217evcd48fdf822adf972@mail.gmail.com>
References: <53e35fd50903041731v1a3c10c9sbb9295f322a819ce@mail.gmail.com>
	 <20090305090953.GB30445@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 15:03:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfaeI-0005bk-Dv
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 15:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbZCFOCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 09:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZCFOCJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 09:02:09 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:25192 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbZCFOCI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 09:02:08 -0500
Received: by yx-out-2324.google.com with SMTP id 8so269769yxm.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 06:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dieNVenY4PeybJ9YR2KZ8iK9Pet91qGpzBAzpVpJFJM=;
        b=lADWkF5ssGkcnAFXYMtCSaVaoRLESxzcbyCyiQBh2uchjXZwf4AaM2tZ3IfoiGrNdW
         3b7L8A+0KIjC/ijA2v5OPE06DtbdYeOhyJKbGejcpvZm6NWftykzTEZiP8tBh3ENk8zW
         sSvCu/I2va0VpSqASZK8RK1T006QptDbsLo04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T8S9/enHem8eUOMSal8nDHyfk7qJsCBXFf6FhYpoZVYY0WridFoMYCq0guujWmAorY
         XKEXf3+LmLzRoAGjoGHsiOZBEh3jVP+NXHMyN+h73nRvaTm3uuvzRe2+oUnD7WecMkyM
         CwqTHUu5BzfBzxpGjvZZ/dNGBnR2nn3mup3pQ=
Received: by 10.143.3.4 with SMTP id f4mr1109700wfi.299.1236348123568; Fri, 06 
	Mar 2009 06:02:03 -0800 (PST)
In-Reply-To: <20090305090953.GB30445@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112439>

Thanks for replying.

My command was not correct. And I solved my problem with the help from
someone else.

But my problem is only solved on Linux. On my winodws machine, I have
added a lot of unwanted file to my git repo, before creating
.gitignore file. I ran 'git rm --cached myfile' to remove it from the
index. But they still exist in 'git ls-files', because they exist in
the history. On Linux, I can use 'git filter-branch' to remove them
from history. But, on windows,

On Thu, Mar 5, 2009 at 5:09 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 05, 2009 at 09:31:55AM +0800, David Shen wrote:
>
>> I add all the files to git before I learned the .gitignore file. Then
>> I remove those unwanted files from the index. But those files still
>> appear in git ls-files. This is really annoying. Is there any want to
>> prevent those ignored files from git ls-files?
>
> If they are appearing in "git ls-files", then you didn't actually remove
> them from the index. Can you show us exactly which commands you ran,
> what output they produced, and how it differs from what you expected?
>
> -Peff
>



-- 
Best Regards,
David Shen
