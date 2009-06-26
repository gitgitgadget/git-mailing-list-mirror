From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 5/8] gitweb: gravatar url cache
Date: Sat, 27 Jun 2009 01:27:50 +0200
Message-ID: <cb7bb73a0906261627i1a32bef1h3833d1c12a12e759@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906270111.26640.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 01:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKKpv-0002ZM-7w
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 01:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbZFZX1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbZFZX1u
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 19:27:50 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:45311 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbZFZX1t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 19:27:49 -0400
Received: by fxm9 with SMTP id 9so2381469fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A/T6OXX6qOusn3W+Ptdmhq4DnoZodocNJk7uJF8Gx+c=;
        b=sYRB+4AtgBaQEORDUaCxorPv+ms0iCJyHMbay2OFQgkJ223ojr49SEMdtickOXT8r1
         8wjx9TSBuF59fLi5LvR67+7x5Nenp/jBlqBAydlWgvTQtFJZdjvdPT1KHxzzO4/wxkbC
         Qlhb3Down4jnWHXkdJcw28yHMiO5f75p9IA48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BNII/bd8UNzCv31uTz47caoAPx04gLi+iZKH1D90lhceiKniLFxN70cF8S/0avQPI3
         mrivC0YM/1Z1xeRe6MeiDpf7i+TSWXVLXf1HDkOvEwHUynyqok9QLl3PrabiNJY9mXlI
         0s3mMoR5RRKLYbmitPicQbfveNgPBcmo2PdWg=
Received: by 10.204.65.1 with SMTP id g1mr4193902bki.57.1246058870491; Fri, 26 
	Jun 2009 16:27:50 -0700 (PDT)
In-Reply-To: <200906270111.26640.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122335>

2009/6/27 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 25 Jun 2009, Giuseppe Bilotta wrote:
>
>> Views which contain many occurrences of the same email address (e.g.
>> shortlog view) benefit from not having to recalculate the MD5 of the
>> email address every time.
>
> It would be nice to have some benchmarks comparing performance before
> and after this patch.

Indeed it would.

Oh, you mean I should provide them? 8-D

(I'll see if I can get around it this weekend)

> I guess it is not worth it to _not_ use cache for few avatars views
> such as 'commit', 'commitdiff', in the future also 'tag' view, isn't it?

I would say not.

> BTW. http://www.gravatar.com/site/implement/url recommends
> http://www.gravatar.com/avatar/3b3be63a4c2a439b013787725dfce802 rather than
> http://www.gravatar.com/avatar.php?gravatar_id=3b3be63a4c2a439b013787725dfce802
> you use, following http://www.gravatar.com/site/implement/perl

I think the perl code there is just obsolete (the /avarar/ thing is
more recent). I'll update to the new one because it's more compact.

-- 
Giuseppe "Oblomov" Bilotta
