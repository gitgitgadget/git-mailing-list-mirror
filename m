From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: Submodules
Date: Tue, 7 Aug 2007 16:31:57 -0700
Message-ID: <a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
	 <Pine.LNX.4.64.0708072349400.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 01:32:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIYX6-0003gB-5g
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 01:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbXHGXb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 19:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756639AbXHGXb7
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 19:31:59 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:59317 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317AbXHGXb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 19:31:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1777543rvb
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 16:31:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hkjw9PVgZFE/i1Wnv1VKqKMriRZAiYwM6CkFK6V6h7gIW58nB5Q/9ZGfMRKKPVcsmqggMQsD6F9ORWoUKVW783bgw4NCUbddZecKHdM0fhYBBcZ2W2Y3cC79HeAZ1ygbGDibvyrno9X3eLrzTR7Suo9a5+lGU4BILLHnbAYsyh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HjTdE6TdwYjyu4KBaifVyLLi+QWRZolPYfHVdpZo3IE5e8N6A8jLjl3kE9IDk0GmJEQnXizmP8p6dShf+P9RydnACNHaUyQJqftCwp14t9WUvB1jTqP0Q55ubrKXFyboJkiLsIDQ3yM6oBD9ICCuyZ2VsNjDqld/5Bg3N4OhoRM=
Received: by 10.141.76.21 with SMTP id d21mr2746838rvl.1186529517634;
        Tue, 07 Aug 2007 16:31:57 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Tue, 7 Aug 2007 16:31:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708072349400.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55287>

This is exactly the level of details I'm talking about:
* how come sumbodules are not initialized when I do a clone of super.
I expect to be able to build super after I clone it. Is there a new
(undocumented) flag to clone?
* is it OK to *not* init a submodule? will super become unhappy? Can I
do commits to super in this case?
* why submodules should be listed in 2 places: in .submodules and in
super/.git/config?

- Dmitry

P.S. There is an old saying "One fool can ask so many questions that a
thousand wise man would not be able to answer" :-)

On 8/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> completely forgot: submodules do not need to be checked out.  So, if there
> is a submodule you are not interested in working on, you can leave it.
