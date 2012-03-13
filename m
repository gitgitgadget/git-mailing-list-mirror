From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v4 5/5] http: rename HTTP_REAUTH to HTTP_RETRY
Date: Tue, 13 Mar 2012 13:47:59 +0100
Message-ID: <4F5F41FF.4000204@seap.minhap.es>
References: <4F5E3298.5030502@seap.minhap.es> <7vk42pr3c7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 12:51:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QGU-0004Oz-IX
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 12:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758927Ab2CMLvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 07:51:33 -0400
Received: from luthien2.mpt.es ([82.150.0.102]:42033 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757903Ab2CMLvT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 07:51:19 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id A900824FB3;
	Tue, 13 Mar 2012 12:49:12 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 83B9ED4BEE;
	Tue, 13 Mar 2012 12:49:07 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7vk42pr3c7.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: A900824FB3.71F5B
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332244156.34223@39DOUR6xaBWxoY8E7nkt2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192996>

On 03/12/2012 09:06 PM, Junio C Hamano wrote:
> Whatever new token you use, please keep AUTH as a substring of it.
> 
> We may want to retry a request to deal with intermittent failures on
> the server side or the network between us and the server; HTTP_RETRY
> would be a good name to signal such condition after we see a failure
> response from the library.

HTTP_REAUTH and HTTP_AUTH_RETRY seems like the same thing, so imo not 
deserving the rename, maybe Jeff can suggest a better name as he was
who suggest the rename.
