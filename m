From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified
 submodules.
Date: Mon, 12 Nov 2007 08:26:17 +0100
Message-ID: <47380019.1000704@viscovery.net>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>	<7vabpliz13.fsf@gitster.siamese.dyndns.org>	<46dff0320711102218h259199e3g2b4a4d3b73202cdb@mail.gmail.com> <7vhcjscyhu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Yin Ping <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 08:26:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrTgy-0003Sq-4f
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 08:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbXKLH00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 02:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXKLH00
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 02:26:26 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58369 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbXKLH0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 02:26:25 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrTg5-0005Fj-EI; Mon, 12 Nov 2007 08:25:49 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BF5A754D; Mon, 12 Nov 2007 08:26:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vhcjscyhu.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64569>

Junio C Hamano schrieb:
> "Yin Ping" <pkufranky@gmail.com> writes:
> 
>> I think it's this kind of case in most open-source project. However,
>> in a company environment, superprojects may be not so super.
> 
> Let's not say "most open-source" nor "company", because I think
> nobody said anything that substantiates that the commit density
> characteristics I described is typical for most open-source, nor
> what you said is typical for corporate development projects, in
> this thread so far.
> 
> If "superprojects is not so super", why are you using submodule
> to bind these, instead of using a single project that tracks
> developments of such closely tied parts?

Because the a monolithic project is just too large? Think of KDE!

> I am not saying that it is wrong to use submodule to track such
> groups of source trees whose versions are very closely tied
> together.  At least not yet.

In KDE, the supermodule will actually just be a container that binds the 
submodules together. The essential development will happen in the 
submodules, and the supermodule will receive a commit quite frequently. In 
this case, there will often be only a few or a few dozen commits listed, and 
I anticipate that the integrator who is going to make the commit (to the 
supermodule) will probably like the summary. So I'm all for it.

-- Hannes
