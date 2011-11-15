From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Fix "is_refname_available(): query only possibly-conflicting
 references"
Date: Tue, 15 Nov 2011 17:19:44 +0100
Message-ID: <4EC29120.2020400@alum.mit.edu>
References: <1319804921-17545-27-git-send-email-mhagger@alum.mit.edu> <1321336525-19374-1-git-send-email-mhagger@alum.mit.edu> <7vty65x2zl.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Tue Nov 15 17:20:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQLk9-0004qy-Ux
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 17:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736Ab1KOQUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 11:20:08 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37206 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756521Ab1KOQUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 11:20:07 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAFGJiN6026898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Nov 2011 17:19:45 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vty65x2zl.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185465>

On 11/15/2011 08:24 AM, Junio C Hamano wrote:
> However, I'd rather see us spend effort to make absolutely sure that other
> topics already in next that touch the related codepaths (I think you have
> two such series yourself and I suspect there are other minor fixes that
> may textually conflict) are in good shape and have them graduate early
> after 1.7.8 ships, before queuing a re-roll of the ref-api series, which
> is rather extensive.

If you have a preference for which patch series you would like to
integrate in which order (and especially if you think that there are
gaps that need to be filled), please let me know.  It would be a lot
less work to put them in the right order from the start rather than
trying to keep them all synchronized with master and continually reroll
them based on what you have merged so far.

Also, I am working under the assumption that the patch series that are
already in "next" should be left alone; if you have doubts about any of
those patch series (i.e., are thinking of ejecting them from next during
the post-release chaos), please let me know what needs changing.

I'm still getting the hang of this workflow, so suggestions are welcome.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
