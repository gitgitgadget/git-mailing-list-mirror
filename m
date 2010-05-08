From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Sat, 8 May 2010 16:08:20 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005081600490.3711@i5.linux-foundation.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 01:10:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAtAb-0008La-Sk
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 01:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab0EHXKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 19:10:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53606 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750868Ab0EHXKo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 May 2010 19:10:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o48NAJj0001132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 May 2010 16:10:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o48NAIjW007426;
	Sat, 8 May 2010 16:10:19 -0700
In-Reply-To: <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.945 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146685>



On Sun, 9 May 2010, Eyvind Bernhardsen wrote:
> 
> Heh. How about "localcrlf={true,false,native}"?

I really don't understand that. What would it even mean?

An you _do_ realize that like it or not, we already have "crlf=input" as 
the syntax in our .gitattributes files? So that exact syntax already 
exists in one place.

As mentioned, I really can understand people not liking the name, but we 
already _have_ that name, and that syntax. I think it makes more sense to 
try to have a unified syntax than have two different strings for the same 
thing.

So I think we'd be better off with good documentation with a couple of 
real examples (and easily findable), so that the naming is at least 
something people can look up and see the semantics for. The "eol" vs 
"crlf" thing is just bike shedding, and we already ended up with "crlf". 
In contrast, making docs understandable is more than bikeshedding.

			Linus
