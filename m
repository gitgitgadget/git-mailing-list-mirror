From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 10:13:15 +0200
Message-ID: <4535E21B.4040203@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca> <200610180057.25411.jnareb@gmail.com> <4535685C.4010502@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 10:13:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga6YF-0002Ow-FR
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 10:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWJRINU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 04:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWJRINU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 04:13:20 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:20404 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751442AbWJRINS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 04:13:18 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 74E546BD8A; Wed, 18 Oct 2006 10:13:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5127D6BD79; Wed, 18 Oct 2006 10:13:16 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <4535685C.4010502@utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29201>

Aaron Bentley wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Jakub Narebski wrote:
>> Aaron Bentley wrote:
>> By the way, are bzr "bundles" compatibile with ordinary patch?
>> git-format-patch patches are. They have additional metainfo,
>> but they are patches in heart.
> 
> Yes, they are.
> 

Sounds a bit like [PATCH 0/8] would have the output of

	git diff $(git merge-base master)..topic-branch

for any given patch-series. It might be easier to review the whole 
patch-series in some cases. Especially with patch-series where more than 
one patch touches the same part of the code.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
