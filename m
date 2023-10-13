Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82529A9
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="RSqHRrt4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="npuvUlg4"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5D0C0
	for <git@vger.kernel.org>; Fri, 13 Oct 2023 08:08:09 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 7D2B232009B3;
	Fri, 13 Oct 2023 11:08:05 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 13 Oct 2023 11:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1697209684; x=1697296084; bh=n7+g7gwrLDBuq4Ct2c1sPqyQv
	700HlM/U6kIwJtKDcM=; b=RSqHRrt4Y963NZMWABNj3iPnIw1NPjAzZxQG78NlB
	UQAWTtCoGZNKooX5W/WmCgJ8qWsDw0v/hz13uXS/oBBiIaooDsa0VkBb+gTamefW
	O42AWaFfnlW5hvGxfJQoZmsieGRI0QwIw2myAnR6qKa8lXp/2xeqxVXdt3s+ZD6Z
	VFADPyl6E6nh7IPgOtOle62IVSF1IsEivq6MepCR0dyARIc0wFkpkNtVc+Z+/EL4
	q6eGTboIf62wKC9xvqtjydJyInoQCyrd9Z8i+hTRI+76JWuT35TjgXREHMjX9Q5I
	djQQEvHBzFrOEprhBHvqIAlB+BCTHZ/2yjrNUJfaUVOtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1697209684; x=1697296084; bh=n7+g7gwrLDBuq4Ct2c1sPqyQv700HlM/U6k
	IwJtKDcM=; b=npuvUlg4+rJ7IcA9hKjWt93XV6mOCBVvxpp4mBiTjG4pmvZpWNw
	k1aTMyPYBiSm1+OZEbaU90WE16A958ivFISLWCORp8LVoGwnEn1Iyp38NUCXP0fF
	87AZvWzvJs/0xHGeOQRzjXKhJQfLe/1XFoS9tIOAsmibhP8mkeuidCZI8tMnC3eg
	ARtkbu4VIdcp1ZnFH7VcPyD5vVgvEkhO25yF1E6rVj2JR5oudbMKN1IXWDyUvRBW
	9nIU7Iu6JD+vpAm3UjCQaMwXeOPRqIyYRKKHwh1TcAIs3i4uYIqWui0pXsVoh/Nz
	FI9mKzkhQKF60iF5DEnc3TSlux1YMzBhL6A==
X-ME-Sender: <xms:VF0pZXHx97fd1wcI3LrUcg0CJlgfzVx_yrIkFJ3h9NzsG0wTomgk9Ww>
    <xme:VF0pZUVvn_FwxHidkLSh1t2rL_z2D4tZojDqbKD0TicOsWrP36AEHDK_CdupoVNq4
    a3kpoadEUliIKcJZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrieefgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdekudevtdfhleeuveehffehvdevieeu
    ieehheduheevgeeuteetuddutdefleeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:VF0pZZK21n9jOfANIp48TF5bZ5nidlya1-C0hWgybHuBsm1ge6Gnsg>
    <xmx:VF0pZVFU7oVIng5_AvGphvdTXUOdiPqx9dJTE7LphA0liaxwQKCjwg>
    <xmx:VF0pZdVwKlvuwZVKmxYdWj0l1mBOEBo_7psHL-nOXQo1I836mXKZmA>
    <xmx:VF0pZajjIHPKSDV_fdLWqCzPyaPuULiI9JKWPoX5ffkHe8qo7wz2pQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7A86315A0091; Fri, 13 Oct 2023 11:08:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c026e59d-c2ad-4ff0-8a83-e0b7925aec67@app.fastmail.com>
In-Reply-To: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
Date: Fri, 13 Oct 2023 17:07:28 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: entwicklung@pengutronix.de,
 "Michael Strawbridge" <michael.strawbridge@amd.com>,
 "Luben Tuikov" <luben.tuikov@amd.com>, git@vger.kernel.org
Subject: Re: Regression: git send-email fails with "Use of uninitialized value
 $address" + "unable to extract a valid address"
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023, at 16:14, Uwe Kleine-K=C3=B6nig wrote:
> 	$ git send-email --to 'A B <a@b.org>, C D <c@d.org>' lala.patch
> 	Use of uninitialized value $address in sprintf at=20

This looks the same problem as https://lore.kernel.org/git/ZQ1eGzqfyoeeT=
BUq@debian.me/

--=20
Kristoffer Haugsbakk

