From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] README: Git is released under the GPLv2, not just "the
 GPL"
Date: Sat, 15 Dec 2012 20:22:50 +0100
Message-ID: <50CCCE0A.40305@gmail.com>
References: <966a27bab02e7deb41ad2268800bfd4a53279a8f.1355499408.git.stefano.lattarini@gmail.com> <7vhanntchw.fsf@alter.siamese.dyndns.org> <7v38z7tb7q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 20:23:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjxKZ-0000qj-Rl
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 20:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337Ab2LOTXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 14:23:03 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61930 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab2LOTXC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 14:23:02 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2205028bkw.19
        for <git@vger.kernel.org>; Sat, 15 Dec 2012 11:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=UuYBnYqITc5Mwp1/E8zNNLpgNQ0W/nb3bkFVWlsr1xk=;
        b=BffmplAhvfMKslG6BRxYtOzwo1ewMxhDEusYezUJTgY3T6EJ2CVncOl/dukx+wtHVf
         G+QdeGTc3mvaL5ulQbLH2gOLv3A+qCc9NWGsSirVhdI4VALhL8u6nnPQy9R582I9Vfcy
         mFO9rm0hXHZGn5Pt3eWOGDBJw/lwbo+n3Jdokd7KvY2bUeQzSUZWXUnhUvkkekaGt3MV
         t2v/IPQTqgFUusYCb6G58eNCGN5L7O9OyGRx/3+R2rZANvrgb12FmmmR2iXhEFIXOBhq
         POhDtI90GHHx3ZsHsed4M7WyGZnNqGLfhxV8a3zQzmAbCftHQBFS3CX9j31/EytH6Ii6
         L1Xw==
Received: by 10.204.12.220 with SMTP id y28mr4314230bky.112.1355599380814;
        Sat, 15 Dec 2012 11:23:00 -0800 (PST)
Received: from [192.168.178.21] (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id q22sm6715262bkv.16.2012.12.15.11.22.58
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Dec 2012 11:23:00 -0800 (PST)
In-Reply-To: <7v38z7tb7q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211560>

On 12/15/2012 07:35 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
>>
>>> And this is clearly stressed by Linus in the COPYING file.  So make it
>>> clear in the README as well, to avoid possible misunderstandings.
>>>
>>> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
>>> ---
>>
>> I have nothing against this patch, but I am curious if you saw any
>> misunderstandings in the real world, or if you are merely trying to
>> avoid "possible" ones.
>>
Only playing safe against "possible" misunderstandings, especially
now that the GPLv3 has taken root and has supplanted the v2 in several
projects (e.g., Perl, and obviously most GNU packages).

>>>  README | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/README b/README
>>> index d2690ec..c50e6f4 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -19,9 +19,10 @@ Git is a fast, scalable, distributed revision control system with an
>>>  unusually rich command set that provides both high-level operations
>>>  and full access to internals.
>>>  
>>> -Git is an Open Source project covered by the GNU General Public License.
>>> -It was originally written by Linus Torvalds with help of a group of
>>> -hackers around the net. It is currently maintained by Junio C Hamano.
>>> +Git is an Open Source project covered by the GNU General Public License
>>> +(version 2).  It was originally written by Linus Torvalds with help
>>> +of a group of hackers around the net. It is currently maintained by
>>> +Junio C Hamano.
>>>  
>>>  Please read the file INSTALL for installation instructions.
> 
> The project as a whole is GPLv2, and inclusion of pieces licensed
> under different but compatible terms does not change it, but we may
> want to do this instead.
> 
> I am just one of the "group of hackers around the net" in the
> context of this overview, so I think it is OK to drop that
> "currently maintained by" bit. The audience of this document does
> not have to find out and interact with the maintainer.
> 
> diff --git a/README b/README
> index d2690ec..c365e3c 100644
> --- a/README
> +++ b/README
> @@ -19,9 +19,10 @@ Git is a fast, scalable, distributed revision control system with an
>  unusually rich command set that provides both high-level operations
>  and full access to internals.
>  
> -Git is an Open Source project covered by the GNU General Public License.
> +Git is an Open Source project covered by the GNU General Public
> +License version 2 (some parts of it are under different licenses).
>
Maybe you could be even more explicit ans state "some parts of it are
under different licenses, compatible with the GPLv2".  But maybe this
is just overkill?

>  It was originally written by Linus Torvalds with help of a group of
> -hackers around the net. It is currently maintained by Junio C Hamano.
> +hackers around the net.
>  
>  Please read the file INSTALL for installation instructions.
>  

Thanks,
  Stefano
