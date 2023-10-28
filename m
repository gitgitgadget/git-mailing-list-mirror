Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7E9460
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2406FCF
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 08:27:18 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id A7FC62424E;
	Sat, 28 Oct 2023 11:27:16 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwlDY-uUL-00; Sat, 28 Oct 2023 17:27:16 +0200
Date: Sat, 28 Oct 2023 17:27:16 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Liam Beguin <liambeguin@gmail.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Message-ID: <ZT0oVKPzVi5TsrdS@ugly>
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
 <20231028022048.GA1784118@shaak>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231028022048.GA1784118@shaak>

On Fri, Oct 27, 2023 at 10:20:48PM -0400, Liam Beguin wrote:
>I agree, %aa isn't the best, I'm definitly opened to suggestions.
>My preference would've been for something like %ad, but that's already
>taken.
>
H for host would be available. (not to be confused with h for human.)

in retrospect i'd say that it was unwise to use separate letters for the 
various forms of dates - a set of qualifiers that would be applied to a 
single specifier would be nicer. ah well ...

regards
