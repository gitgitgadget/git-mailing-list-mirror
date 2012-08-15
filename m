From: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Wed, 15 Aug 2012 20:38:37 +0200
Message-ID: <502BECAD.90307@ira.uka.de>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com> <87zk5x6fox.fsf@thomas.inf.ethz.ch> <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com> <7v628lbdcw.fsf@alter.siamese.dyndns.org> <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com> <87lihh8c7s.fsf@thomas.inf.ethz.ch> <7vr4r98ah5.fsf@alter.siamese.dyndns.org> <87sjbo63pl.fsf@thomas.inf.ethz.ch> <7vfw7o6p1g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:37:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1iTZ-0005YN-2e
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 20:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab2HOShr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 14:37:47 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58542 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751026Ab2HOShq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2012 14:37:46 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1T1iTI-0003ND-IG; Wed, 15 Aug 2012 20:37:41 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 587 
	id 1T1iTI-0007dZ-B1; Wed, 15 Aug 2012 20:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vfw7o6p1g.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1345055861.619174000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203482>

Am 15.08.2012 19:30, schrieb Junio C Hamano:
> The current rule is very
> simple and understandable.  You either say from the command line
> exactly what should happen (refspec without colon is the same as the
> refspec with colon at the end, meaning "do not track"; if you want
> to track, you write what to update with the fetch), or we use the
> configured refspec (which again spells what should happen).

Couldn't a similar new rule just say that refspec <name> is a short for 
<name>:<name> ?

The exception would be in the case of a URL as remote, but that would 
not be surprising to anyone, as there is no obvious target for the update
