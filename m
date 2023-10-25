Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3041F61C
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21969E5
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 02:23:03 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 9A89B24263;
	Wed, 25 Oct 2023 05:23:01 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qva6P-1WT-00; Wed, 25 Oct 2023 11:23:01 +0200
Date: Wed, 25 Oct 2023 11:23:01 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Jeff King <peff@peff.net>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Revert "send-email: extract email-parsing code into
 a subroutine"
Message-ID: <ZTjedSluwyrVY+L9@ugly>
References: <20231020100343.GA2194322@coredump.intra.peff.net>
 <20231020101310.GB2673716@coredump.intra.peff.net>
 <ZTJaVzt75r0iHPzR@ugly>
 <20231023184010.GA1537181@coredump.intra.peff.net>
 <ZTbOnsxBFERPLN3F@ugly>
 <20231025061120.GA2094463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231025061120.GA2094463@coredump.intra.peff.net>

On Wed, Oct 25, 2023 at 02:11:20AM -0400, Jeff King wrote:
>The "//" operator was added in perl 5.10. I'm not sure what you found
>that makes you think the ship has sailed. The only hits for "//" I see
>look like the end of substitution regexes ("s/foo//" and similar).
>
grep with spaces around the operator, then you can see the instance in 
git-credential-netrc.perl easily.

regards
