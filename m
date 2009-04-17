From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Fix buffer overflow in config parser
Date: Fri, 17 Apr 2009 15:16:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904171516400.6675@intel-tinevez-2-302>
References: <49E50003.2040907@intra2net.com> <49E5888D.2090607@viscovery.net> <49E58F38.5060103@viscovery.net> <200904171405.48269.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, markus.heidelberg@web.de,
	Jeff King <peff@peff.net>
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 15:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lunxe-00005L-GB
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 15:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZDQNQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 09:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758355AbZDQNQ5
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 09:16:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:47312 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754229AbZDQNQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 09:16:56 -0400
Received: (qmail invoked by alias); 17 Apr 2009 13:16:55 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 17 Apr 2009 15:16:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Cr8s0ErMCR2h+MNjQCJSqI9NFtYgl6nih4bekRU
	1CK/tE2uCdaK9f
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200904171405.48269.thomas.jarosch@intra2net.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116739>

Hi,

On Fri, 17 Apr 2009, Thomas Jarosch wrote:

> When interpreting a config value, the config parser reads in 1+ space
> character(s) and puts -one- space character in the buffer as soon as
> the first non-space character is encountered (if not inside quotes).
> 
> Unfortunately the buffer size check lacks the extra space character
> which gets inserted at the next non-space character, resulting in
> a crash with a specially crafted config entry.
> 
> The unit test now uses Java to compile a platform independent
> .NET framework to output the test string in C# :o) Read:
> Thanks to Johannes Sixt for the correct printf call
> which replaces the perl invocation.

LOL!

Thanks,
Dscho
