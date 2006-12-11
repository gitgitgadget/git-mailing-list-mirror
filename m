X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: stgit: No patches to pop
Date: Mon, 11 Dec 2006 23:54:52 +0100
Message-ID: <200612112354.53124.jnareb@gmail.com>
References: <7ac1e90c0612110632x56a2917cu4db33e47923f34c2@mail.gmail.com> <elk0c3$ovu$1@sea.gmane.org> <b0943d9e0612111426s3e0c671eqca31558e47d4348b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 22:52:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jyb/j/+aHu7ESWDYl3bCiohWMg8/IR/Wa/nXjwZUOOx2X9HHfXKW4oFHK+ZLDpr7IZOyctaTVyy5PkYs2QziNwnDZs+Zi7FN3CpPpiSzqhIwa7Xgjn2vXcNdVFUSvSTiFjZGYysCB/FfkQ+Wr+M3gMV0AqG2wTnzBD0CRgrRj70=
User-Agent: KMail/1.9.3
In-Reply-To: <b0943d9e0612111426s3e0c671eqca31558e47d4348b@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34048>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtu0k-0006HJ-4l for gcvg-git@gmane.org; Mon, 11 Dec
 2006 23:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750699AbWLKWwf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 17:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWLKWwf
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 17:52:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:2236 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1750699AbWLKWwe (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 17:52:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1479976uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 14:52:33 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr10680466ugm.1165877553131; Mon,
 11 Dec 2006 14:52:33 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 5sm6091319ugc.2006.12.11.14.52.32; Mon, 11 Dec
 2006 14:52:32 -0800 (PST)
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas wrote:
> On 11/12/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Catalin Marinas wrote:
>>
>>>> I also get things like:
>>>>
>>>> % stg pop second
>>>> popping patch "third"... done
>>>> Now at patch "second"
>>>
>>> In version 0.11, the "pop" command is equivalent to "goto". I changed
>>> this in the latest version (in the StGIT repository) so that "pop
>>> <patch>" tries to only extract that patch from the stack by popping
>>> all the patches to the given one and pushing them back without the one
>>> you specified. It also supports patch ranges (i.e. patch1..patch4).
>>
>> That is kind of strange. Pop should work like pop does, for example
>> the one in Perl or Python, removing n elements from the stack of applied
>> patches. Not work as "float <patch>"...
> 
> Probably I wasn't clear enough. The "pop" operations are as follows:
> 
> 1. "stg pop" only removes the top patch from the applied patches
> 2. "stg pop <patch>.." is equivalent to popping all patches to <patch>
> (including the latter)
> 3. "stg pop <patch>" is equivalent to "stg float <patch>; stg pop".
> 4. "stg pop <patch list or range>" is equivalent to "stg float <patch
> list or range>; stg pop <all the patches in the list or range>"
> 
> These feature was Yann's idea and I find it to be more in line with
> the "push" command.

Nice, and easy to understand. By the way, the same works with "stg push",
doesn't it?

-- 
Jakub Narebski
