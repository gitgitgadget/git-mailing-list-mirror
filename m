From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: Re: [PATCH v2 00/11] Use ALLOC_GROW() instead of inline code
Date: Sat, 01 Mar 2014 10:57:36 +0400
Message-ID: <531184E0.3000808@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru> <53109F78.2060203@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 01 07:57:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJdrl-0004gD-KU
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 07:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbaCAG5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 01:57:41 -0500
Received: from forward9l.mail.yandex.net ([84.201.143.142]:56087 "EHLO
	forward9l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbaCAG5l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 01:57:41 -0500
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [37.140.190.26])
	by forward9l.mail.yandex.net (Yandex) with ESMTP id 5F6C5E60E99;
	Sat,  1 Mar 2014 10:57:38 +0400 (MSK)
Received: from smtp1o.mail.yandex.net (localhost [127.0.0.1])
	by smtp1o.mail.yandex.net (Yandex) with ESMTP id 01775DE1471;
	Sat,  1 Mar 2014 10:57:37 +0400 (MSK)
Received: from 212.192.143.74 (212.192.143.74 [212.192.143.74])
	by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id KTuWrvY0PK-vbI4OQ2q;
	Sat,  1 Mar 2014 10:57:37 +0400
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client certificate not present)
X-Yandex-Uniq: 87cb5a80-3b6c-4018-b9cb-9f4741b1daec
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393657057;
	bh=pTORkKYdlV1xy13mzNd4p5wcORdZ9ttp8yKokdUTEcc=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=NR/r46TOwYqeFsirnUJMfHBkco+XF6wBAZJ+ELdaxEy+lvA0zfVHLUhMYPtIfN2YO
	 9Hs3hBxOFLQ2EU7TpyXENYarQ1RqvKbPAY7J1CNHA9qc66jl5Wo7HWgzuKC7QCcFW8
	 Orc70EcGlV5dAL4fnB1yvzLoNEJGGWGg0Nvu0JVE=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <53109F78.2060203@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243048>

Michael,

On 28.02.2014 18:38, Michael Haggerty wrote:
> Everything looks fine to me.  Assuming the test suite ran 100%,
> 
> Acked-by: Michael Haggerty <mhagger@alum.mit.edu>

All tests passed successfully for this patch, at least on my machine.
Can I do something else to improve this patch?
