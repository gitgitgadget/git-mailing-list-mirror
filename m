From: Nick <oinksocket@letterboxes.org>
Subject: Re: Why are submodules not automatically handled by default or at
 least configurable to do so?
Date: Tue, 27 Oct 2015 11:40:15 +0000
Message-ID: <562F629F.7040206@letterboxes.org>
References: <D4E5E890658.000004DCjohsmi9933@inbox.com>
 <562F5704.5070405@letterboxes.org>
 <EC0D15E1-82B3-4A4C-96DE-8922AB870E2B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Smith <johsmi9933@inbox.com>, git@vger.kernel.org
To: Davide Fiorentino <davide.fiorentino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 12:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr2c6-0000Rh-NE
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 12:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbbJ0LkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 07:40:22 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59514 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753543AbbJ0LkV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 07:40:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 88D6120CEE
	for <git@vger.kernel.org>; Tue, 27 Oct 2015 07:40:21 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 27 Oct 2015 07:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=letterboxes.org;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=nUWvQlpGJD3bZVDKuNZHFA+mv2Y
	=; b=0OhdcBaTt7T3pFzekTE0hm8mX5WJqjuLMaRGv6Ux3r6O2HQkJdjo/NHXQzi
	N5ivckbsCnH+5WobdIk376OZNxAk7PLDOf0WzRJNiPR2Q7WkoFWiURllrAFfwJaN
	AUS4YCKQtjBG3vdHLz55a1pcfYEinrm2gqbXXvCsNylnzypo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=nUWvQlpGJD3bZVD
	KuNZHFA+mv2Y=; b=q+Mnz4J+PsbH88VWLzVS4OaXIRMJui8ky5NmCBOCVszQJUI
	DLDc2Bas0msvGtb7nXbInJxm+p1zupvbGwUHV6jgt57ZCY+N4wVYqBR25+QB5LEf
	PmoXd/0C9iibgOFfU3MOG5pK7EOAU1xTTzAPUQOJRaDWZFtlr2jpCBKhi75w=
X-Sasl-enc: 0OudK82Gs3cWYIYbaG4POpF8oKtWYnCH4FpFkjOtjOPp 1445946021
Received: from [192.168.69.14] (unknown [31.216.5.136])
	by mail.messagingengine.com (Postfix) with ESMTPA id E81A168016F;
	Tue, 27 Oct 2015 07:40:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <EC0D15E1-82B3-4A4C-96DE-8922AB870E2B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280260>

On 27/10/15 10:56, Davide Fiorentino wrote:
> Why not set alias(es) for that?

That counts as a hand-rolled (i.e. ad-hoc) solution.  So not out of the 
question, but I'd rather point my colleagues at something tried and 
tested, rather than simply re-invent wheels, possibly badly.

I'd be interested if there are some out there I could adopt?

But oh yes, there is another difficulty with aliases.  Eclipse users on 
Windows: they don't tend to love it if you tell them to install Cygwin, 
open a shell and type things into it.  The Eclipse experience is 
somewhat fraught already (e.g. EGit running out of memory cloning 
moderate-sized repos, and other UI difficulties). I'd be surprised if 
defining aliases is going to help their user experience.  I'm 
considering suggesting they switch to to IntelliJ, but that's also 
asking quite a lot of people who may be reluctant to relearn their whole 
workflow again, and I'd need to do the research to ensure this doesn't 
just make things more confusing.

Cheers,

N
