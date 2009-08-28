From: demerphq <demerphq@gmail.com>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 18:12:41 +0200
Message-ID: <9b18b3110908280912o271dc095o67bc82b31e91680e@mail.gmail.com>
References: <vpq7hwo8gxd.fsf@bauges.imag.fr> <4A979690.1050601@gnu.org>
	 <vpqk50pasek.fsf@bauges.imag.fr>
	 <9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com>
	 <7v1vmxq6nw.fsf@alter.siamese.dyndns.org>
	 <fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com>
	 <20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: seanh <seanh.nospam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 18:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh44I-0007pd-KG
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 18:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbZH1QMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 12:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbZH1QMl
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 12:12:41 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:31106 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZH1QMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 12:12:40 -0400
Received: by ey-out-2122.google.com with SMTP id 4so53781eyf.5
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=aVNsUEFVIKzRIczr7ogIkt3P/c3EbypRNkKoe7hiuUE=;
        b=fGc+QYSs7ULgKbvkEfYy+zjLqKBmR2PjsE7D5BOqbfs4rqwcdjZwAaK5KeXKUzE2QT
         JhYwuEBb+FtblUD65fQ7FMBKhvPJUKSA56DEvVKyb2Exj3hM4F5NzmEKiVwavZ1WzgPk
         ci8qhW7fWjBx1mQk7Vfw0mR6t/QQS6XSGty0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=f1V8txPuQmAGG5akuqZMgt3kQzp0OX/cOw6AWDj7CKsYHFc8pVrNSwDhTgdpA5rVab
         jdqFlmGAMmOrEkQb2t0N+KQ5rgBu90soT+GBvA1PzYpR/MAc8mMteu5F7vRUKyk4stS7
         5YRmvV92q7He0+nwgEXklkHlcg5BMJpsDf75k=
Received: by 10.216.52.76 with SMTP id d54mr276390wec.119.1251475961792; Fri, 
	28 Aug 2009 09:12:41 -0700 (PDT)
In-Reply-To: <20090828133708.GA11146@kisimul>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127308>

2009/8/28 seanh <seanh.nospam@gmail.com>:
> On Fri, Aug 28, 2009 at 12:21:42AM +0200, demerphq wrote:
>> As you can generate the PDF's from the latex then just hack gitweb to
>> let them download it from there.
>
> Unfortunately gitweb is written in Perl. But I know what you mean, it
> should in theory be possible for them to click on a 'Get PDF' link for a
> particular revision that causes the PDF to be built and returned to
> their browser.

What is unfortunate about that? Perl is a duct tape/swiss-army-knife
of the internet.  Hacking gitweb to generate PDF's on the fly from
latex documents should be a fairly trivial hack, even if you aren't a
Perl hacker.

See:

http://search.cpan.org/~andrewf/LaTeX-Driver-0.08/lib/LaTeX/Driver.pm

for just one of many Perl modules to interface with with LaTeX.

Good luck.

Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
