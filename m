From: Sam Vilain <sam@vilain.net>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Sat, 01 Sep 2007 11:47:18 +1200
Message-ID: <46D8A886.5060701@vilain.net>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>	<7vveav21uv.fsf@gitster.siamese.dyndns.org>	<20070831152153.GA30745@muzzle>	<7v4pifzawc.fsf@gitster.siamese.dyndns.org> <7vd4x3xuu3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 01:46:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRGCK-0005Wh-2x
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 01:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbXHaXqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 19:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbXHaXqj
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 19:46:39 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60852 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbXHaXqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 19:46:38 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id F2A2B21CFAF; Sat,  1 Sep 2007 11:46:35 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id C130B21CF9C;
	Sat,  1 Sep 2007 11:46:30 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <7vd4x3xuu3.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57231>

Junio C Hamano wrote:
>> I was almost going to suggest us to change "*.color = true" to
>> mean 'auto'.  Because git can internally use pager and has a way
>> for the user to control enabling/disabling colors when the pager
>> is used, there is no _logical_ reason to enable pager when the
>> output is not going to a tty.
>>     
>
> Gaah, sorry; I meant "no logical reason to enable _color_ when
> the output is not going to a tty".

Sure there is, when the output is "less -R"

Sam.
