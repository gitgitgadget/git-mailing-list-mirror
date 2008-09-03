From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 3 Sep 2008 13:27:33 +0200
Message-ID: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <7vk5dujn9h.fsf@gitster.siamese.dyndns.org> <20080902210524.GB7757@leksak.fem-net> <0578A0F2-F90A-4555-9B34-726F26A1CDBB@ai.rug.nl>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 13:29:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaqXj-0006p9-KX
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 13:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbYICL1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 07:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbYICL1w
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 07:27:52 -0400
Received: from frim.nl ([87.230.85.232]:41252 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751592AbYICL1w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2008 07:27:52 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.11])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KaqWS-0001Mp-D3; Wed, 03 Sep 2008 13:27:40 +0200
In-Reply-To: <0578A0F2-F90A-4555-9B34-726F26A1CDBB@ai.rug.nl>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94787>


On 2 sep 2008, at 23:51, Pieter de Bie wrote:
>
> How about a single line then, something like
>
> 	Vienna:git pieter$ ./git commit --allow-empty -m"test"
> 	Created commit 6ce62c8b: test
> 	Remember you are on a detached head, create a new branch to not  
> lose these changes

Or, as a final suggestion, something unintrusive like:

(on detached head)
	Vienna:git pieter$ ./git commit --allow-empty -m"test"
	Created commit 6ce62c8b on detached head: test
(on branch)
	Vienna:git pieter$ ./git commit --allow-empty -m"test"
	Created commit 6ce62c8b on branch 'master': test

- Pieter
