From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git merge driver / attributes bug in 2.3.1?
Date: Fri, 06 Mar 2015 12:25:50 +0100
Message-ID: <54F98EBE.8080903@drmicha.warpmail.net>
References: <D8780C527EB1E642B3150E6D705B46D448E7E48C@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 12:26:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTqOF-0003yp-Ez
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 12:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845AbbCFLZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 06:25:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46270 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756841AbbCFLZw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 06:25:52 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 8D2B820B2E
	for <git@vger.kernel.org>; Fri,  6 Mar 2015 06:25:50 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 06 Mar 2015 06:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=w4BCZc71gEYT1c9PGJ+Gdz
	H3vLY=; b=uamrcijl1WmNFulVbLT8QKjafvlWca4RXV0wkYuLqR5DOJs44rMN9S
	cV9oxwyALQFmlUc85yjylTIlYyuTiCRmry5MLzpsudFb22w+oYwedT549kQBEPoJ
	ly+aeC0JkaMUGI4HBkGwVdpN7WLzMV3adMXsIKez3ausJlFi/7ZNk=
X-Sasl-enc: YsmGFE8h3Nk8KGNi6QNbmPzMResIBNt2S17CJffVEiRG 1425641151
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2BC4BC0029D;
	Fri,  6 Mar 2015 06:25:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <D8780C527EB1E642B3150E6D705B46D448E7E48C@DWPWHMS531.dwpbank.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264913>

Gondek, Andreas venit, vidit, dixit 05.03.2015 14:30:
> Hello,
> 
> after upgrading the Git installation on one of our development
> servers from 1.9.0-rc3 to 2.3.1 we are experiencing strange behavior
> of merge drivers.
> 
> A merge driver registered as "* merge=<name_of_merge_driver>" in the
> .gitattributes is now executed even if there isn't any merge
> conflict. This only happens for files that are part of the merge.
> 
> This is reproducible in test repositories.

Can you share a minimal test repo?

I've been trying to reproduce this, unsuccessfully so far.

I guess it depends on how exactly those files are "part of the merge",
and how the merge driver is set up. (I've tried with and without recursive.)

Michael
