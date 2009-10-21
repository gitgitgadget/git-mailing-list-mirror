From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: ident hash usage question
Date: Wed, 21 Oct 2009 12:09:10 +0900
Message-ID: <20091021120910.6117@nanako3.lavabit.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	<81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
	<81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
	<76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
	<81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
	<76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
	<7veioxn6ee.fsf@alter.siamese.dyndns.org>
	<76c5b8580910201514sc44f1cag222cf8a3710c875@mail.gmail.com>
	<7vbpk1lmvl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Eugene Sajine <euguess@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 05:09:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0RZo-00032y-VQ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 05:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbZJUDJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 23:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbZJUDJT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 23:09:19 -0400
Received: from karen.lavabit.com ([72.249.41.33]:53512 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbZJUDJS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 23:09:18 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 9EFE011B834;
	Tue, 20 Oct 2009 22:09:23 -0500 (CDT)
Received: from 1728.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 2SAF5EPAPRGI; Tue, 20 Oct 2009 22:09:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=HaqazCgmTqjq/G7ltIbcsnZTU9UA8tvlfNM6VW7MD3l/pbtwFXSjqW07qXlPOCoaEbWOTUwc+5TyWLbOAcbLbgiWRNGeZUFrNANZFQdiQEpjYnZX58HI3o7+n2NLXHs+f1SUJGhuX7hzVqYdDRcHVGrBMDnk4SPzKPBGYqlB75c=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vbpk1lmvl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130880>

Quoting Junio C Hamano <gitster@pobox.com>

> If your product ships as one main executable _dynamically_ linked with two
> dynamic libraries, and all three components are built from the source
> material under your source control, obviously you would need to make sure
> that the above version.o or some equivalent of what embeds output from
> "git describe HEAD" are linked to the main executable and to the two
> libraries, but the idea is the same.

Doesn't the above strategy also apply to the case where the 
libraries are linked statically, too? You get the version 
string from the main program and two version strings from the 
libraries embedded in the final product.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
