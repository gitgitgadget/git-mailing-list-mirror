From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Git, C89, and older compilers
Date: Tue, 31 Mar 2009 15:22:41 -0700
Message-ID: <56939ADC-AF71-4DB7-94FD-99BE3947ACFA@gmail.com>
References: <9D199AAA-5EC6-4E7C-AC26-0CDA68341D00@gmail.com> <76718490903311432l7fba411fw4a0afff10fdf3da4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LomNY-0006qP-Li
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 00:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747AbZCaWWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755530AbZCaWWs
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 18:22:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:26175 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445AbZCaWWr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 18:22:47 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1797561wah.21
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references
         :mime-version:content-type:message-id:cc:content-transfer-encoding
         :from:subject:date:to:x-mailer;
        bh=3lOpvjx9Au5Btuw/Fb9XQK4dJ3EOS109SNGbEksZy8M=;
        b=Rne6GcFpvbz5fXULiKYNmY4ow3vMc8UdI8XJqF1Vy1PCU8otW0bhKtPP6Bc8Yr3KFN
         m7qCcdUzCES32sbRFOwkgQP6nGSa9oDJVUg/y2uYRvKSobHO8hxM9hsMF14W30+vqQFt
         NnUq9rmVWOkM+6WCAhQbsiN4W1+cjXGJwyYBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc
         :content-transfer-encoding:from:subject:date:to:x-mailer;
        b=s6uxXi343DKoiYJoK7K2jnlK1zWZHFX/5iJFE1ufZnIAY3bwaqS5xemaRKbbuTsDUH
         iqoUXpqWstREtXaCZiA/CTs0ludQanxh7iHqiJTlPiE26jv7wvq6TG6vXULu9FMhJSI8
         oenIXg/F//UDEzp1qdPaXtx0wgX4O/P4tj8/Q=
Received: by 10.114.181.6 with SMTP id d6mr4704161waf.94.1238538165742;
        Tue, 31 Mar 2009 15:22:45 -0700 (PDT)
Received: from ?192.168.1.24? (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id z20sm3748629pod.26.2009.03.31.15.22.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 15:22:44 -0700 (PDT)
In-Reply-To: <76718490903311432l7fba411fw4a0afff10fdf3da4@mail.gmail.com>
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115324>

On Mar 31, 2009, at 2:32 PM, Jay Soffian wrote:

> On Tue, Mar 31, 2009 at 3:26 PM, Joshua Juran <jjuran@gmail.com>  
> wrote:
>> Hello,
>>
>> I'm porting Git to Lamp (Lamp ain't Mac POSIX), a Unix-like  
>> environment
>> which runs in classic Mac OS, much like Cygwin.
>
> Call it morbid curiosity, but, why? (If I had to guess, I'd assume a
> George Mallory answer.)

Well, there's a degree of that.

Even more succinctly, I could add "inertia".  I started writing a  
replacement for Apple's MPW (one that would actually be useful for  
real work) over ten years ago, and never reached a point where I was  
ready to quit, even after switching to OS X.

Admittedly, there's an element of retro-programming.  I want to see  
how far I can go with this.  (One of my major hurdles will be git's  
use of fork().)

But there's also a sense of awe and wonder in knowing that I'm (most  
probably) the only person in the world working on such a project.

Finally, I've begun using it as a research platform.  With  
inspiration from Plan 9, I'm mapping the GUI into the filesystem, so  
you can write an application as a collection of shell scripts.

Josh
