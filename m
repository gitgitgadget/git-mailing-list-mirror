From: Slavomir Vlcek <svlc@inventati.org>
Subject: Re: Subject: [PATCH/RFC] Documentation/git-stripspace: Update synopsis
Date: Wed, 19 Nov 2014 00:29:35 +0100
Message-ID: <546BD65F.3070808@inventati.org>
References: <546BD367.40301@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 00:26:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqsAK-0003sj-5Q
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 00:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbaKRX02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 18:26:28 -0500
Received: from latitanza.investici.org ([82.94.249.234]:61486 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401AbaKRX02 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 18:26:28 -0500
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: svlc@inventati.org) by localhost (Postfix) with ESMTPSA id A1ADE121449
	for <git@vger.kernel.org>; Tue, 18 Nov 2014 23:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inventati.org;
	s=stigmate; t=1416353186;
	bh=uR2l2CtgzjsZJaEbqTr4vPa8CtK+/I3+FzQAZKQBO80=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=bKh2pnzzE+4ewLkn3LL0LkANFMXjWy0i0xtOwsA28dbviHBFgdCa/qMgzPx6YMq5M
	 b7V8gFhgqaIag0hbWNIcpJtwqK71kMbnCiH8ZO/8e7pk1Jvv9T3KeCzq/Ayv9g3Apx
	 TZYIJfGrSyoBCzhRdkcXYcX2vpHTr80puwHPC/Xo=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <546BD367.40301@inventati.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11/19/2014 12:16 AM, Slavomir Vlcek wrote:
> b) In the documentation there is:
> "-s, --strip-comments
>            Skip and remove all lines starting with comment character (default #)."
> 
> part. This "default" word somehow suggests some new command option that would
> allow to change the comment character. Would you accept a patch implementing
> this or such functionality is not desired.

I take it back, just found that there is a global "comment_line_char" variable
that controls this stuff. Apologizing.
