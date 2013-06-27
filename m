From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 07/16] compat: add endinanness helpers
Date: Thu, 27 Jun 2013 06:56:58 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1306270655120.10263@ds9.cixit.se>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com> <1372116193-32762-8-git-send-email-tanoku@gmail.com> <alpine.DEB.2.00.1306251404510.9929@ds9.cixit.se> <CAFFjANSNagvDgvrFNV1OLg=-4BPyQVjMDnfMPihdhVJR7o0TdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Vicent_Mart=ED?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 07:57:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us5Cg-0002cc-16
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 07:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab3F0F5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 01:57:05 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:56726 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750871Ab3F0F5E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 01:57:04 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r5R5uwKZ010880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 27 Jun 2013 07:56:58 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r5R5uwI8010877;
	Thu, 27 Jun 2013 07:56:58 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CAFFjANSNagvDgvrFNV1OLg=-4BPyQVjMDnfMPihdhVJR7o0TdQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 27 Jun 2013 07:56:58 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229089>

Vicent Mart=C3=AD:

> I'm aware of that, but Git needs to build with glibc 2.7+ (or was it=20
> 2.6?), hence the need for this compat layer.

Right. But perhaps the compatibility layer could provide the=20
functionality with the names available in the later glibc versions=20
(and on *BSD)? That would make it easier to read the code that is=20
using it.

--=20
\\// Peter - http://www.softwolves.pp.se/
