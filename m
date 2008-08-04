From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 04 Aug 2008 12:14:01 +0200
Message-ID: <4896D669.30402@dawes.za.net>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <alpine.DEB.1.00.0808041208060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 12:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPx6f-0002KY-J5
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 12:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbYHDKO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 06:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbYHDKO4
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 06:14:56 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:35473 "EHLO
	spunkymail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752648AbYHDKOz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 06:14:55 -0400
Received: from [192.168.201.100] (unknown [41.247.123.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a18.g.dreamhost.com (Postfix) with ESMTP id 765415B4E3;
	Mon,  4 Aug 2008 03:14:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <alpine.DEB.1.00.0808041208060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91338>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 4 Aug 2008, Rogan Dawes wrote:
> 
>> I don't understand why you would want to keep the commands in the URL 
>> when you are doing a POST?
> 
> Caching.
> 
> Hth,
> Dscho
> 

If you are expecting something to be cacheable, then should you not be 
using a GET anyway?

Anyway, from RFC 2616:

> 13.10 Invalidation After Updates or Deletions
> 
> ...
> 
> Some HTTP methods MUST cause a cache to invalidate an entity. This is
> either the entity referred to by the Request-URI, or by the Location
 > or Content-Location headers (if present). These methods are:
> 
>       - PUT
>       - DELETE
>       - POST

This doesn't seem negotiable to me.

Unless I am misunderstanding your "Caching" comment to mean "To enable 
caching", as opposed to "To prevent caching"?

Rogan
