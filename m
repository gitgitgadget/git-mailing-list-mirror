Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F2515ADD
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="Hhvlu1y/";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="k6XmEzeN"
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CABD9
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=BT/8yf5c7LNDHH2IlwuNAQ+mlBSkYzsXDv8SFJcSF0Q=;
	t=1697441551;x=1697531551; 
	b=Hhvlu1y/YGwGh4m0etJiyETd2rI6RPS6nZUetFQCOgb1VwWNrT+5ucGC5vLl8LWVv/DMLfRUmqvWWB/2jC4b4Bcabx2Q3n8dUmYuxLMUiIVqlh/9ukS7xVQvyLQZnFe7ZPtFYGetM1Cs0UmO8cFjsxRPNBjgNlDP9b7Xayh3AGo=;
Received: from [10.12.4.10] (port=51214 helo=smtp34.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
	id 1qsI5V-001v2z-A4
	for git@vger.kernel.org; Mon, 16 Oct 2023 10:32:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru;
	s=mailru; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=BT/8yf5c7LNDHH2IlwuNAQ+mlBSkYzsXDv8SFJcSF0Q=; t=1697441549; x=1697531549; 
	b=k6XmEzeNtQmPsGGDfgOQw9q5N7Sb87VQl4qXCY6Im0gTPPCZns9dCvDcYj3leZzax1gYyy7Zmh8
	mlm0nYTGLJ17C4vGd2XtqFZNVJKSuD0zCf8fmFFdiaeYIqiHuehqe5ydNn6KsGk730rIfjM3WImq+
	9d4zHvPpDTHLgdrf4xo=;
Received: by smtp34.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
	id 1qsI5R-00DQXw-0z
	for git@vger.kernel.org; Mon, 16 Oct 2023 10:32:25 +0300
Date: Mon, 16 Oct 2023 10:32:27 +0300
From: Konstantin Khomoutov <kostix@bswap.ru>
To: git@vger.kernel.org
Subject: Re: You are marked as spam, and therefore cannot authorize a third
 party application.
Message-ID: <20231016073227.2c5qhmcr6z2dr7zq@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <c4880ac5-45b6-90ff-f730-6c66ba59f26f@infohubinnovations.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4880ac5-45b6-90ff-f730-6c66ba59f26f@infohubinnovations.com>
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD978AFEFB3096932CF13E7FB3349EB8EC0C23B91B6439F56BB182A05F5380850405B77BACE15BA0E1A18A43737339E0AEDEBD07F1A358C5928F2BD787EFFEE69DC
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7FCFCB92DA8654BB0EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373D58C44ED3182E498638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D857CB9F08A617E259270D6735632DD732117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC1A9C11735BBA05FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352026055571C92BF10FBDFBBEFFF4125B51D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA90A5971FBB7557E96D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE367F1C1C3ABB44F3AAD7EC71F1DB88427C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C17119E5299B287EE2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F83C798A30B85E16B42539A7722CA490CB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5348072F4224E751E2B5FCC8C6B3F4A2E523BC7F8E16967C8F87CCE6106E1FC07E67D4AC08A07B9B01E44367C8E80A7B4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34C0DDD40374D3501798DD50D2ECE3C902F22BF5DB9E923045BD1537345002EF512D7B40E9E66A47DF1D7E09C32AA3244CCD66D4FC0B90818757EC07823A3EFCB98580396430872480BC4AF6B5DE6957CB5DA084F8E80FEBD3B644FBF139BB3089A015563ECF9503F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojaEe5+VLEN6n+b/RGQOBV7Q==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD1382FC0E94CDA5D05B32B2A937B90B5A697AB4E52EF0D8536FB13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4DEDBBC46D76EB2520ED4F58DABF9B69518791C104F4FF5CF049FFFDB7839CE9E80FBBB2CB63C9CB5238AE29E3D8EC0D325CC300CD57527454E68A0529D4C4058
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdVi+mls5yutqyAoBka01a5w==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi!

On Mon, Oct 16, 2023 at 11:30:05AM +0530, Ramesh wrote:

> Hi GitHub Team,

This mailing list has nothing to do with GitHub - a Git hosting provider, -
as it's dedicated to the developing of Git (a distributed version control
system) itself.

> I am trying to clone my repository from local machine.But i am getting the
> follow exception that  "You are marked as spam, and therefore cannot
> authorize a third party application.". Can you please suggest the same.

Please use your favorite internet search engine to look for the exact error
message (that one in double quotes) - you will find lots of relevant material,
for instance this [1]. If you want to actually contact GitHub, use [2] and [3]
for further pointers.

 1. https://github.com/orgs/community/discussions/23842
 2. https://github.com/orgs/community/discussions/
 3. https://support.github.com/

