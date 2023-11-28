Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail.zombino.com (c3.zombino.com [91.107.222.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35405C1
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 06:15:01 -0800 (PST)
Received: from [10.168.5.44] (unknown [81.95.8.245])
	by mail.zombino.com (Postfix) with ESMTPS id 3C48193D1E;
	Tue, 28 Nov 2023 14:14:59 +0000 (UTC)
Message-ID: <2e5e3225-6e94-43ff-ab7b-18aed2048372@zombino.com>
Date: Tue, 28 Nov 2023 15:14:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Content-Language: en-US
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
References: <20231117202513.20604-1-adamm@zombino.com>
 <20231117203253.21143-1-adamm@zombino.com> <ZWTxuBV1DGieo6n2@google.com>
From: Adam Majer <adamm@zombino.com>
In-Reply-To: <ZWTxuBV1DGieo6n2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/23 20:44, Josh Steadmon wrote:> Two suggestions for the test here:
> 1) Can you give the test a more descriptive name, such as "GCed bare 
> repos still recognized"?
Thanks, adjusted. I've also added that empty refs/ directory is not there.

> 2) Can you add a check that bare.git/packed-refs exists?
Done.

I've also removed the -C parameter since we actually need GIT_DIR= in
all cases to prevent git from going up directory tree. -C is then
superflous. In addition, I've changed the hardcoded object id to master
branch to make it less magical looking.

- Adam
