Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B3E381D8
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 02:47:15 PDT
Received: from mxout012.mail.hostpoint.ch (mxout012.mail.hostpoint.ch [IPv6:2a00:d70:0:e::312])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA448E
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 02:47:15 -0700 (PDT)
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
	by mxout012.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96 (FreeBSD))
	(envelope-from <widmann@tweaklab.org>)
	id 1qsge5-000Abf-0f
	for git@vger.kernel.org;
	Tue, 17 Oct 2023 11:45:49 +0200
Received: from [2a02:168:8e0a:0:1b94:a3c4:3fc6:76a5]
	by asmtp014.mail.hostpoint.ch with esmtpa (Exim 4.96 (FreeBSD))
	(envelope-from <widmann@tweaklab.org>)
	id 1qsge5-0005Sn-00
	for git@vger.kernel.org;
	Tue, 17 Oct 2023 11:45:49 +0200
X-Authenticated-Sender-Id: widmann@tweaklab.org
Message-ID: <7368e4ad-b05b-4b8f-a13b-0a68b442e72b@tweaklab.org>
Date: Tue, 17 Oct 2023 11:45:48 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
From: Moritz Widmann <widmann@tweaklab.org>
Content-Language: en-US
To: git@vger.kernel.org
Subject: Git Pathspec bug
Autocrypt: addr=widmann@tweaklab.org; keydata=
 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
 bhkZ+v+B2zl7/rDuq/EERBIBjvlj8A==
Organization: TWEAKLAB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Vs-State: 0
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I executed the following command in zsh (added `command` just to be sure 
that there's no aliases or functions)

command git submodule add 
'git@github.com:moritz-t-w/Godot-Onscreen-Keyboard.git' '.'
fatal: empty string is not a valid pathspec. please use . instead if you 
meant to match all paths

Git Version: 2.42.0

OS: Arch Linux

