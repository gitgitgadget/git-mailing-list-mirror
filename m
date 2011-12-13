From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 08/51] is_dup_ref(): extract function from sort_ref_array()
Date: Tue, 13 Dec 2011 06:00:36 +0100
Message-ID: <4EE6DBF4.5010409@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu> <1323668338-1764-9-git-send-email-mhagger@alum.mit.edu> <7vvcplxq4r.fsf@alter.siamese.dyndns.org> <4EE6D61A.2030300@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Tue Dec 13 06:00:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaKU6-0000Zb-1U
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 06:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764Ab1LMFAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 00:00:53 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:46648 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab1LMFAx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 00:00:53 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDFA7.dip.t-dialin.net [84.190.223.167])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBD50b5M022585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Dec 2011 06:00:37 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <4EE6D61A.2030300@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187001>

On 12/13/2011 05:35 AM, Michael Haggerty wrote:
> Is it *really* possible to have multiple extra_refs with the same name,
> or is this more of a hypothetical problem that requires more careful
> analysis?

I see that you already answered this question downthread.  I will reply
to your analysis there.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
