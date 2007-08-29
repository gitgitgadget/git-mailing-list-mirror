From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: git-svn tags and branches
Date: Wed, 29 Aug 2007 23:06:25 +0200
Message-ID: <cb7bb73a0708291406u5b5257fdh8d503e377209956b@mail.gmail.com>
References: <faulrb$483$1@sea.gmane.org> <86sl64nhc1.fsf@lola.quinscape.zz>
	 <cb7bb73a0708280237v6f248517h183174bc41296df3@mail.gmail.com>
	 <46D4A664.4070007@vilain.net>
	 <cb7bb73a0708281620v41383ed8w728af0112d2a6360@mail.gmail.com>
	 <46D4ECE2.9020806@vilain.net>
	 <cb7bb73a0708290141y159d6bbfj2bac23af5e86bb15@mail.gmail.com>
	 <7v4piisolb.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0708290353iba0bdefl81a4a4e158be2fbf@mail.gmail.com>
	 <7vhcmip05g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>, "David Kastrup" <dak@gnu.org>,
	git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 23:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQUkB-00016g-Id
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 23:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbXH2VG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 17:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbXH2VG1
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 17:06:27 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:9827 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbXH2VG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 17:06:26 -0400
Received: by py-out-1112.google.com with SMTP id u77so2451558pyb
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 14:06:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nwARxKBKwc8xx9uf/Kg8Uac9xsCvdRs+fgAbYVrh2bROjWiaLsXXfEkAnTRfQlDwT/e8C0YPaF3R7LtNCmWzJXMmeZpK3LMXTr29zHuC0ZM+ilsVbxeYCAbkTBGfFHMlyEFgtTw79CyaMv5xX0pqJj/VG+1bhJhIW0Ib4mD/kuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G1GrEpIIW1Np6/n7kfpQgHi1NmJR64nsj8GH9N0RcTsD30MPnEh8lv/IlO2nWbBOp8XpT2ESg27tCgtnU/inFUPbWWxahrONAeetOvbI24kImG/luO3jjIc6dI8CS7FuOom6oaRjXzrJZMkwYSo/2jBQNJbc2r4LOkdrSInAnAM=
Received: by 10.35.68.3 with SMTP id v3mr1278928pyk.1188421585600;
        Wed, 29 Aug 2007 14:06:25 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Wed, 29 Aug 2007 14:06:25 -0700 (PDT)
In-Reply-To: <7vhcmip05g.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56984>

[did it again, sorry for the double-sent]

On 8/29/07, Junio C Hamano <gitster@pobox.com> wrote:
> As I said in the part you quoted, if you have branch foo and tag
> foo, and if you are interested in talking about the tag 'foo',
> you say "tag/foo".  When you want to talk about the branch, you
> say "heads/foo".  Replace "foo" with "name" and I think you get
> your answer.

The problem here is that you can have THREE things: the tag foo, the
branch foo, and the 'branch' under the tag foo, which is not the
branch foo.

-- 
Giuseppe "Oblomov" Bilotta
