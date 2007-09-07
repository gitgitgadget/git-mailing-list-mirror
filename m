From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String
 Library.
Date: Fri, 7 Sep 2007 02:12:18 +0100 (BST)
Message-ID: <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
References: <46DDC500.5000606@etek.chalmers.se>  <1189004090.20311.12.camel@hinata.boston.redhat.com>
  <vpq642pkoln.fsf@bauges.imag.fr>  <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
  <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 03:12:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITSOh-0003SU-60
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 03:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbXIGBMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 21:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbXIGBMa
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 21:12:30 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39745 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964903AbXIGBMa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 21:12:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l871CK6K030965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Sep 2007 18:12:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l871CJB3018478;
	Thu, 6 Sep 2007 18:12:19 -0700
In-Reply-To: <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
X-Spam-Status: No, hits=-3.242 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.31__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57960>



On Fri, 7 Sep 2007, Linus Torvalds wrote:
> 
> The fact is, git is better than the other SCM's. And good taste (and C) is 
> one of the reasons for that.

To be very specific:
 - simple and clear core datastructures, with *very* lean and aggressive 
   code to manage them that takes the whole approach of "simplicity over 
   fancy" to the extreme.
 - a willingness to not abstract away the data structures and algorithms, 
   because those are the *whole*point* of core git. 

And if you want a fancier language, C++ is absolutely the worst one to 
choose. If you want real high-level, pick one that has true high-level 
features like garbage collection or a good system integration, rather than 
something that lacks both the sparseness and straightforwardness of C, 
*and* doesn't even have the high-level bindings to important concepts. 

IOW, C++ is in that inconvenient spot where it doesn't help make things 
simple enough to be truly usable for prototyping or simple GUI 
programming, and yet isn't the lean system programming language that C is 
that actively encourags you to use simple and direct constructs.

				Linus
