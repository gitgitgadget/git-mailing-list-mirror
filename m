From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v2 1/3]http: authenticate on NTLM proxies and others suppported
 by CuRL
Date: Mon, 05 Mar 2012 16:33:16 +0100
Message-ID: <4F54DCBC.6080307@seap.minhap.es>
References: <4F4FBDBA.8040609@seap.minhap.es><7v399snnrs.fsf@alter.siamese.dyndns.org> <4F50D16D.3090800@seap.minhap.es> <7v4nu6et1x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 15:35:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Z05-00022N-OH
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 15:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579Ab2CEOex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 09:34:53 -0500
Received: from luthien2.mpt.es ([82.150.0.102]:2952 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311Ab2CEOew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 09:34:52 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 0C79CB6FF2;
	Mon,  5 Mar 2012 15:34:44 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id A894F2C291;
	Mon,  5 Mar 2012 15:34:35 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7v4nu6et1x.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 0C79CB6FF2.BF47C
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331562884.58125@CjA9IA0kRWOX6ZhuZAztfw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192248>

On 03/02/2012 07:50 PM, Junio C Hamano wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
> Is there anything specific about NTLM in this patch?  Let's retitle it to
> something like
> 
> 	http: support proxies that needs authentication
> 
>> ...
>> So as CURLAUTH_ANY provide us out-of-the-box proxy support, we don't
>> want it activated manually from a config option, instead we added it
>> automatically when a proxy is being used.
> 
> I can sort of parse this paragraph but cannot follow the logic.
> 
>  - Because we use CURLAUTH_ANY, a proxy that requires authentication is
>    supported out-of-the-box.
> 
>  - We do not want having to manually enable it.
> 
>  - Instead of adding a manual configuration, we do so automatically.
> 
> It sounds like it is saying the same thing three times.  Do we even need
> that paragraph?  Shouldn't we drop it instead?

I've dropped it in v3 patchset.

> 
> Otherwise it all looks good, so you can either
> 
>  (1) explain why the above suggestions are wrong and why I should apply
>      the message I am responding to as-is;
> 
>  (2) send another re-roll; or
> 
>  (3) say "yeah, your suggestions all sound good to me", in which case I'll
>      just locally amend and apply.
> 

I've re-rolled a new patchset and included your suggestions about wording,
you're welcome to better fine-tune the messages and commit if you find them
suitable.

Thanks!
