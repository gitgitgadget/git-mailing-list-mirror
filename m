From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 1/7] invalidate_ref_cache(): rename function from invalidate_cached_refs()
Date: Thu, 13 Oct 2011 00:12:14 +0200
Message-ID: <4E9610BE.7000801@alum.mit.edu>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org> <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu> <1318445067-19279-2-git-send-email-mhagger@alum.mit.edu> <7v1uui9g56.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 00:12:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE72R-0007os-Ts
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 00:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab1JLWMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 18:12:31 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52222 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab1JLWMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 18:12:30 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9CMCFlG004433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Oct 2011 00:12:15 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7v1uui9g56.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183423>

On 10/12/2011 09:14 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> It is the cache that is being invalidated, not the references.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
>> diff --git a/refs.c b/refs.c
>> index 9911c97..120b8e4 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -202,7 +202,7 @@ static struct cached_refs *get_cached_refs(const char *submodule)
>>  	return refs;
>>  }
>>  
>> -static void invalidate_cached_refs(void)
>> +static void invalidate_ref_cache(void)
>>  {
>>  	struct cached_refs *refs = cached_refs;
>>  	while (refs) {
> 
> If you call the operation "invalidate ref_cache", shouldn't the data
> structure that holds that cache also be renamed to "struct ref_cache" from
> "struct "cached_refs" at the same time?

I don't think it is a logical necessity but I agree that it would be
more consistent.  I'll make the change in the next round.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
