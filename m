From: saurabh gupta <saurabhgupta1403@gmail.com>
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 13 Mar 2009 01:33:56 +0530
Message-ID: <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
References: <49B74373.3090609@gmail.com>
	 <7veix33f5e.fsf@gitster.siamese.dyndns.org>
	 <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>
	 <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>
	 <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
	 <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>
	 <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
	 <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>
	 <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>
	 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Mar 12 21:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhrAE-0008Nj-Ij
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 21:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670AbZCLUEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 16:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZCLUEA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 16:04:00 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:22916 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754314AbZCLUD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 16:03:59 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1008790yxm.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 13:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cOwyU38+HVMM1XvZkP7ZpRdELYaQ05KUcStzQaAmKnw=;
        b=LTwo+Sxjc2a9G5nn6jx+JR1JTBem5oLpKOg6z1KjMMiGJP0ntO2kRVS+oYmykTgTbG
         6Xo6JwcwDGCd0BPrfdHuY3qJcDzxIHrkTcvVLUz8xn1OsDjCidtVeoNN/kCvkvc5CbdC
         vDpSKZtizvC6db94KSLHNckNsLTwn24AE5KFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UJY1bVChgXUCAprejxdQbI0blL9KAEqVmShDdwifBM4Fa+quUTSX6uQAneuy3uNB5y
         FlZEMmpCwH3ZfdY4mCoHzU90V0PaF9m3rN97G9M0Ol+gPrCktg+6M7jF1fUbdb62dqcp
         cqlS1e0H69HZegAGYWfOm95YNmgFyZZMH2TLk=
Received: by 10.231.19.204 with SMTP id c12mr90032ibb.55.1236888236850; Thu, 
	12 Mar 2009 13:03:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113119>

On Fri, Mar 13, 2009 at 1:29 AM,  <david@lang.hm> wrote:
> On Fri, 13 Mar 2009, saurabh gupta wrote:
>
>> Very well described, David. I agree with you and providing these merge
>> options to the user, merge drivers can do the work and mark the
>> conflicts according to the option. The work to do is to modify the
>> merge driver. I think in this way, even people who have only a
>> terminal can also gain from it. They can choose the apt option to see
>> the conflict markers in their way. So, the aim is to make merge driver
>> configurable and create the merged/conflicted file according to the
>> options.
>
> for the GSOC I suspect that the right thing to do is the define one or more
> merge drivers to create, and list what applications are going to be used for
> testing these merges.
>
> you and the mentor can decide what is a reasonable amount of work.
>

I will very glad to hear about this thing from the mentor (Johannes
Schindelin, according to wiki). I will try to plan out the things in a
proper way to carry out this project if I get a chance to work on this
for GSoC 2009.

> it may be just doing an XML merge driver is a summer's worth of work, or it
> may be that it's not really enough and you should try to do another one or
> two.
>
> it also may be that there is a lot of overlap between different merge
> drivers, and once you have the XML driver the others become fairly trivial
> to do. (I'm thinking the config file examples I posted earlier in the
> thread)

with the options given to the user, one can handle the config files
also where order doesn't matter and also the whitespaces problem can
also be handled in the similar way.


-- 
Saurabh Gupta
Senior,
NSIT,New Delhi, India
