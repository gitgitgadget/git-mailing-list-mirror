From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] mail: Use space rather than tab for long header 
	folding
Date: Fri, 12 Feb 2010 16:15:19 +0000
Message-ID: <b0943d9e1002120815n69691e63p80146f9dcd5ff68c@mail.gmail.com>
References: <20100212153905.11578.83879.stgit@pc1117.cambridge.arm.com>
	 <b8197bcb1002120809q5eb458f7pa9e9b0562af6bcda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 17:15:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfyB0-0003Mx-9v
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 17:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756859Ab0BLQPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 11:15:25 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:60980 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab0BLQPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 11:15:25 -0500
Received: by fxm20 with SMTP id 20so2476338fxm.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 08:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Cpa9r8YFqgAjBh+ouMtRR44wU8+JcSwP3mRxFur81LA=;
        b=MiNqQ0Cwhcnb5MtUWR5gdhiwauJOT4ojCWda8SZU3UM3Insi8lTUaMwF+7LvHv6y/2
         4J7PBd9cOGj9WZrwBe9ZVadFz9noW8ZbqwuQgkeLR+PyJjKLjhSablm+MVOMruVBbs9Q
         OyhxrRHwAiuP9/bjIULcgJGEkteEFd4WTn/XM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=eqk3bSDDfCuPO92aEjndHH5YQQTImYJ7+jkr10I6dfjRu4fUgVtMdHfhPuF98WIbJp
         dL8OjhyYlObXDXaq8Hd24tw/zBrwLHiIP/oy2Gax+AtIYx09PLBii9Vh5CqrYBde8gtK
         tX6PZ4h6va0KT8RTJBu05cv6/L/JFLULKGYL8=
Received: by 10.223.5.17 with SMTP id 17mr1839461fat.0.1265991319196; Fri, 12 
	Feb 2010 08:15:19 -0800 (PST)
In-Reply-To: <b8197bcb1002120809q5eb458f7pa9e9b0562af6bcda@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139720>

On 12 February 2010 16:09, Karl Wiberg <kha@treskal.com> wrote:
> On Fri, Feb 12, 2010 at 4:39 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>
>> The default Python implementation (at least 2.5 and earlier) fold long
>> e-mail header lines by inserting "\n\t". This causes issues with some
>> e-mail clients that remove both "\n\t". The RFC2822 shows that folding
>> should be done with "\n ". The Python workaround is to use a Header
>> object instead of a string when setting the message headers.
>
> Aha. If this works like I think it does, it'll eliminate the problem
> where patches with long subject lines pick up tab characters when
> imported from e-mails. But that's not the motivation you're
> describing, is it?

My main motivation is only for sending e-mails as I have an Exchange
server here which removes the tab completely sticking two words
together. If you import an e-mail sent by the patched StGit, yes, it
will solve this as well.

-- 
Catalin
