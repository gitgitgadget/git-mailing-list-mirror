From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 08/12] do_for_each_ref_in_arrays(): new function
Date: Thu, 20 Oct 2011 09:29:34 +0200
Message-ID: <4E9FCDDE.4070107@alum.mit.edu>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu> <1319060692-27216-9-git-send-email-mhagger@alum.mit.edu> <7vfwiobo75.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Thu Oct 20 09:30:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGn4v-0001mL-AD
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 09:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003Ab1JTHaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 03:30:05 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37950 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1JTHaE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 03:30:04 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9K7TYj9005511
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Oct 2011 09:29:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vfwiobo75.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184013>

On 10/20/2011 12:39 AM, Junio C Hamano wrote:
> Is this necessary?  IOW, is the helper function usable in any context
> other than merge-iterate loose and packed refs?

Soon the packed and cached refs will each be stored hierarchically, so
iteration through the combined caches will use a call to
do_for_each_ref_in_arrays() in each subdirectory, recursively.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
