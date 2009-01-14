From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [PATCH 3/3] git-daemon: vhost support
Date: Wed, 14 Jan 2009 14:15:43 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901141409060.23212@fbirervta.pbzchgretzou.qr>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr> <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr> <alpine.LSU.2.00.0901141148390.16109@fbirervta.pbzchgretzou.qr> <7vmydu2kbj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 14:17:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN5cN-0006RR-LP
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 14:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759278AbZANNPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 08:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759105AbZANNPp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 08:15:45 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:42028 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259AbZANNPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 08:15:45 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id D9DA5180C566B; Wed, 14 Jan 2009 14:15:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id D8D661D160A19;
	Wed, 14 Jan 2009 14:15:43 +0100 (CET)
In-Reply-To: <7vmydu2kbj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105626>


On Wednesday 2009-01-14 12:33, Junio C Hamano wrote:
>> git-daemon: support vhosts
>>
>> Since git clients usually send the target hostname in the request
>> similar to the "Host:" HTTP header, one can do virtual hosting.
>
>Isn't this what --interpolated-path option (especially H and CH
>interpolations) is about?

Looks like it. In this case this third patch is not needed.
