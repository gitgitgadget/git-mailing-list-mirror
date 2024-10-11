Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C920C497
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728639539; cv=none; b=gSu5sNjWIz1gUgrYIOko5onk7iDFJ+At5Kx6UP996NFzn+cN2irNTCa2pMP+hlku2l9epllOwpGhNUb1ZxpQmJIrc27iWfcbLb4/sN1ys3tjGppk1/mYYZoMx2pny4vvXrGuvEwAqmdLIU1Cf3wOzERs8FHZuLVVwKU5fNfzzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728639539; c=relaxed/simple;
	bh=YGTRhjfwc2FBzZrGCd+NCwihIhtr7zgzH+7Q3f6g7o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7o/KsOaDoBMPK8jGncRX+CrAmuVtBETZ6PcNESoA9mcrte5IWKeX8v13eyxZ6CvAGRkYNBK36hU7sPAmWvwEKliOJKxmuxZScIJx2WjyLcoYNz2HI0XYaRkHj+jkA3f+UzDHJ1i+gk1/En4k+Va15+EDX3ext4l2oeZKg98KVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=Dusg1tRN; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="Dusg1tRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728639520; x=1729244320;
	i=oswald.buddenhagen@gmx.de;
	bh=YGTRhjfwc2FBzZrGCd+NCwihIhtr7zgzH+7Q3f6g7o8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Dusg1tRNycodgn5CpUebh0NWta9Ee1ECwx6+yChxWW0KZz4Vb2H188mpoNNA0AlH
	 Thu9xbS/uCUMQN0GQKXveRPM59WRbgifCwsqwEabPTRL1dT+5eCeJkQewENoLeN5v
	 Qwoi6BrPkpsJHgMSFtYbmKHAmgd0AjIboBxY+UMuaVGSvwVDcLwluzPogiqSDSfz2
	 xp3Y+CW9V+j3NbefrECp2t8fe5FNAwl5wiF0T9WCm72gDL30dM3kvEEAFMNXxazJW
	 OKbNewZMuXxK0tPSi+Nb6+ifoWg26hjgv3PU65R8uPNUn2fl5yR3qnz7+fGDXGFmv
	 yXXQc6I9hF8b9ZsGmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.125]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DJv-1syNpN2kcn-008iap; Fri, 11
 Oct 2024 11:38:40 +0200
Received: by ugly.fritz.box (MasqMail 0.3.5-13-g85b6fce-plus, from userid 1000)
	id 1szC6Y-d1y-00; Fri, 11 Oct 2024 11:38:38 +0200
Date: Fri, 11 Oct 2024 11:38:38 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/13] INSTALL: require Perl 5.26.0
Message-ID: <ZwjyHl98xRs9TDQZ@ugly>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241010235621.738239-13-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241010235621.738239-13-sandals@crustytoothpaste.net>
X-Provags-ID: V03:K1:Q2+NoH8qZybr5bT1X6/gKuJELsQ/dwC3FQzgLbZDXDYrDzmbhE5
 w3mwrH7tozVEh3WRmkx+9wX6gRDHwiPPwZT3rEJoZluo5P4vEUC1cOn2/rpl+mV2cElQiHG
 VBZcqbUDiXv8SvR3MY/y6F1zCqGdEnddmk4mNM6/hzH4XZhqV8Ncs3MKEK7wHbIXmPo84XH
 7zVda0I3fxldUj37EnQOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fZtk/VHYgys=;YMgRMbTjakzWEy0dFl3xlPjZF2w
 Xzn0eU/l2vP5J3qjkRaRjLL7vfXlp72fTXXc5tSNY9KRQ+n8SCx1G05IRGi3V5bsMcxzl7f+l
 sxOscxujLqbuQ1/gYIgP5fPAnYXC/CH959vsmpBsYhYeFWm8DVeJUBNJdjepJ6ToziACtCtba
 zQfqmOlqz7DzCuqJpJ5QN7xTpElcM4Jixw7POYhtT00rWHMqDJEObdgabxkEHidT6Vp51iPCh
 Qoa5BIjYMNOXt9gmA9nxbuyHJa0aFsnyW4qhXupp6EVs+1YV9c2Z12TwEpjqPVc0vTaWDeHj0
 rKqI19hAELWiP6Opg5j8XPYVQcEHH7i9vRTlJMrtE2OEUym4eRVkQfln1m6v34At6YrbkaBQB
 dnuwvUfn3rE//FBQVfuTSDalyHQlIv+9t6hqDVmHZXorA5xg8Am0S3qQDEVw7iVuqW+jtMThV
 tCQWwfGq3aUDa6LPstC5hu1s4dnMAVBZ0BatvYTdZ0w0K+RGdpCAUW/vkmPswMI2w4+rTMKxA
 o4UrKt4qwZcbEJMEwjWPEFDdEHekeIoW4hNqhUNuCb3r/0uxiwnedR7P7REKQ70MPn82EtjAI
 zhuyiZ4NXoyiRf9cL+0phzqNCF0ogTO1e5FDi7Vdb+PrsV7V7NEN0TAKcTtLKdXG+rtr4a8HB
 yclsJGG+ggEjmZs/iJlDJN/jqpEm6qNSY95b6EV5OUyBq9yNdGmGTKFAw3+/UMyLoVzs9mahO
 epl4AMP+6fcrPWR4qYQZx+LZ3K1UKgB0nmEqaFxuolML6tKxIV2f9to8maIKwbEq1gP9m9ADc
 bnSGUh8DaegJfapqZgXJMKQtZ1vxapZvvC4+idVOg+vZ8=
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:56:20PM +0000, brian m. carlson wrote:
>Update the INSTALL file to reflect our new dependency requirement.
>
any particular reason not to squash this into the parent commit?
i see how the separation makes sense for the libcurl sub-series, but
that doesn't seem applicable here.

regarding the actual `use` statements, you could make them somewhat more
legible by using 'v5.26' as the version number.

another aspect to consider is that the statement doesn't just specify
the minimal version, but also subtly changes behavior. for example, the
`use strict;` statements become redundant.

cf. https://perldoc.perl.org/functions/use#use-VERSION

lastly, it would be nice to update the build systems to reflect the
version requirements. though the only pre-existing version check i found
is the libcurl one in contrib/buildsystems/CMakeLists.txt.

