From: Andy Lester <andy@petdance.com>
Subject: Re: [PATCH] Removed redundant static functions such as update_tracking_ref() and verify_remote_names() from builtin-send-pack.c, and made the ones in transport.c not be static so they can be used instead.
Date: Fri, 24 Apr 2009 23:15:07 -0500
Message-ID: <4B2541E8-7A27-45D5-B77D-AE93C0430EA8@petdance.com>
References: <1240546432-26212-1-git-send-email-andy@petdance.com> <20090424210418.GC13561@coredump.intra.peff.net> <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com> <alpine.DEB.1.00.0904250206250.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 06:19:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxZM7-0001R6-Jn
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 06:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbZDYEPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 00:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbZDYEPK
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 00:15:10 -0400
Received: from huggy.petdance.com ([72.14.176.61]:44454 "EHLO
	huggy.petdance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbZDYEPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 00:15:09 -0400
Received: from mel.petdance.com (uniqua.petdance.com [64.81.227.163])
	by huggy.petdance.com (Postfix) with ESMTP id A0AA31BEC46;
	Sat, 25 Apr 2009 00:15:07 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904250206250.10279@pacific.mpi-cbg.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117535>


On Apr 24, 2009, at 7:07 PM, Johannes Schindelin wrote:

> I dunno.  The most important part of CodingGuidelines is this:
>
> 	As for more concrete guidelines, just imitate the existing code
> 	(this is a good guideline, no matter which project you are
> 	contributing to).
>
> (And of course, this holds for the style of commit messages, too.)


Would you rather I not bother?  Far be it from me to try to force  
myself on any project.

--
Andy Lester => andy@petdance.com => www.petdance.com => AIM:petdance
