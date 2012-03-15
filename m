From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Thu, 15 Mar 2012 10:38:26 +0100
Message-ID: <4F61B892.8030604@seap.minhap.es>
References: <4F4CCE8A.4010800@seap.minhap.es><m3pqcjt6s2.fsf@carbon.jhcloos.org> <7v4ntvx87v.fsf@alter.siamese.dyndns.org><4F5F1FEA.8020103@seap.minhap.es>  <7vhaxrsssm.fsf@alter.siamese.dyndns.org><4F606AE9.70608@seap.minhap.es> <7v1uouq5j9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	peff@peff.net, sam.vilain@catalyst.net.nz, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S86Gm-0007Xt-Mx
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 09:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760591Ab2COImo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 04:42:44 -0400
Received: from luthien1.map.es ([82.150.0.102]:58760 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760273Ab2COIml (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 04:42:41 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id BAC99B73B6;
	Thu, 15 Mar 2012 09:39:42 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 0764D2C389;
	Thu, 15 Mar 2012 09:39:30 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7v1uouq5j9.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: BAC99B73B6.BA8D2
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332405584.12171@YogwFKvOnzg/imsLpUBJ7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193201>

On 03/14/2012 09:41 PM, Junio C Hamano wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
>> On 03/14/2012 05:36 AM, Junio C Hamano wrote:
>>
>>> Are you sure $no_proxy is spelled in lowercase?  man curl(1) seems to
>>> indicate otherwise.
>>
>> Instead here[1] in section "Environment Variables" it's spelled lowercase,
>> and given that cURL reads $http_proxy only in lowercase I think it does
>> the same for $no_proxy.
> 
> Don't think, but read ;-).  Quoting from man curl(1):
> 
> 	ENVIRONMENT
> 
>         The environment variables can be specified in lower case or upper
>         case. The lower case version has precedence. http_proxy is an
>         exception as it is only available in lower case.
> 

Ok, good advice nonetheless :-), so will send a new 1/5 patch that also
reads $NO_PROXY.
