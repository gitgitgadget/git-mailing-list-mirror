From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 0/7] Gitweb caching v4
Date: Thu, 14 Jan 2010 00:47:53 -0800
Message-ID: <4B4EDA39.1020400@eaglescrag.net>
References: <1263375282-15508-1-git-send-email-warthog9@eaglescrag.net> <7vmy0hhyer.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 09:49:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVLO9-0001Ln-Ms
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 09:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab0ANItE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 03:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756536Ab0ANItE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 03:49:04 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:32984 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530Ab0ANItC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 03:49:02 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0E8lshr018095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 14 Jan 2010 00:47:58 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <7vmy0hhyer.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 14 Jan 2010 00:47:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136968>

Junio,

I'd suggest using v5 vs. v4 as there was a couple of issues I discovered
with v4 today.

- John 'Warthog9' Hawley

On 01/14/2010 12:40 AM, Junio C Hamano wrote:
> Will replace what was queued on 'pu'.
> 
> For [3/7], I had to resolve conflicts in Makefile as it seemt to have been
> based on a bit older one.  When I push the result out, please verify.
> 
> The result merged to 'pu' seems to break t9500 but I didn't look very
> carefully.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
