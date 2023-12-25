Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827437E8
	for <git@vger.kernel.org>; Mon, 25 Dec 2023 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="ocbiLSWf";
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="dGcLy9Mf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=qzfX85xIrfr9+jPjuCTvhhui1Lk5zSZv+v8/wDWe8Ng=;
	t=1703470046;x=1703560046; 
	b=ocbiLSWfLieYvVyshkf1UbVmNaps6UmcKPSBnckdKMQHG6XIrtQE9e0p2DgJfE35evWimo7HgABofQuip4mH3aCIaEGaCMdh5mMaQHlo0QtMO4KetQD+gIrksRxWjSoSKZFbNkJr6wCnFW5F+sSDeqCFJDKMo/eBMJZIxExNNZzgfUMcrQBTpkG/XMgxGuHeRkxjhtyagx2P0y5HtYl6v6zY5Z9+MMBIjzEREOuy9Y5PnvARamRTnmm/7II5g71bhl/I1DHcKBD63xbQgs3nHzpoBxKvIgiJlhMNrE2/s309/HQfWS9xY+RLzdTnAjUcY/LYw1vTUlf5CxEL7HUT2Q==;
Received: from [10.12.4.12] (port=45652 helo=smtp37.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <andry@inbox.ru>)
	id 1rHaNB-00F6d5-Qy
	for git@vger.kernel.org; Mon, 25 Dec 2023 05:07:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:
	Message-ID:Reply-To:From:Date:From:Sender:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=qzfX85xIrfr9+jPjuCTvhhui1Lk5zSZv+v8/wDWe8Ng=; t=1703470037; x=1703560037; 
	b=dGcLy9MfQRV3M3Z2ecHzeOTNh9GnGjSm+6RWrls9UtJepcwhNOxsvYdG7jnYmTksCxD6L9hQzDT
	FVXZeTUj9R0UvjZWTYGum/hnhjzg2fr6SqhUk62Jqm9VNhn1wszVPa0JHjQucBa66rA4FwccC3A2u
	+LqydPXaO88gV1+oxGBrx840dpYzEGTbWHlmNaW/jwvQD57pjUwZ5cj2YwkpClfkMOLdUUdoaWjWT
	w3EI428VDFEguAwweZR8kA5O+5HFDn8fbrSC+wUJz+Nz88t/9W+H0bznFJ/GMtrMg5tCRaAAZcx6+
	DPjuPQ8V87dD+3WmRRj9lttR/kjTmYT88eVA==;
Received: by smtp37.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
	id 1rHaN3-001sDy-05
	for git@vger.kernel.org; Mon, 25 Dec 2023 05:07:09 +0300
Date: Mon, 25 Dec 2023 05:08:45 +0400
From: Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <31177532.20231225050845@inbox.ru>
To: Git <git@vger.kernel.org>
Subject: [FEATURE REQUEST] New method of commits range selection
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9344F665CF1C84C2976356D4BAB86AA771558E53B0BF89E43182A05F5380850404C228DA9ACA6FE27BF7DC625367BEF7DED956C3FA14815C17F150E74425F1B80B773821DBAB2AA56
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE76ABD3380F320B62CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CF05F7050DCA185A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D859413D28E12632D383E002A77EE6E1E06F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7820CF4CC0E318EFB9FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC4F899C782A27D90A3AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F790063714BE8CF23D097210D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006375CA0AC343891687B6D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F790063717E6A56809D3D6D1EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A59FE0D7AD714B94AF1985E94D94688A5C7F3818F7AA440AD6F87CCE6106E1FC07E67D4AC08A07B9B0DB8A315C1FF4794DC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34D16EA493CC1FD9F849A7F74191CD174C9034AA130D9B7C3BA2B81CF330B5DD8D5BD02F887ED649B41D7E09C32AA3244C6433D6C388B9E485CA6F2638A1027C5F05AB220A9D022EBCBC4AF6B5DE6957CB5DA084F8E80FEBD3B6B12ABA45D4B9D28815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXi6tDZSyNd16wYDsO+g00Nq
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E3BFE1DE69B357D18ED956C3FA14815C1833BA981C660244658EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B46003E5D5A82ECDADC2F54683050715110AB5A3603BB3018A049FFFDB7839CE9E7BC894BEB245308557927EE40185EDF5DF81EBB6AD18711616AF61A25D9FDBD0
X-7FA49CB5: 0D63561A33F958A5E5DF776BB13A8A98C7291686551047CCD1B9B0330CFC9051CACD7DF95DA8FC8BD5E8D9A59859A8B68F8E560BB31819B2
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFd13/ESPkUJS1VkPven9JPrA==
X-Mailru-MI: C000000000000800
X-Mras: Ok

Hello Git,

I've described the details in the GitHub discussion: https://github.com/orgs/community/discussions/56342#discussioncomment-7882789

But because the problem is related to the Git commands like `git log`: https://git-scm.com/docs/git-log

Then I think it have to requested from the Git developers.

---

Even more reliable variant is to reverse the second end point search direction in the commit range.

Instead of search from the top to the bottom of a tree beginning a branch tip, there is another way to search from the bottom to the top beginning a commit or a tag. This is better because there is no need to exclude anything else, because the search path is an intersection of both search directions in any potential tree if both ends exists.

Examples:

Search from the top to the bottom:

range: `d3^...dev`, where `...dev` - includes and searches back, `d3^...` - excludes first parent and searches back

```
Example #1               Example #2

m1 -o- master            m1 -o- master
    |                        |
    |   o- d1 dev            |   o- d1 dev
m2 -o   |                m2 -o   |
    |\  |  o- tags/t1        |\  |  o- tags/t1
    | \ | /                  | \ | /
m3 -o  \|/               m3 -o  \|/
    |   o- d2                |   o- d2
    |  /|                    |  /|
    | / |                    | / |
    |/  |                    |/  |
m4 -o   |                m4 -o   |
    |   o- d3                |\  |
    |  /                     | \ |
    | /                      |  \|
    |/                       |   o- d3
m5 -o                        |  /
                             | /
                             |/
                         m5 -o
```

Selection result:

Example `#1`: `d1, d2, m4, d3`
https://github.com/andry81-tests/commits-range-selection-test-1/compare/d3^...dev

Example `#2`: `d1, d2, m4, d3`
https://github.com/andry81-tests/commits-range-selection-test-2/compare/d3^...dev

To exclude the master commits, there is need to add more exclusions: `{d3^,m4}..dev`

This will give invalid selection for the second example, because `d3` would be excluded from `m4`, because we need to include *at least* all `dev` commits.

Instead of add more exclusion, we can just reverse the second end point search direction: `--intersect d3..dev`, where `..dev` - includes and searches back, `d3..` - includes and searches forward.

Selection result:

Example `#1`: `d1, d2, d3`
Example `#2`: `d1, d2, m4, d3`

This does not require to actually search from the `d3` up, because only requires to collect all merge commits down from the `dev` which might has path to the `d3`.

It does not exclude all the master branch commits, but gives a cleaner result without additional excludes.

