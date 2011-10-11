From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 1/7] invalidate_ref_cache(): rename function from invalidate_cached_refs()
Date: Tue, 11 Oct 2011 07:53:35 +0200
Message-ID: <4E93D9DF.2080004@alum.mit.edu>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu> <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu> <1318235064-25915-2-git-send-email-mhagger@alum.mit.edu> <7vfwj0iehl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 07:53:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDVHm-00086r-Jn
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 07:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497Ab1JKFxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 01:53:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:38390 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab1JKFxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 01:53:50 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9B5rZNq018195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Oct 2011 07:53:35 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vfwj0iehl.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183283>

On 10/11/2011 02:00 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> It is the cache that is being invalidated, not the references.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> 
> Although I think one can say "ref cache is the container for cached refs"
> and invalidating the "ref cache" as the container and invalidating the
> "cached refs" as a collection mean essentially the same thing, probably
> the new name makes more sense.

I certainly didn't mean to imply that the old name was incorrect.  I
just think that the new name removes a tiny bit of ambiguity.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
