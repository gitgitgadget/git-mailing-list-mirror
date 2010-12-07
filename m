From: Scott Kyle <scott@appden.com>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 7 Dec 2010 14:59:31 -0800
Message-ID: <AANLkTinjzvCDjCFrvujdFPRZKo2vK_9_8j3ybLNAfFmE@mail.gmail.com>
References: <1291677763-55385-1-git-send-email-scott@appden.com>
 <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
 <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org> <4CFEA249.907@web.de>
 <AANLkTinnH4pFaEf=e4YE64f7cwLRx2R_2o_-=JGua30b@mail.gmail.com> <20101207212949.GA25162@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Kevin Ballard <kevin@sb.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 00:00:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ6Vs-0003jK-E6
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 00:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab0LGW7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 17:59:55 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58427 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab0LGW7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 17:59:55 -0500
Received: by wyb28 with SMTP id 28so455210wyb.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 14:59:54 -0800 (PST)
Received: by 10.216.172.15 with SMTP id s15mr1025294wel.70.1291762793923; Tue,
 07 Dec 2010 14:59:53 -0800 (PST)
Received: by 10.216.242.137 with HTTP; Tue, 7 Dec 2010 14:59:31 -0800 (PST)
In-Reply-To: <20101207212949.GA25162@burratino>
X-Google-Sender-Auth: 3LwygVLLww7jgvZBVfIyBQ7v1Q8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163146>

On Tue, Dec 7, 2010 at 1:29 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Scott Kyle wrote:
>
>> If I set the "submodule.<name>.ignore" then diffing around inside my
>> history will not show the changes to that particular submodule.
>
> Even if you set it to "dirty"?
>

Setting it to "dirty" is far less disruptive, you're right, but that
wouldn't do me much good since my submodules are often on different
branches while developing.
