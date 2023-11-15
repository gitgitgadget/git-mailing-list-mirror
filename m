Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="j5FRMUsq"
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9000D11D
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2023082200; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=h3rWGvV5cUi0+2nnqbmFZNy9549g7V0KqATfOrFj3XA=; b=j5FRMU
	sqpnwZaPoy4PZxRAia8Wpqt4EvGJD5ce9cqO5Xi6evQg/6eFVSZgsgLnNaVJevJVH4+LUpugZjzRi
	+ClPwOOjk9EA9Q/NZzQbMvfbrJkGDaeBUbKfbAxMfP7B4asjIbCnUoQbj71TRO7JPq+/drpIxduIs
	jed9KwQnESE=;
Received: from host-2-103-195-242.as13285.net ([2.103.195.242] helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1r3J7H-000AOD-Bq;
	Wed, 15 Nov 2023 16:51:51 +0000
Message-ID: <990ab7d5-e29a-4766-b112-c8908a7ed196@iee.email>
Date: Wed, 15 Nov 2023 16:51:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git Rename Detection Bug
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>, Jeremy Pridmore <jpridmore@rdt.co.uk>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Paul Baumgartner <pbaumgartner@rdt.co.uk>
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
 <LO6P265MB6736F5F9E8368A9DE95D294FFAA9A@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
 <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
From: Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CABPp-BHEX+SyophEfgRqDbNdrAS3=bptt_cKzHLBSutnBAxexw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Elijah,

On 11/11/2023 05:46, Elijah Newren wrote:
> * filename similarity is extraordinarily expensive compared to exact
> renames, and if not carefully handled, can sometimes rival the cost of
> file content similarity computations given our spanhash
> representations.

I've not heard of spanhash representation before. Any references or
further reading?

>    Exact renames are tasked with finding renames even
> if they are known to not be relevant, simply because exact renames can
> do so very quickly.  If we change that, we throw a monkey wrench in
> our performance handling elsewhere and have to rethink a number of
> other things.

--
Philip
