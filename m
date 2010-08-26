From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v6 0/3] rr/fmt-merge-msg replacement
Date: Thu, 26 Aug 2010 10:42:38 +0530
Message-ID: <20100826051235.GA9407@kytes>
References: <1282733330-32334-1-git-send-email-artagnon@gmail.com>
 <7vhbiiqv8p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 07:14:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoUnP-0005mo-0m
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 07:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab0HZFOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 01:14:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50087 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0HZFO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 01:14:29 -0400
Received: by iwn5 with SMTP id 5so1255741iwn.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 22:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PfUD4zAjraK5MgNTEWVnZN0RjmPt4F5clFoCsbUaNaE=;
        b=HRkg+NV1iJY3obzsn0RG5ToWU8Ez1hOh24gl/nHJEw0CB/Vbzn72ng8ZMju+BeBzdB
         VmQ1r9k7+VVhTsdXgb6luiaUjlLJqLgx+jILnxnrsdyN10lzm5I/Kzk/pV1/8ZgT1GuK
         movHbpRU2H/xPXe1YIwl84qiBu04b6sgkPYS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=es8usmU2rQklk5DnAgLTEi3hLxvHSsfLENSh9he9r6mfxikOTgBt4QNGbFpIte5V9R
         TrKtiwff4PFV5lR6FCj5byeZcL5rQom6+0AY2wCwh1F+2n4QTqwGFMXRKj0bg3nAPOpC
         pnNSeZ0Sy1FLKcWVzD++1TIO4Mi3j8fNDOWGU=
Received: by 10.231.146.135 with SMTP id h7mr11423105ibv.149.1282799668908;
        Wed, 25 Aug 2010 22:14:28 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id e8sm2095017ibb.20.2010.08.25.22.14.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 22:14:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhbiiqv8p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154508>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
> > This is a replacement for rr/fmt-merge-msg. It corrects the problems
> > pointed out by Jonathan and adds one extra patch. Additionally, I've
> > rebased it so there's no merge conflict when you merge it into `pu`
> > (see: jn/merge-renormalize). 4/5 from v5 has been dropped.
> 
> Thanks, 
> 
> Just as a future reference, in a case like this that results in trivial
> conflict, I'd prefer to see a patch that can be used independently from
> other unrelated branches.

Oh, okay. I think I realize why- if the dependent topics are ejected,
you'll have more trouble taking this forward to `next` and `master`,
right?

> Maybe you'd want a new test or two in t6200?

Good idea! It'll give me the chance to familiarize myself with
test-lib.sh :)

-- Ram
