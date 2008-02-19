From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Tue, 19 Feb 2008 01:23:13 +0100
Message-ID: <200802190123.14112.jnareb@gmail.com>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com> <200802190032.36712.jnareb@gmail.com> <7v8x1hom3n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 01:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRGGa-0005HR-Bb
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 01:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbYBSAWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 19:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbYBSAWl
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 19:22:41 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:52218 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbYBSAWk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 19:22:40 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2105441fkz.5
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 16:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=ErQ+Sa9vDT3IoowrlRZ3Zk9ZIWjoHSXkrzLlqtEWR1w=;
        b=w1/oeVyhd2o+Mdpo855EuNqdhzkC2ef9zAxz8KrDD6sTxwu23bBAcUW6owr7iVc3ng0msPBRo260q/bqLQrnQmusCBxsYy+Tt8hrV8TiGKj7kTKEYN99V6GQdEzCrWyQ/WYNRc9nGg2yWopi2+jNSUOpUMe6gMwk3KJ8yVjEz8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NGN6aLnc/i5whe1Jur5gb04k2wr3+Jp8oinrQ1MvRlpb9WzpYUo9qLPUA3l48W8yoNIJeR4hZLEkHEI5+oLmUelrqhsbWIuMc+aiDr1AFzmrwm7JiZFGdfo3MOFNtaKdfNJwC8juSPvfVnjKj+SfA0yHGMoiyP12X4Pl70ju5nY=
Received: by 10.78.182.17 with SMTP id e17mr10301718huf.62.1203380558400;
        Mon, 18 Feb 2008 16:22:38 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.224.67])
        by mx.google.com with ESMTPS id f8sm16283974nfh.13.2008.02.18.16.22.35
        (version=SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 16:22:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8x1hom3n.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74360>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Junio, would you consider applying one of those patches? Any of them
> > should fix the bug; the second one is less intrusive.
> 
> Surely.
> 
> By "the second one" do you mean this one?
> 
>     Subject: [PATCH] gitweb: Add new option -nohtml to quot_xxx subroutines
>     Date: Sun, 17 Feb 2008 18:48:13 +0100
>     Message-ID: <20080217174812.30454.86822.stgit@localhost.localdomain>

The above is purely meant to further enhance 850b90a51d5
  gitweb: Fix displaying unchopped argument in chop_and_escape_str


No, I meant:
  Subject: [PATCH] gitweb: Fix bug in href(..., -replay=>1) when 'pathinfo' feature used
  Date: Thu, 14 Feb 2008 09:22:30 +0100
  Message-Id: <200802152216.42533.jnareb@gmail.com>

It is inside other email (Re: gitweb bug: broken "next" and other links),
so I can resend it...

-- 
Jakub Narebski
Poland
