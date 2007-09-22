From: David Kastrup <dak@gnu.org>
Subject: Re: C++ *for Git*
Date: Sat, 22 Sep 2007 13:11:19 +0200
Message-ID: <85lkazuf8o.fsf@lola.goethe.zz>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git" <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 13:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ2tX-0007sT-Ge
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 13:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbXIVLL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 07:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbXIVLL0
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 07:11:26 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:47484 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752680AbXIVLLZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Sep 2007 07:11:25 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 6A92E27B6B4;
	Sat, 22 Sep 2007 13:11:24 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 5CFFF2130AE;
	Sat, 22 Sep 2007 13:11:24 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-012-197.pools.arcor-ip.net [84.61.12.197])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 364BF2351A2;
	Sat, 22 Sep 2007 13:11:20 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9B5171CD9E3F; Sat, 22 Sep 2007 13:11:19 +0200 (CEST)
In-Reply-To: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com> (Dmitry Kakurin's message of "Sat\, 22 Sep 2007 03\:42\:00 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4357/Fri Sep 21 11:55:46 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58931>

Dmitry Kakurin <dmitry.kakurin@gmail.com> writes:

> We've had this theoretical (and IMHO pointless) discussion C vs. C++
> *in general*.
> In no way I want to restart it.

Then don't.

> Just a very straight-forward usage of only 3 C++ features:
> 1. Constructors
> 2. Destructors
> 3. Better syntax (ext_header.append_ext_header
> vs. strbuf_append_ext_header(&ext_header, )
>
> The generated code will be exactly the same.

It won't.  It will _do_ exactly the same (modulo the tenfold
likelihood of compiler bugs) but hardly using the same code.

> Yet the source code becomes more readable and MUCH less error
> prone. How is this not a win?

Because it is just your claim that this is more readable.

> One (sensible) argument that I've heard in the previous discussion
> was: you let a little bit of C++ in and then it gets more and more
> complex and the code quality decreases.
> This problem is solved by having "quality gates".
> Again, *for Git* these quality gates already exist: only few people
> have "commit access".
> If/when somebody tries to be too fancy, what stops Junio from replying
> "we don't use Library-X/C++-feature-Y in Git, please change your code
> and resubmit" and throwing that fix away? Nothing.

Well, what stops him from replying "we don't use C++ in Git, please
change your code and resubmit"?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
