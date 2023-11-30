Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 11:34:11 PST
Received: from shells.gnugeneration.com (shells.gnugeneration.com [66.240.222.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51493
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 11:34:10 -0800 (PST)
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
	id 14192C009F3; Thu, 30 Nov 2023 11:26:37 -0800 (PST)
Date: Thu, 30 Nov 2023 11:26:37 -0800
From: Vito Caputo <vcaputo@pengaru.com>
To: git@vger.kernel.org
Subject: Minor UX annoyance w/`git add --patch untracked/file`
Message-ID: <20231130192637.wqpmidfv2roqmxdx@shells.gnugeneration.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: *

Hello list,

Couldn't the following two steps be done automagically by --patch:

```
git add -N path/to/untracked/file/wishing/to/partially/add
git add --patch path/to/untracked/file/wishing/to/partially/add
```

when one simply does:

`git add --patch path/to/untracked/file/wishing/to/partially/add`

?

Cheers,
Vito Caputo
