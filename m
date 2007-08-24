From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-daemon on NSLU2
Date: Sat, 25 Aug 2007 01:21:33 +0200
Message-ID: <200708250121.33924.jnareb@gmail.com>
References: <9e4733910708232254w4e74ca72o917c7cadae4ee0f4@mail.gmail.com> <fanmmk$f5q$1@sea.gmane.org> <7vbqcwcze3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 01:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOiTL-0005E5-Sp
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 01:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761683AbXHXXVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 19:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbXHXXVm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 19:21:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:47148 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759388AbXHXXVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 19:21:41 -0400
Received: by nf-out-0910.google.com with SMTP id g13so734234nfb
        for <git@vger.kernel.org>; Fri, 24 Aug 2007 16:21:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SaeJ4GxOZH18zwXGK/Kdfc/pqHydcHazBiL5q7v6rs94VYs167MIfADjWNSwsVP2EV6dAVcZ1KkjF6JnGpJ8B1kTNRX1zCJUAXT3H0nkzUFChMAGxC4bPGv3c+zPdzpfEbk20Rsh/n5IQnypKgU89gOB0eE2yD9zJND/Rk6GdeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VKcq9OjUSuUL8yzMwFJcJdVLNNp+Ne5Hz6/SDoWH8dxVtvjTqNK1vlRfytPis+x0jrAEUF4DK7xHM8qno2PDkSMvw3O7N/CTuMYOmJW6rosAhJ4Etj1jduAZzBKEcFPZjM1U6ZyaW7UmGFiY982YWncjkNIpM9qCNsNjg9G6+/I=
Received: by 10.86.23.17 with SMTP id 17mr2626920fgw.1187997699265;
        Fri, 24 Aug 2007 16:21:39 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 28sm7015585fkx.2007.08.24.16.21.37
        (version=SSLv3 cipher=OTHER);
        Fri, 24 Aug 2007 16:21:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vbqcwcze3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56612>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> There was idea to special case clone (just concatenate the packs, the
>> receiving side as someone told there can detect pack boundaries; do not
>> forget to pack loose objects, first), instead of using generic fetch --all
>> for clone, bnut no code. Code speaks louder than words (although if someone
>> would provide details of pack boundary detection...)
> 
> I have to say that "although ..." part of that statement
> disqualifies this to be called an "idea".

Ermm... if I remember correctly during discussion (single subthread)
there were provided details, or at least idea, of how to separate
concatented packs into individual packs. Unfortunately I haven't
saved the message, and do not remember enogh of it to search archives...

I should have wrote "remind" instead of "provide" there...

> Really, I find that you (yes, in this case I am not generalizing
> but talking specifically about you) tend to overuse the word
> "idea" when you talk things that are not yet even at that stage
> yet.

I'm not native English speaker... ;-)

Seriously, it's a fault of mine...

-- 
Jakub Narebski
Poland
