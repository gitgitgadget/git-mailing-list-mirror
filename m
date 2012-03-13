From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Tue, 13 Mar 2012 11:22:34 +0100
Message-ID: <4F5F1FEA.8020103@seap.minhap.es>
References: <4F4CCE8A.4010800@seap.minhap.es><m3pqcjt6s2.fsf@carbon.jhcloos.org> <7v4ntvx87v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	peff@peff.net, sam.vilain@catalyst.net.nz, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 10:24:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Nxw-0007Z3-6X
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 10:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760106Ab2CMJYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 05:24:12 -0400
Received: from luthien2.map.es ([82.150.0.102]:32171 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759982Ab2CMJYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 05:24:10 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id 76624F87FB;
	Tue, 13 Mar 2012 10:23:57 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id C9497D4B47;
	Tue, 13 Mar 2012 10:23:42 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7v4ntvx87v.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 76624F87FB.2E1FA
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332235438.16845@EaR30R1h3o5jaB9L9wzl/A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192989>

On 03/11/2012 08:12 PM, Junio C Hamano wrote:
> James Cloos <cloos@jhcloos.com> writes:
> 
>> Please include a way, eg via ~/.gitconfig, to ignore any http_proxy in
>> the environment and connect directly.
> 
> Hrm.
> 
> I think without this patch series, the "NO_PROXY" environment
> variable is honored by the curl library when it uses http_proxy
> to make the decision. If this patch (or a future reroll of it) fails
> to do the same, it would be a regression.
> 
> Nelson, do you agree?

I agree, so I would need to handle $no_proxy in the patch-set, will look
into that.
