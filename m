Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5642EB1F
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="pkSIXJZ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="foRajjKm"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CE9FD
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 12:51:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D80D33200984;
	Tue, 17 Oct 2023 15:51:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 15:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1697572281; x=
	1697658681; bh=FsxaPt9ZU0KvKSZRIcXVyALGM6A3oIkGTksTcx36U+8=; b=p
	kSIXJZ8fdfVKb6YnP1ZhfzpYMVnnEHHJavDAoDcpQ7/wpsoL3OD4OWTcXf3n2zOB
	HDA5lPAXyELERk4E8uDmRtLCh9mlxXFe+it6l8u0cTqPARCp7SPEf99Lr+PDQRKS
	LXEeKwfR2ZjwZbgVlouPl/qggW+7dDUvlOusYTLFnbyNJxM+9+NFAOC5AA4OF8Tf
	w4Cmn1uzdsrzfGJdCeFh6gOLWvMSIl6dbs7YCDHNP8MP5etIbHOfxSD/NvI7mOlB
	imH5b4kuceDz/P4dJUUlv2oTMVTpT4N8KxjOMBCuw17MQd+ExBZqZmingd6e/2iF
	UpcguTpGIqx0MVIXJ8ZpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1697572281; x=
	1697658681; bh=FsxaPt9ZU0KvKSZRIcXVyALGM6A3oIkGTksTcx36U+8=; b=f
	oRajjKmZwUFelR/nmliiBw4V07pF9O5VIqElyZtdGZm++cqvxGeug/lUwNFP7PTO
	Adc+h50FKtRvLsvMJSqiCM4/ZIs74QLnP4nrqmNBObgc6G3UwyyH9HsOX2qXwhHZ
	WNmVXeLW9jYSxq488l3T0N++Q/9uV3J25/yNGYk43E6sWxtiiSDBrTFRF+2bDJPP
	SBT0lxFGztdRxorr0kuFn4Y6mOG2oG4OdiPBISGHpulfb/zvnhd+3j/pPctmAWK9
	BLiNMR3PCOKn4xB7A8m2jRPNU3b7K/2PCi+r/9aW1DEXHkDMg2rIo9KDLqEVMVU/
	CSdRoOYGtexAS+ViMEeuA==
X-ME-Sender: <xms:ueUuZac0GTjOAg2igM6diJ5aZ88ZjkgyiiwbGpsxXgZ3sAtzoXDBfX4>
    <xme:ueUuZUOR8ys-MjAt6zCl4CmkSXw9FGdUCGzaOdilZPXcyuUwHKd-qVplEgSko-imm
    IJdoFSmFT5Rn_hsZw>
X-ME-Received: <xmr:ueUuZbhjW4b6VRUweH2__LkZZy-tAN9QkOq9x6gUAaJtBk2I36VVGUKUTd66aHZd3mbgUvQdngQDfMH8PvF_hW3zHGqA6NGgFp_-bxK7cwtfbPJoW0Xz1cO6Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddufeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepteduie
    ehgedutdfgudevkefhveduieeiteejhfffteeitdegjeeihedthfejgfetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruh
    hgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:ueUuZX8xBBPR6z7fpfF7tWbgPNQwvTIQoh060d0X3C8laeooV4IZdg>
    <xmx:ueUuZWvxmNxmGkRHlJbMIuKrDVColaVXwS-Lz6rlGv6ySGRKcw9Osw>
    <xmx:ueUuZeGIjy9Ok4KyPsSljREOEBwM8RXBwcicl91Tgm8S5ShKjUn2vA>
    <xmx:ueUuZaLJsbStSKyZh6Dfn4qAIUR-7fDuHLoAnDyM2GrqrUK6t1DAwA>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 15:51:19 -0400 (EDT)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: gitster@pobox.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	ks1322@gmail.com,
	peff@peff.net
Subject: Re: [PATCH] grep: die gracefully when outside repository
Date: Tue, 17 Oct 2023 21:51:08 +0200
Message-ID: <f8a2abc0f610912af3eb56536ed217b8f90db2f9.1697571664.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.42.0.2.g879ad04204
In-Reply-To: <xmqqmswhjj48.fsf@gitster.g>
References: <xmqqmswhjj48.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023, at 18:42, Junio C Hamano wrote:
> It is curious that the original has two sources of hint_path (i.e.,
> get_git_dir() is used as a fallback for get_git_work_tree()).  Are
> we certain that the check is at the right place?  If we do not have
> a repository, then both would fail by returning NULL, so it should
> not matter if we add the new check before we check either or both,
> or even after we checked both before dying.
>
> I wonder if
>
> 	const char *hint_path = get_git_work_tree();
>
> 	if (!hint_path)
> 	        hint_path = get_git_dir();
> 	if (hint_path)
> 		die(_("%s: '%s' is outside repository at '%s'"),
> 		    elt, copyfrom, absolute_path(hint_path));
> 	else
> 		die(_("%s: '%s' is outside the directory tree"),
> 		    elt, copyfrom);
>
> makes the intent of the code clearer.

That doesn't work since `get_git_dir()` triggers `BUG` instead of
returning `NULL`.

The `hint_path` declaration has to be at the start because of style
rules. But we can initialize it after.

I can also have a second look at the test since I am using `grep` to
test the failure output and not the translation string variant.

-- >8 --
Subject: [PATCH] fixup! grep: die gracefully when outside repository

---
 pathspec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pathspec.c b/pathspec.c
index e115832f17a..0c1061fad11 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -467,10 +467,11 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		match = prefix_path_gently(prefix, prefixlen,
 					   &prefixlen, copyfrom);
 		if (!match) {
-			const char *hint_path = get_git_work_tree();
+			const char *hint_path;
 			if (!have_git_dir())
 				die(_("'%s' is outside the directory tree"),
 				    copyfrom);
+			hint_path = get_git_work_tree();
 			if (!hint_path)
 				hint_path = get_git_dir();
 			die(_("%s: '%s' is outside repository at '%s'"), elt,
-- 
2.42.0.2.g879ad04204
