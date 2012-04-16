From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Mon, 16 Apr 2012 13:24:33 +0200
Message-ID: <4F8C0171.6090203@seap.minhap.es>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org><4F8BE14D.7090501@seap.minhap.es> <7vlilwxf3w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 12:27:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJj9Z-00039v-60
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab2DPK1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 06:27:14 -0400
Received: from luthien2.map.es ([213.9.211.102]:22443 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab2DPK1O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 06:27:14 -0400
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id B73F1F883B;
	Mon, 16 Apr 2012 12:27:02 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id C12E7203710;
	Mon, 16 Apr 2012 12:26:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <7vlilwxf3w.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: B73F1F883B.59DD0
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1335176822.78297@LpUZywHFtoqhzJ1H63Biww
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195609>

On 04/16/2012 10:20 AM, Junio C Hamano wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
>> On 04/16/2012 08:44 AM, Junio C Hamano wrote:
>>>
>>> * nl/http-proxy-more (2012-04-14) 6 commits
>>>  - http: fix proxy authentication
>>>  - http: rename HTTP_REAUTH to HTTP_AUTH_RETRY
>>>  - http: Avoid limit of retrying request only twice
>>>  - http: handle proxy authentication failure (error 407)
>>>  - http: handle proxy proactive authentication
>>>  - http: try http_proxy env var when http.proxy config option is not set
>>>
>>> The code to talk to http proxies learn to use the same credential
>>> API used to talk to the final http destinations.  This still needs
>>> to peek into $ENV{HTTPS_PROXY}.
>>
>> Hi Junio, so this needs some more work, but I don't recall the thread 
>> about it, could you point it to me or explain me what is still lacking.
> 
> I am reasonably sure that all the messages on the thread Peff and I worked
> out the fix-up at the tip of the series shown above were Cc'ed to you.

Ok, I've been offline for a week, I already found the thread and I'm
going through it.
