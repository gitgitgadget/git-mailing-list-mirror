From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/1] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 13:59:57 +0200
Message-ID: <200610241359.57389.jnareb@gmail.com>
References: <200610230037.57183.jnareb@gmail.com> <200610240008.08325.jnareb@gmail.com> <20061024114923.GD20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 13:59:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcKwe-0006D8-KZ
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 13:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWJXL7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 07:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWJXL7p
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 07:59:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:15480 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030360AbWJXL7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 07:59:44 -0400
Received: by ug-out-1314.google.com with SMTP id 32so175657ugm
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 04:59:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f2ndEt9v+vtl1d+mDe4U4OxUSUv65/lR1ePMy/+KVTDGtdV2+h7qIFXtdES+u0QeE+TBRWxsnOvzIVgUG573QR+pTPs7Vb7AhjhpSWwTcK/ipeY3Y8dkFJCM9X8ZhBSvHaMEI6SIWfQbCq4wGKuEnQeET7aX6Buj2KuK0DgdaWg=
Received: by 10.67.24.13 with SMTP id b13mr8646933ugj;
        Tue, 24 Oct 2006 04:59:37 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 34sm481752uga.2006.10.24.04.59.37;
        Tue, 24 Oct 2006 04:59:37 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061024114923.GD20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29974>

Petr Baudis wrote:
> Dear diary, on Tue, Oct 24, 2006 at 12:08:08AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> Use fixed string instead of shortened SHA1 identifier of commit
>> as a name for "mext" link in commitdiff view.
>> 
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> 
> So I've read what the patch actually does this time, and I really
> dislike it.
> 
>> Junio C Hamano wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
[...]
>>>> For commitdiff for one merge commit
>>>>   (merge: _commit_ _commit_ ...)
[...]
>>>> where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
>>>> display, everything is perhaps unnecessary esc_html on display.
>>> 
>>> I always hated gitweb diffs that prefix each filepair with their
>>> full 40-byte SHA-1 blob object names.  It just adds noise to the
>>> output without adding any meaningful information.
> 
> I agree, using the shortened SHA1 would be definitely an improvement
> here, but

I'm planning on revamping gitweb diff output. Any ideas?

>>> Would it even be necessary to use any SHA-1 name in these cases,
>>> I wonder.  Would it make the page less useful if we replace all
>>> of the above _commit_ with a fixed string, say, "parent"?
> 
> I really disagree here - what's the point of not using SHA-1? The extra
> string carries zero information in comparison with the previous state
> and I just can't see how it *improves* stuff. If you're walking in a
> maze and making marks on walls, it's still more useful if you have
> corridors named by "A", "B", "C", "D" on junctions if you sometimes want
> to walk back to the marked corridors.

That's why instead of resending the patch/amending the commit, I have
put changing shortened SHA1 to constant name in new patch.

By the way, because those links to parents commitdiffs are just ordinary
links, you can see when those links are visited.
-- 
Jakub Narebski
Poland
