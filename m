From: Eric Raible <raible@nextest.com>
Subject: Re: Re: merge removed content back into current content
Date: Mon, 27 Sep 2010 11:31:47 -0700
Message-ID: <4CA0E313.4090501@nextest.com>
References: <i7jp1a$kc0$1@dough.gmane.org> <AANLkTimxHbCktv=kaq0UfV+u1kH1Pb2LYA2Xi=qkgduW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 20:31:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0IUQ-0004nz-EJ
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 20:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448Ab0I0Sbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 14:31:47 -0400
Received: from exchange.domain1.nextest.com ([12.96.234.114]:39223 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754405Ab0I0Sbq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 14:31:46 -0400
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Mon, 27 Sep 2010 11:31:45 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b2 Thunderbird/3.1.4
In-Reply-To: <AANLkTimxHbCktv=kaq0UfV+u1kH1Pb2LYA2Xi=qkgduW@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157363>

On 11:59 AM, Elijah Newren wrote:

> btw, does anyone know how to force
> git apply to proceed and add conflict markers if necessary rather than
> just bailing out?

It's not quite the same, and you probably already know about it,
but there's always: git apply --reject
