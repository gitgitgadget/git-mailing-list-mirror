From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: 'git diff' against files outside a git repo
Date: Mon, 27 Sep 2010 09:38:37 +0200
Message-ID: <4CA049FD.5040100@drmicha.warpmail.net>
References: <AANLkTinR7BJpD-FOS_DShg=r0ucF2C9oE6p-YoZU-5En@mail.gmail.com> <AANLkTik4kL8Mao1VM=njNxFSXOY7guwuEZgmpv0UTc8R@mail.gmail.com> <AANLkTikpPQM4GyP5O7+aw6_P9_1DdxUjTzpH=WhzW=wK@mail.gmail.com> <7vwrq9m0y0.fsf@alter.siamese.dyndns.org> <AANLkTikJ-SN5xmwqhEHcESfQCWvGjSHp3OK1Hi4+0jBL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 09:38:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P08ID-0001b9-S8
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 09:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758055Ab0I0Hi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 03:38:29 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:37953 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752833Ab0I0Hi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 03:38:28 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A421787;
	Mon, 27 Sep 2010 03:38:27 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 27 Sep 2010 03:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=FeAy8EsCP5XjPF52lv5Ixkw5hjo=; b=olfsqlRpbctlVgCWfYP6sez1/+AHye555H8KzlUk64c64A+geKTOLdRFlBDb0s4kkyYzPYW00AbRp6/pCFhdOZXQ/7DznNX9B6QqZunh5+VrkFgOdU9HQwsJIs3p5uTIfoZa+SWo6kX0ywEJS66GjorQTz/mHO0ZKcU/aGkuyps=
X-Sasl-enc: QLC776VEz7YeE1Hkeh2511ieWUuhrRPp3alBGQkALNKQ 1285573107
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D02AF5E66A1;
	Mon, 27 Sep 2010 03:38:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTikJ-SN5xmwqhEHcESfQCWvGjSHp3OK1Hi4+0jBL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157314>

Avery Pennarun venit, vidit, dixit 26.09.2010 11:38:
> On Sun, Sep 26, 2010 at 12:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Avery Pennarun <apenwarr@gmail.com> writes:
>>
>>> Oddly, 'git diff file1 file2' *doesn't* work when file1 and file2 are
>>> in a working tree; git tries to diff something, apparently, but I
>>> don't know what.
>>
>> Heh, I thought you've been using git long enough that you sh/would know
>> that you are comparing the index and the working tree, using "file1" and
>> "file2" as pathspecs.
> 
> Ha, of course.  And I do that all the time, so it's silly that I
> somehow forgot for the duration of that email.
> 
> The real surprise was that this *wasn't* the meaning when I was
> outside a git tree :)

Well, DWIM really is DWYTIM ;)

Michael
