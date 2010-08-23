From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] git-bundle.txt: Cleanup
Date: Mon, 23 Aug 2010 14:20:13 +0200
Message-ID: <4C72677D.9030205@drmicha.warpmail.net>
References: <cover.1282553585.git.git@drmicha.warpmail.net> <4cc5ea19fda713050f3f247d32df44fcfcea3296.1282553586.git.git@drmicha.warpmail.net> <201008231359.00417.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 23 14:20:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnW0p-0003eI-50
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 14:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab0HWMUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 08:20:17 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54038 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752701Ab0HWMUP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 08:20:15 -0400
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3309519A;
	Mon, 23 Aug 2010 08:20:15 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 23 Aug 2010 08:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=C2al9ZXWm1AJfYiwh8ZfAQy7hKM=; b=Z9uib9YH6vrWHj6idPwOR+iKtCArtZDX2WvxlPdcmmaH5cD4K8yG5JYfWuEUbed9c4mtzLI/DIxHK890THrowqO1deQjhsO3QEnnKA9vtMzXnL/d5xjsyXzUWe+Ln5tRzDdY3NiPvLFsnicRJ/UaNaX6OWnB8tfipD8uNURp2Sc=
X-Sasl-enc: 0mVBq7rGhl8buacPA7XTaMKd9xXtOXmsWAQREQT2EZSd 1282566014
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 91A1B5EB61A;
	Mon, 23 Aug 2010 08:20:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9pre) Gecko/20100806 Lightning/1.0b2pre Lanikai/3.1.2
In-Reply-To: <201008231359.00417.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154221>

Thomas Rast venit, vidit, dixit 23.08.2010 13:59:
> Michael J Gruber wrote:
>> Cleanup various spellings of the same argument
> [...]
>> -       'git rev-list' arguments to define the bundle contents.
>> +       'git-rev-list-args' arguments to define the bundle contents.
> 
> As indicated by the Cc but not the text, this was fallout from my
> automated replacements in 0b444cd (Documentation: spell 'git cmd'
> without dash throughout, 2010-01-10).

No blame intended (and no "git blame" run). I cc'ed you as the doc
sheriff ;)

The change above was really about using the place holder name
consistently, which includes keeping the "-args".

> An analogous change to one of your {tilde} replacements is already in
> Jonathan's series.  The rest probably don't hurt, if only to drive

I was behind an idiotic firewall for the last 2 weeks which not only
blocked vpn and nntp but made it impossible to get larger chunks over
git:, git+ssh: or even scp (bundle) even though bandwidth was no
apparent issue. One of those countries which are currently argueing with
RIM. Makes you wonder how routinely they do content sniffing and how
they react to any (false) triggers. Might also have been an overly eager
institution, of course.

So I didn't see Jonathan's series in time.

> people towards a more consistent {tilde} spelling in the future.

I did some experimenting after noticing that I had many broken ~ (either
disappearing or appearing with spurious \ in the html). I might even
have come up with a rule, but I'm afraid these things change from
asciidoc version to asciidoc version, so that I went the chatty {tilde}.

Cheers (back on home soil),
Michael
