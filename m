From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch.sh: clarify an error message
Date: Sun, 05 Jul 2015 16:41:31 +0200
Organization: gmx
Message-ID: <aca69b93d8ab5f3c610d6201ed4334e1@www.dscho.org>
References: <1436053144.3463091.315316457.1BAF8BA7@webmail.messagingengine.com>
 <20150705130706.GA5435@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Chris Jones <chris@christopherjones.us>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 05 16:41:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBl74-0005UA-QE
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 16:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbbGEOln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 10:41:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:63549 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbbGEOll (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 10:41:41 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LjrDd-1YaEZ33WsD-00btwP; Sun, 05 Jul 2015 16:41:32
 +0200
In-Reply-To: <20150705130706.GA5435@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:c8uIXagYn7TN7Au8GMb5IgV17J5xmJQQGR5OfiHABP4klfDi4Q7
 o37XWzKLOyTnvjBbwxHE+xXL3UyQNW3y5OcsnLnqc8IrMn3SJqAW07DNST9l1lQOU1418db
 Y5ZgGvSwNVCtF9Xwt9g56L0yYCb9pC2rweHy+TcvOH4/sxGo7TmmG5kzKxci6WibGxudhDP
 V3KNyS8tuAnnk06N/hDng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6MPNNS46v5U=:yncFIdDdqgtM7PC5odhDXy
 o8W5DZULNhultMWXw8YrXRfwcUFtimulgDqaxMyZqOTJaXWF2wn/JRcsDW7KmK+hgBoI1UWyd
 uHNsvfSNl7jwDNAgrwIS/gFWfoSQBs2wK6E/gbf24JJpJ/+1c4fmf9x2EPMPKbZxGBsWv3+J3
 +pt+k23Nf05VLhnjXrILEtqpgaSh9bZ+JCaVmwd/fH6qpALikGtmq13TOT1hUjVTt4Jv5q/eL
 DxV4TaSOe+BNZa6SlbgK40P4+AH/dLPxJXOagcb+Xb/iJwAyCc0+B8JP9F0U81H/yJ+7JCOX8
 ps7zAl31FRspntKFOX6Er5UE7UAoDwIUDeRF39984xILWjpL2J+29j9ZEQQcgcE9bMFxTODZ6
 ZczFl02Nr9nZWBRYMWS82ucz3lQHNAD2Z5G5Azh3fHoPGGli3uWb0CYlz1PNpxlG1xTERG58I
 hIdI6RdZJ+Hp/U3jnMMJ7pQ2fYljgrO0NxPdiU0ODo0ImHFhTummOpXsgVf+lchrLfqkt8MJK
 KSuPQMY/dskMPNcoVY0nXajNqR/nJtcYvd8tZNLPAB3FxbzT4wZ8hKYfqw3yQ7ilASYsY2VMM
 gaR5WWHAh8asKxCwTAS2ZBGhWoGl/9/S3ke/Oc/4rPzjPTbvjhQu7BbdO8rTEmvDSIcrMEivH
 +HxovxZZtjHW6/Nj3Hnabt+Ca+w47qBNZNa8wGOZrf3Sm7GDdo0ENk1U4Y4Q293/RIPQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273365>

Hi,

On 2015-07-05 15:07, Jeff King wrote:
> On Sat, Jul 04, 2015 at 07:39:04PM -0400, Chris Jones wrote:
> 
>> Make git filter-branch output a useful error message when a single
>> commit is given instead of a range.  Currently, when given a command
>> like git filter-branch --msg-filter 'echo "TEST"' -- abc123, it will
>> give the message "Which ref do you want to rewrite?".  Instead, what
>> is needed is a range of commits to rewrite.  This makes it give an
>> error message that says "You didn't provide a valid range of
>> commits".
> 
> Yeah, I agree the current message is a little confusing, and I think
> your message is an improvement. I wonder if we can even go a step
> further, like mentioning that at least one of the positive tips in your
> range must be a ref.

I agree, and would even further suggest to use the "did not" form instead of the abbreviated "didn't" one.

Thanks,
Dscho
