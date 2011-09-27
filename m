From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 21:59:32 +0100
Organization: OPDS
Message-ID: <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
References: <1316960136073-6829212.post@n2.nabble.com><1316961212.4388.5.camel@centaur.lab.cmartin.tk><7vaa9r2jii.fsf@alter.siamese.dyndns.org><1317073309.5579.9.camel@centaur.lab.cmartin.tk><vpq39fi9gf5.fsf@bauges.imag.fr><69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com> <vpqsjni6kkk.fsf@bauges.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	"vra5107" <venkatram.akkineni@gmail.com>, <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Michael Witten" <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 22:59:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ekH-0003Np-Cr
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 22:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab1I0U7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 16:59:12 -0400
Received: from out1.ip09ir2.opaltelecom.net ([62.24.128.245]:57041 "EHLO
	out1.ip09ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752643Ab1I0U7M (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 16:59:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAE44gk5cGntq/2dsb2JhbABBijGdUHmBTgEEAQEFCAEBLh4BASELAgMFAgEDFQwlFAEECBIGBxcGARIIAgECAwEIh1cKuV2GK2AEh0KWKIcd
X-IronPort-AV: E=Sophos;i="4.68,451,1312153200"; 
   d="scan'208";a="491802545"
Received: from host-92-26-123-106.as13285.net (HELO PhilipOakley) ([92.26.123.106])
  by out1.ip09ir2.opaltelecom.net with SMTP; 27 Sep 2011 21:59:09 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182263>

From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
> Michael Witten <mfwitten@gmail.com> writes:
>
>> -This can be useful when you want to publish the tree from a commit
>> -without exposing its full history. You might want to do this to publish
>> -an open source branch of a project whose current tree is "clean", but
>> -whose full history contains proprietary or otherwise encumbered bits of
>> -code.
>
> This part used to be just this in v1:
>
> -This can be useful when you want to publish the tree from a commit
> -without exposing its full history. You might want to do this to publish
> +This can be useful when you want to publish a tree without exposing its
> +full history; for instance, you might want to do this to publish
> an open source branch of a project whose current tree is "clean", but
> whose full history contains proprietary or otherwise encumbered bits of
> code.
>
> is it intentionnal that you discarded completely the paragraph? If so,
> then I disagree, the paragraph was one of the main motivation for
> someone to use --orphan, without it, someone may understand _what_ it
> does, but not _why_ it is useful.
>
> -- 

I agree - it would be wrong to discard the explanation of why it is used. As 
a relatively new git user, the man pages do need to properly inform the 
usage.

I have some orphan [i.e. independant] branches that are for documentation 
and for old matlab code that are both part of the project, but are separate 
from the various code branches. The original term `--orphan` was meaningful, 
though I do agree about it being a root commit.

It can be very easy for those that already know to presume knowledge of the 
reader that the reader doesn't have, leaving both sides frustrated. Reading 
the full manual could be a life times work to get all the nuances.
