From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] git-web--browse: improve browser support under OS X
Date: Wed, 13 Feb 2008 23:46:09 +0100
Message-ID: <CE42C4F4-1E6B-4300-9FD9-29F7E17B4F27@ai.rug.nl>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com> <7vve4wb3h7.fsf@gitster.siamese.dyndns.org> <76718490802120840r4a45c016k4cccf321f68893ce@mail.gmail.com> <200802130755.20884.chriscool@tuxfamily.org> <7vk5l8o65o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"Jay Soffian" <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 23:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPQNi-0004Xn-EA
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 23:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbYBMWqd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 17:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765659AbYBMWqc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 17:46:32 -0500
Received: from smtp-4.orange.nl ([193.252.22.249]:5810 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765078AbYBMWqb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 17:46:31 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6309.orange.nl (SMTP Server) with ESMTP id 9A8CC1C0012D
	for <git@vger.kernel.org>; Wed, 13 Feb 2008 23:46:21 +0100 (CET)
Received: from [192.168.1.12] (s55918ba6.adsl.wanadoo.nl [85.145.139.166])
	by mwinf6309.orange.nl (SMTP Server) with ESMTP id DE3ED1C00100;
	Wed, 13 Feb 2008 23:46:14 +0100 (CET)
X-ME-UUID: 20080213224618910.DE3ED1C00100@mwinf6309.orange.nl
In-Reply-To: <7vk5l8o65o.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73824>

On Feb 13, 2008, at 11:14 PM, Junio C Hamano wrote:
>
> Unless somebody comes up with a good reason that the environment
> check for SECURITYSESSIONID would misidentify (my understanding
> is that it is a MacOS specific hack^Wenvironment variable and
> nobody else would have it, but I haven't found authoritative
> source), I think the original from Jay is good and I can apply
> it to 'master'.

When I SSH to my mac, the SECURITYSESSIONID variable isn't set, but  
open will succeed in displaying the page.

Not sure if that is a valid concern though; how often would you do a  
remote login to your mac to display a webpage?

- Pieter
