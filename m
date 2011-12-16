From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: migrating from svn: How to clean up history?
Date: Sat, 17 Dec 2011 00:11:08 +0100
Message-ID: <CAEcj5uWVUZ1BiGN3Aj=i9-tWo-vmBPcGyQzq8vGy-qsMpZu9Ug@mail.gmail.com>
References: <4EE766D5.5040702@goebel-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Hartmut Goebel <h.goebel@goebel-consult.de>
X-From: git-owner@vger.kernel.org Sat Dec 17 00:11:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbgvs-0006Im-HV
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 00:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab1LPXLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 18:11:12 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:57525 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab1LPXLL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 18:11:11 -0500
Received: by werm1 with SMTP id m1so653854wer.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Tf7C3wo6qC1a7+VvCpchOeZ51pB1+pH20vKUt5SkMUI=;
        b=fPQ3qF2YyRKhjR0SiJM28nF5W+sXcEiRuOSt8cnr0+9vMBd41C3zEAF58R6gBcJfKs
         fzjw83HjGn6ICv5gB+4qtLOJZne78HS+vFFUaXXApv5/Y1k2vlG/ov6zp+/QyiyFWFYg
         ag88+xwu4MkkVaOy+nNoyO/j90ABDMRWqr8Hc=
Received: by 10.216.138.201 with SMTP id a51mr4757330wej.24.1324077069054;
 Fri, 16 Dec 2011 15:11:09 -0800 (PST)
Received: by 10.223.88.18 with HTTP; Fri, 16 Dec 2011 15:11:08 -0800 (PST)
In-Reply-To: <4EE766D5.5040702@goebel-consult.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187333>

> I already did some experiments with `git filter-branch` without success. (I manage renaming the tags, though.)
>
> Any hints how to to this clean-up?

There are some examples of how to use filter-branch to remove empty
commits, and some other handy tips on this page:

http://thomasrast.ch/git/git-svn-conversion.html
