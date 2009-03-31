From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH] Add warning about known issues to documentation of	cvsimport
Date: Tue, 31 Mar 2009 07:36:16 +0200
Message-ID: <49D1ABD0.8070707@pelagic.nl>
References: <20090323195304.GC26678@macbook.lan> <49C7F233.9050205@pelagic.nl> <20090330221729.GB68118@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:37:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWfX-0006gn-AT
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbZCaFgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbZCaFgT
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:36:19 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:38118 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751713AbZCaFgS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:36:18 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 50B5F58BD88;
	Tue, 31 Mar 2009 07:36:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090330221729.GB68118@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115215>

Heiko Voigt wrote:
> On Mon, Mar 23, 2009 at 09:33:55PM +0100, Ferry Huberts (Pelagic) wrote:
>> maybe you can also add remarks about autocrlf and safecrlf?
>> both need to be off
> 
> From my experience thats not necessarily true. You can use
> autocrlf=input to repair broken revisions were crlf's have been
> mistakenly committed into the repository. And if I remember correctly
> safecrlf helps if you want to make sure that no information gets lost.
> 
> So when importing from a nice correct cvs repository you would expect
> safecrlf to not stop your import. And I suspect there are actually cvs
> users that were very careful with their lineendings who would use it.
> 
> cheers Heiko
If you look at this thread:
http://thread.gmane.org/gmane.comp.version-control.git/110152/focus=110358
you'll see why I said it. I did some testing to prove my statement.

Ferry
