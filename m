From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 15:17:43 -0700
Message-ID: <a1bbc6950709071517n7e7e99ffl3dd351092e7f19d6@mail.gmail.com>
References: <46DDC500.5000606@etek.chalmers.se>
	 <vpq642pkoln.fsf@bauges.imag.fr>
	 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	 <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	 <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
	 <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
	 <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com>
	 <46E0F04D.7040101@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Sep 08 00:17:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITm98-0007sy-90
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 00:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270AbXIGWRp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 18:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbXIGWRp
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 18:17:45 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:29372 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbXIGWRo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 18:17:44 -0400
Received: by rv-out-0910.google.com with SMTP id k20so539704rvb
        for <git@vger.kernel.org>; Fri, 07 Sep 2007 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O7mW0WwV1boYv1BwIqhZfYOGmHU5uYDfDuK8xths1Lc=;
        b=fhxKC9cmSZeNoJBomuId9ZRTd56e+WASpjYK16FkvFRfLJ5chvBODNxnAme/r8t6z2A+xa/DmfBemiPU3CRQM1rBgvF07STsebDbzbiI8TfVKU0PPVpiL+PENihx1ObN7kKFhs2pIWICFcDKD9KaLwc5YzrbnrYdo2GbgoMmxzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pjfN3NtqMnjLohzKrrrK07cFWhJ1pzyOs0LoYFXmte39STmVxO3AzUxdhFddvoQ15zcbCFglKSTW+UoNdZfVlvvcS9V/Ekff6YG1GxVhASJ8zuwq9ayPv3K+/wMl8wsM921/CaiwJGT5LTDgyKUMhz+dnjsG9zekBDnB35Qn8qk=
Received: by 10.141.98.6 with SMTP id a6mr468839rvm.1189203463634;
        Fri, 07 Sep 2007 15:17:43 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Fri, 7 Sep 2007 15:17:43 -0700 (PDT)
In-Reply-To: <46E0F04D.7040101@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58086>

On 9/6/07, Andreas Ericsson <ae@op5.se> wrote:
> They already have, but every now and then someone comes along and suggest
> a complete rewrite in some other language. So far we've had Java (there's
> always one...), Python and now C++.

Since this "complete rewrite" was mentioned in multiple emails I'd
like to rectify that:
What I'm offering (for Git) is to use C++ as a "better C".
Don't change any existing *working* code, but start introducing simple
C++ constructs in the new code.
Git is simple enough to not require any high-level abstractions. But
some utility classes could make code much simpler.

And BTW, I don't even like C++ that much :-), I just like it much
better than C.  I've been saying that C++ is a legacy language for
quite some time now. But we will use it for many years to come because
the size of this legacy code is huge, so there will be plenty of C++
developers available (to contribute to Git :-).
And C++ is the only way to move with existing C codebase.
-- 
- Dmitry
