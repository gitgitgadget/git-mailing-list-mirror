From: Tim Uckun <timuckun@gmail.com>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 23:36:01 +1200
Message-ID: <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
	 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>
	 <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>
	 <4A1671E5.4030400@op5.se>
	 <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>
	 <4A16822A.2060404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 22 13:41:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7T7q-0003Ip-5d
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 13:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbZEVLlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 07:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbZEVLlN
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 07:41:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:57878 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZEVLlN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 07:41:13 -0400
Received: by yw-out-2324.google.com with SMTP id 5so996313ywb.1
        for <git@vger.kernel.org>; Fri, 22 May 2009 04:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C19NCOdItMWQ4mGp8vtf71YCA7U69V6OqfFedQDy+3A=;
        b=mejX5r1CyvLRPS2pFGIMf15gHWyPZ8NjyuEhqCGY6KOnnTP6BeaZOU3V7s4/LRpyoT
         M/1qiZl8YyjH8iEAWyHNFBp8Yh2hjhBPwmL7pbZfYN3nmbaojdIdw0QvzxbXdlHn65ff
         4HfTKY0k2swEo2yfBsdij8GXWdqpfZWsmR1Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ubkd5C516g+ZUUbiV78pnYXXcySzkaMsF28mx0HHe7JUwoaSBqybUxZySwVLHkwBg3
         RGQO4ks4gq4KY5vbRh13zsFYqoQMKsej0MLB+eCxBkEMcDCco6rH7F+AFICPIYYKRP8S
         giPrtasFIIqfSNIfe+4sr6Y/XEW9V3/C9f8fU=
Received: by 10.100.154.17 with SMTP id b17mr7303344ane.45.1242992161890; Fri, 
	22 May 2009 04:36:01 -0700 (PDT)
In-Reply-To: <4A16822A.2060404@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119727>

>
> Did test_new contain ignored files?

No.  I put the entire transcript in the first email. I did not tell
git to ignore anything and there were no .git directories in the test
folder.

> In this case, when you checkout the
> branch that does not have test_new, only the tracked files are removed;
> the ignored (i.e untracked) files remain. Therefore, after the checkout
> you still have a test_new directory.
>

As far as I can tell all the files are tracked after I do a commit.

I can understand why it put the original test directory back when I
changed to the master branch but I don't understand why it's missing a
subdirectory.  I don't think the test_new directory should be in the
master branch at all but I guess I can kind of sort of see why git
might not remove it. What I can't understand at all is why it's
missing subdirectories.

I hate to say this but I tried the exact same thing with mercurial in
the last half hour and it did exactly what I thought it should do. The
master had the test directory but not the test_new and the branch had
the test_new directory but not the test. No subdirectories were
missing out of either one.
