Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0722258C
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718391; cv=none; b=NENUmf1XBCcrmpV99PBiDsfEAEBQn6Msoaje60aDrmDXOJl+By9O+M9HtTRwxg4wrM0ZIfLe6UksgjHTeGyBHkOlf+nGboBVrQITeFp2GMBpQPQ2vGTT970wYv6d4XF/V6a1To1lhS9OoO5qBKpU93PWhWKGcTYqhYc9En8QHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718391; c=relaxed/simple;
	bh=v6W92PxC/aPBh6tAR0TRnex84pz3Gp5/WeSxMrcYHvI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7HYcnPOejJlm0t6y7eCw/HFJbkmnXRRDfVu667oWsHCXM+VknLJIvHCw/svuKYowjR7AYKFw94IWsEPrf/pDEdXTbuVtjWtLaYOt3teuh3Q7mnn9qUC/PNXxicQIK3JRe9cju6JmIleq/60O24DIACQdC+QDJ+QLH9d4LSZJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=lkpIajly; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="lkpIajly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1772718380; x=1772977580;
	bh=CuFkHCbZiDt1dmFzB0S2ol4nugbX32kX6r6N+/LtCtg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lkpIajly5W4h0A/dxVu45IgvNF+FuO0x6Du6iiTfWQy6cknKJZgnHjsf4ZDtYUVMA
	 HNMMvrUp6A1OOLu8S36ssek3QeK1CvGGUigK+vwcQssxKuoSrdjxsXoWmkMciu4kPZ
	 6lfUeHckGbZtPrdgvULaiti1Xz/aR5yMB7mH9bUV7xhAVT5PFmJMkldi9pRRtVIs4H
	 1hiL9ay5M8/+sP6zba7nv+fq16rcsdskYrvOLkrjEqcANFA1G5u4LQpx47YGEVLQhN
	 PO/imtF3rWz2uUFAnnftb4bvPFeSfsUPs3CmZ581eyGKNxNx0sCmmU4RpXpQwicxT2
	 iqokogbDPS0Rw==
Date: Thu, 05 Mar 2026 13:46:16 +0000
To: Adrian Ratiu <adrian.ratiu@collabora.com>
From: Chandra <Chandrakr@pm.me>
Cc: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] add: support pre-add hook
Message-ID: <i6rBoZXrLVKU8Yc6UtDNpPB0KJ8dbQlyGzxKF_ofhIiSfScuKHcJHewPAmWX3kiF5vr9uNuSQkJg7NbCV9VEKfMs-ez09VKhfMX8u84n5qU=@pm.me>
In-Reply-To: <87o6l2xuku.fsf@collabora.com>
References: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com> <pull.2045.v5.git.1772714253412.gitgitgadget@gmail.com> <87o6l2xuku.fsf@collabora.com>
Feedback-ID: 10057713:user:proton
X-Pm-Message-ID: 3c7058de3a6bf48e1f50316d5ff54e428aa77cc1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

Yes, I used Claude CLI to suggest changes in a markdown file and then added=
 some changes from there myself. Claude suggested a test to do what you ask=
ed here, but I thought it redundant since after the hook is discovered ever=
ything should work the same. Claude agreed, but AI tends to agree when you =
push back on most things. Please let me know if my intuition here about tes=
t redundancy was wrong and I should go ahead with adding that exercise.


Chandra Kethi-Reddy
@archonphronesis:matrix.org

Sent from Proton Mail for iOS.

-------- Original Message --------
On Thursday, 03/05/26 at 19:11 Adrian Ratiu <adrian.ratiu@collabora.com> wr=
ote:
Hi again Chandra,

On Thu, 05 Mar 2026, "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@g=
mail.com> wrote:
> Range-diff vs v4:
>
>  1:  9383395bb0 ! 1:  fc58c4cba2 add: support pre-add hook
>      @@ builtin/add.c: int cmd_add(int argc,
>        =09=09string_list_clear(&only_match_skip_worktree, 0);
>        =09}
>
>      -+=09if (!show_only && !no_verify && find_hook(repo, "pre-add")) {
>      ++=09if (!show_only && !no_verify && hook_exists(repo, "pre-add")) {
>       +=09=09run_pre_add =3D 1;
>       +=09=09orig_index_path =3D absolute_pathdup(repo_get_index_file(rep=
o));
>       +=09}
>      @@ t/t3706-pre-add-hook.sh (new)
>       +=09git commit -m "initial"
>       +'
>       +
>      ++test_expect_success 'hook found via core.hooksPath' '
>      ++=09test_when_finished "git reset --hard &&
>      ++=09=09=09    rm -rf custom-hooks &&
>      ++=09=09=09    git config --unset core.hooksPath" &&
>      ++=09mkdir custom-hooks &&
>      ++=09write_script custom-hooks/pre-add <<-\EOF &&
>      ++=09echo invoked >hook-ran
>      ++=09EOF
>      ++=09git config core.hooksPath custom-hooks &&
>      ++=09echo changed >>file &&
>      ++=09git add file &&
>      ++=09test_path_is_file hook-ran &&
>      ++=09rm -f hook-ran
>      ++'

The test you added is rather surprising, was it written by Claude AI?

For clarification, what I asked for is to add tests which define the new
hook via configs like done in t1800-hook.sh tests, for example in your
case, you can define a simple test like this:

test_config hook.my-friendly-echo.event "pre-add" &&
test_config hook.my-friendly-echo.command "echo hello from hook" &&

See Documentation/config/hook.adoc for more details.

The turnaround in minutes between v4 -> v5 is also surprising.
Please give humans a chance to review & respond, at least a couple of
days between resvisions. :)

Thanks,
Adrian


