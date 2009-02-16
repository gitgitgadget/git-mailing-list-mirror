From: david@lang.hm
Subject: Re: [RFC - draft] List of proposed future changes that are backward
 incompatible
Date: Mon, 16 Feb 2009 07:33:28 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902160731420.14911@asgard.lang.hm>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.10.0902151544510.14911@asgard.lang.hm> <alpine.DEB.1.00.0902152358330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.10.0902151613110.14911@asgard.lang.hm> <alpine.DEB.1.00.0902160016230.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.10.0902151636510.14911@asgard.lang.hm> <alpine.DEB.1.00.0902161121290.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 15:30:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ4UM-00088h-Ax
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 15:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757682AbZBPO2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 09:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757675AbZBPO2d
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 09:28:33 -0500
Received: from mail.lang.hm ([64.81.33.126]:51252 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757678AbZBPO2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 09:28:33 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1GESRCD026110;
	Mon, 16 Feb 2009 06:28:27 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0902161121290.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110184>

On Mon, 16 Feb 2009, Johannes Schindelin wrote:

> On Sun, 15 Feb 2009, david@lang.hm wrote:
>
>> please be careful with the term 'deprecated', just becouse you would do
>> something a different way doesn't make it 'deprecated', that term should
>> only be used for features that are on their way out of the product, but
>> haven't been removed yet.
>
> It is not deprecated because I do not like it.  Actually, I am pretty
> indifferent about the pushing into a non-bare repository.
>
> It is deprecated because a lot of people active in the Git community spend
> a real lot of time explaining to a whole bunch of new users on IRC and
> recently even on this list why their pushing into a non-bare repository
> does not work, and why their suggestions how to solve the issue does not
> work either.

if it is the correct thing to do with some workloads, it's not being 
deprecated. if it was deprecated then it is a capability that would be 
scheduled for complete removal, and nobody should ever use. not just the 
case where it needs to be used carefully, and you are putting in a warning 
about it.

David Lang
