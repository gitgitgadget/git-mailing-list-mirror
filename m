Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F315AF7
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37308D6
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 04:01:37 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 1F5C923F67;
	Fri, 27 Oct 2023 07:01:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qwKat-boT-00; Fri, 27 Oct 2023 13:01:35 +0200
Date: Fri, 27 Oct 2023 13:01:35 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ci: add support for GitLab CI
Message-ID: <ZTuYjzOfG0y27Sho@ugly>
References: <cover.1698305961.git.ps@pks.im>
 <cover.1698398590.git.ps@pks.im>
 <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <37a507e9b255dd40c0536438dfe3fa05b067f08f.1698398590.git.ps@pks.im>

On Fri, Oct 27, 2023 at 11:25:41AM +0200, Patrick Steinhardt wrote:
>+	export GIT_PROVE_OPTS="--timer --jobs $(nproc)"
>+	export GIT_TEST_OPTS="--verbose-log -x"
>
fwiw (as this is again only copied), export with assignment is a 
bash-ism (though (d)ash started to accept this syntax some time ago), 
and not all of the including scripts ask for bash (i didn't check 
whether they are using these functions, but the inconsistency is an 
armed trap).

regards
