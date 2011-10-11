From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/6] Retain caches of submodule refs
Date: Tue, 11 Oct 2011 06:12:34 +0200
Message-ID: <4E93C232.9090400@alum.mit.edu>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu> <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu> <7v4o1hgemp.fsf@alter.siamese.dyndns.org> <4E918194.5060102@alum.mit.edu> <20111010195325.GA5981@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Oct 11 06:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDTi6-000738-3T
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 06:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872Ab1JKEMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 00:12:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:37967 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1JKEMx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 00:12:53 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9B4CY94013696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Oct 2011 06:12:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <20111010195325.GA5981@sandbox-rc>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183281>

On 10/10/2011 09:53 PM, Heiko Voigt wrote:
> On Sun, Oct 09, 2011 at 01:12:20PM +0200, Michael Haggerty wrote:
> Since the setup_revision() api can currently not be used to safely
> iterate twice over the same submodule my patch
> 
> 	allow multiple calls to submodule merge search for the same path
> 
> rewrites the search into using a child process. AFAIK the submodule ref
> iteration api would then even be unused.

If your patch is accepted, then we should check whether anything should
be ripped out.

> At least in my code there is no place where a submodule ref is changed.
> I only used it for merging submodule which only modifies the main
> module. So I would say its currently safe to assume that submodule refs
> do not get modified. If we do need that later on we can still add
> invalidation for submodule refs.

OK, thanks!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
