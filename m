From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Makefile: implement help target
Date: Tue, 28 Sep 2010 17:47:48 +0200
Message-ID: <4CA20E24.90509@drmicha.warpmail.net>
References: <4CA1E10F.4080906@op5.se> <c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net> <7vpqvxubl5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 17:47:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0cPA-0001s3-H6
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 17:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab0I1Prj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 11:47:39 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51561 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752510Ab0I1Pri (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 11:47:38 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1542E6D4;
	Tue, 28 Sep 2010 11:47:38 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 28 Sep 2010 11:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=DL4z1A7UXFehjyacNx/0AwJyKQw=; b=KIkOz30i9Th2+Q63ezzpZhx8JbVKj/PE59+s0fPDTqsBv0qsic8k5u8UjDgKF5oAvxjc+p0ODFA4QXT5zKWS2VfTIxORv4P51KbpIqU+5cm+YU6Y5WN/hXVVhYnEI2S8X5xLJnCRo/UhuNHLC+wcdNy3qfrxCv9tB5GvRjWmf7c=
X-Sasl-enc: jyLfVsXCFOrwqxAkcKWWQCzGZrg+OyAjnNkEdC/eqCo6 1285688857
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3ACD35E0CB5;
	Tue, 28 Sep 2010 11:47:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <7vpqvxubl5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157436>

Junio C Hamano venit, vidit, dixit 28.09.2010 17:33:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> How's this for a version without maintenance issues?
> 
> Something along these lines would be closer to what I had in mind,
> actually.
> 
> Traditionally a multi-line sed command embed in Makefile has been
> portability nightmare, which is a bit worrysome.

Yes, but I thought for "make help" it's not such problem if it works on
most platforms only - others can read inline ;)

If portability is an issue one can work around it - is "grep -A 1"
portable? I'd also have to get rid of sort --key=2.

> Isn't there a "makedoc" ala "perldoc" or "javadoc", by the way?

There is a "makedoc" but that's something different...

Michael
