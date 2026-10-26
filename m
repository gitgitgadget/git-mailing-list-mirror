Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.97.212.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040163;
	b=4+txpTeOtdcMB09Teoo/wyb7t/6gEz+JRw8mU5SWfDvo4Xj0Ky+mTIGKqwMA+vQhRE5+
	 P90Vr+r0JqkzSduO1xUpdAvy0IVEGeEkNiFmHGXbP1gK7g9QF3gVCd2FWB0Ne8EcWf/Dy
	 JN1wFW7JlPwTrDrwpBqhDX1jJQLEWfXkCwXgTaNpUAWf4F1kZzXEf1vZGxTP8G1XaX4lW
	 X/nAHTBM6RK1QqwkDkLe7749MfIcLEYUlENF5QkP86B0CcQ4cqWcGZLRBQ4F4QAr/zx4w
	 dHXK8efz4YZrkIP+mgJ+2X3v4DZpvGCgohVrRen0ecLg/WpiSV9yUtc9FL4h48UhA8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040163;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:Content-Language:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:X-FN-MUUID:X-Scan-TS;
	bh=oLXDjaQl2U61M1w2iZ6XWyUCnV4DBRI6cmALCK6Iv6Y=;
	b=kmK1Ppeghtne6yV8ztSS2Ugc9xoMzEzcgvsSdzvqOo4FP+3jxOHECAYIGPnNpXRwqs20
	 NSbCggDDhgNvDrRrwR9JoS2A/QqJnU9+NKqknZQ5nYJacncoDnrZ9Uq1wHhrFhcWjZrjS
	 kqcj7rujxdl5CTie1Np5fDq3vn9iuVy7wJX7CU7qiAhmFRYsHZXUl3KlEy7upoMOn1u9q
	 Zoq6pXhHgBgO5/Uz0z6L7U8X1rISMJFdU2xqa+yJIf3xhOBuk4UWa5M9FhWlPa2Q/zGON
	 yB2+j16MvDlhHovtb5D23MLXO/LUIdnOupeUCxXSTai0lan6ypygO5YGGkJXCtjXglg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freenet.de;
	spf=pass smtp.mailfrom=freenet.de;
	dkim=pass header.d=freenet.de header.i=@freenet.de header.a=rsa-sha256 header.s=mjaymdexmjqk header.b=wDQ+8XvL;
	arc=none smtp.remote-ip=194.97.212.11
Received: from mout.freenet.de (mout.freenet.de [194.97.212.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EF606A323
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 18:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA3EF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=freenet.de header.i=@freenet.de header.a=rsa-sha256 header.s=mjaymdexmjqk header.b=wDQ+8XvL
Received: from [2001:748:400:2319::4] (helo=sub5.mail.fnrz.de)
	by mout3.mail.fnrz.de with esmtpa (ID ralf.habacker@freenet.de) (port 25) (Exim 4.98.2 #2)
	id 1xLPeU-00000002oLA-0a7h;
	Mon, 26 Oct 2026 19:42:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=oLXDjaQl2U61M1w2iZ6XWyUCnV4DBRI6cmALCK6Iv6Y=; b=wD
	Q+8XvLpr3dexcoBJ4LKD5M6guYNeLBlzSJ/k6zW8fkkROpi6FfoQmbuFXuR+IEEz8f0IS33AfCbLq
	0f2NPmTs0jEIYACFAaIbRea5CgnlJEy5xE0fMJvtd3PqJKgpIUPQKRxEu+zTpaEEvv5TpgYLfGk5m
	gXhT8L+HflZyGYu4eBuZ62k+mN0if+9n3odWO91oXXVqtS3683Ecy91D4fn3XyGf5Dl6lSPu7EjT+
	h9L8J3BRVcaNuHII2r64iBSax2bHQuKqJwAE4THkMkRHK9DF++g5z1Eqj48c1T0zh+Tf2bPZ44mL+
	ouSAhjC/NJX0JlOQQzhRTL9ruFzT5MaQ==;
Authentication-Results: freenet.de;
	iprev=pass (p200300cd0f3c810073f593fe8bef6f86.dip0.t-ipconnect.de) smtp.remote-ip=2003:cd:f3c:8100:73f5:93fe:8bef:6f86;
	auth=pass (PLAIN) smtp.auth=ralf.habacker@freenet.de
Received: from p200300cd0f3c810073f593fe8bef6f86.dip0.t-ipconnect.de ([2003:cd:f3c:8100:73f5:93fe:8bef:6f86]:59350)
	by sub5.mail.fnrz.de with esmtpsa (ID ralf.habacker@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 587) (Exim 4.98.2 #2)
	id 1xLPeT-00000003DIs-47sl;
	Mon, 26 Oct 2026 19:42:34 +0100
Message-ID: <57d4f046-26fc-4dd3-8a90-4132c5941ca4@freenet.de>
Date: Mon, 26 Oct 2026 19:42:27 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ralf Habacker <ralf.habacker@freenet.de>
Subject: gitk: add cherry-pick with cross-reference action
To: git@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Johannes Sixt <j6t@kdbg.org>,
 Taylor Blau <me@ttaylorr.com>
Content-Language: de-DE
Autocrypt: addr=ralf.habacker@freenet.de; keydata=
 xsFNBFw1IjYBEADqLhQbKxPjqVe9sKbVlAUt7N+YU/myI+HXdgjpeIKFeZRr3TFF0+pFJN86
 pJ35qME8QFlzKz4P9IT33n7OtXFG1Q1+Fxs1VZWUWbIkuWppZQ4EfUhnS1pRi7ztgmDdNzAp
 eNmjOyFRiUuUkGfP3QpayNNDny/5NrNfFe18sPtkE4tGJqqrcSiGK7/vbZq2abQ12a9I4Sit
 O1o4WPb1rP1W6Pp4R+6KffB8IdpXHn5AJC9Bsge6YDxzRxKwHkW91OxgPBc3BiNIcsJcnmAP
 /kd+9w1n9VVXLH9DWCHKr4/Iy7KYIitDSV+QTOAWDfXaKYh/l9baV3fvDD9x9hENdoCF2P3/
 1mWOa0wk3Zlnu+TXOCfFj0XuV5hpW7Epwg7figutltQ02VArMTzRDP5OpwOWx8LqRnnPrR+V
 msWIZWXi/fgm8wzQBF+h9wqXrVqCormWXXK+zadrG5aY0dVhml94E3MtRMmLpbIoO5C9mI4a
 w/uJFhxWan94G8g3YsFMTBdfjdVzzikhhELZt3N4OFPKNLGbUCGe1mGUkrMVh0TwhwhWLo9N
 Rdal11KKsU0wIgnLs44znzUraGXwE38SZQqiKS4AuoX8I6BCiMtKK15nj54UGxVxX79oCkqX
 8HbwZLJU25LbT2cO2MNd/x0i1ksVdUpSpHPIzRQqcZcrVwmd0QARAQABzShSYWxmIEhhYmFj
 a2VyIDxyYWxmLmhhYmFja2VyQGZyZWVuZXQuZGU+wsF/BBMBAgApBQJpLKFKAhsDBQkfxP66
 BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQEkMTLNkyF3HtvQ//dla3RzuRaJyH4P9a
 sqTyJci264d9d1RUTTaf5ckhR4TmJ6P800PlfspHaZoDQbAAPca8p42ZYjGsIYTXzToZ1sep
 iQLwVYn0BP0SVjh/qB2ZKqiJ7jrrwTJXqglplnjFhpQ22SWfZP/So0iZRCTj+lHuMzOcsRbN
 p9tGy7nC+R9k7KQVzoesizi8GIuV7+hLz6yZzxettZAG2N5L07bN95b2AZjTjsfZiSIL72tL
 vjaykiSWZ2WVg7XnF3pxQgxA0M0cUW+VAviRyHyhjV44h/Spuuo5FgTphkAxiEp+2YB5EAJU
 suXVmr5GaC55omXjYmW5eTPKdj4la6tmgSclboUZeMPjh88/eTwF9m4yJqvpfm5P1W79B8gi
 DHwp6GbcPXdpn1DRZbBYaDul6FxXzphjYIZFcPF+jy7E00VcWUv8szqh3i1paztyz6s1fuZ9
 cobk1f8wgQw5eii5PbX+vVuUugBkkuj8sSuYrDN66I+UKfOAeZn7nXwpCkxcyZky95ByloiJ
 ph1DPY7P4mpnxd9giLt7tIezER9mTSUNA5DtD5SOFJyotwrVEgNqRHLfsAT0PlFu2G7axpO9
 a4H5HHibCYmy2O+ukNLTJlMQCe5uszMoN/yWo29dVaqxHqMimj6gIvt4oKHuFzMMh26uwxNY
 yTlUiVQmztsjpthv7gvOwU0EXDUiNgEQALnfHOJ/jSNT+FJOThyWHwk/+bdSchkvNP0pT2iX
 qao8dLMTDcIePhY8xPy8tzl5zGiZsCRx9UmTYvCXMMAnZggvt0HFYtFqbgnUzDZLu415dezl
 P8GBHZUlaHZKs/7mizPDLesmABrCDXKqjP7lqjeK2iqa2a1Fo/yJoQh8efWR56SJqME2HHfB
 v22jPPCU2gZLh4kIo9R3G4EIXeOErh2ddFYwAKMS/4pUEVMpz0D9qhvjEFxBBKky0faB8oWj
 T3zblOtONXjQfxB15gI1lFAeL5pNarZiub0PPR21ieXEysrst4dMQcPqowKkHp99dHUc8B/P
 sLSay0t3SKXfAbfE32Uk+Kxlks8FYCI158c3DqjFg0zRfsERisLFeFoT3FOXkUxEp5x1JFqi
 2tlkintkVP1P11whj/uMDJcAoqPQHgS2dwnEal0eanjpB3xh9rQrmdm5HZhbZOkCV/+Au63G
 HXWxMz3PJxkD+X5HRnzgpTAHffnEXM+9QtVnHVqfDO5T5OjF5A+TTXQ6cGITgsXGbOm5FMHE
 99z+0PSXQuHhR5jRMVkogBiKaRUY5s/zowkQahT9PUEHMxfEHcjwD0+MU6Q/Jyatc+9DY+M3
 zhexL/NyPwSTay4X1foyVfpV7Lv7Zjwgo4lQzhyBdqlLa98JbtnAx+prkuwQ1uemqEjHABEB
 AAHCwWUEGAECAA8FAmksoUoCGwwFCR/E/roACgkQEkMTLNkyF3FbHA//TfoDWg2Xt6YS6bzA
 zp8KyjMELsR/gns3UFcDE68rDbyux7UF6/FCV2m2K0y0Ojn80LcNsSx2pYlbLjtppPbLatNA
 yHxYTsW20Qjp6YMM4Qy/ATVSLYqR6oN/jHG37uZs8YwwfdTdbUEBwyZhwtv9TW/en9SVPIeu
 3FnRdkhM03afSkM1CtBhNWfkTTOYJKaJOCUoxK2ZmEuxPi/Pxy0EphwsEPKHa4qJuA5Cfime
 IEN6ujUpVvAvHma8BNOUXoBDFeGSE96HD0RZjjmQUkqB4qb8rIcN+NZfCItiDSdqIfCwmNiW
 e3oYbHVfsoftuslnxCeJ+cWt/Oog3DYVKA5NSVcpySivX5mYVKNK+PwyUlD2aRj9ymD/Yx6w
 QrcgSuPAT+gZGPdckB/flu59otH1tWrJGK/PmhUQcyO1jaUtWXOnSIyazoUYdC4ydkAp24g1
 pZLhMVEPHUjiRHfrDiMeTG+qMymgEqUf2ChbEQGfUOAbCTs/ECC/pL9ADYgRObsnpSTNNa0+
 HU9KrY0Zr0kWN/NjqsEbGPrFltyGvVYFEXIbLeiD+HVM1e4n0RNvAO2OSY1W6xwyUIklSn2G
 BU7CQ57NlObP88CxGRwgNel4DU6zArH5+WInMJMj/U1kMPlbt0no+KlDjFUWlnB0mGH5VnH1
 fpySV6dQXYK3Ty4/LRk=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 179304015377E12C7C71F0O
X-Scan-TS: Mon, 26 Oct 2026 19:42:34 +0100

 From ae2217025407ff91f3ea3332f94d5b0bdcd01e70 Mon Sep 17 00:00:00 2001
From: Ralf Habacker <ralf.habacker@freenet.de>
Date: Tue, 26 May 2026 22:55:47 +0200
Subject: [PATCH] gitk: add cherry-pick with cross-reference action
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a context-menu action to cherry-pick a commit with a reference to
the original commit in the commit message.

This commit closes a gap in gitk’s GUI workflow for projects that
for example require backported commits to remain traceable to their
originals.

Signed-off-by: Ralf Habacker <ralf.habacker@freenet.de>
---
  gitk-git/gitk | 11 ++++++-----
  1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9506739c50..0c7db0a4d9 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2859,6 +2859,7 @@ proc makewindow {} {
          {mc "Write commit to file" command writecommit}
          {mc "Create new branch" command mkbranch}
          {mc "Cherry-pick this commit" command cherrypick}
+        {mc "Cherry-pick with cross-reference" command {cherrypick -x}}
          {mc "Reset HEAD branch to here" command resethead}
          {mc "Mark this commit" command markhere}
          {mc "Return to mark" command gotomark}
@@ -9167,13 +9168,13 @@ proc rowmenu {x y id} {
      if {$id ne $nullid && $id ne $nullid2} {
          set menu $rowctxmenu
          if {$mainhead ne {}} {
-            $menu entryconfigure 8 -label [mc "Reset %s branch to here" 
$mainhead] -state normal
+            $menu entryconfigure 9 -label [mc "Reset %s branch to here" 
$mainhead] -state normal
          } else {
-            $menu entryconfigure 8 -label [mc "Detached head: can't 
reset" $mainhead] -state disabled
+            $menu entryconfigure 9 -label [mc "Detached head: can't 
reset" $mainhead] -state disabled
          }
-        $menu entryconfigure 10 -state $mstate
          $menu entryconfigure 11 -state $mstate
          $menu entryconfigure 12 -state $mstate
+        $menu entryconfigure 13 -state $mstate
      } else {
          set menu $fakerowmenu
      }
@@ -9881,7 +9882,7 @@ proc exec_citool {tool_args {baseid {}}} {
      array set env $save_env
  }

-proc cherrypick {} {
+proc cherrypick {{option "-r"}} {
      global rowmenuid curview
      global mainhead mainheadid
      global gitdir
@@ -9898,7 +9899,7 @@ proc cherrypick {} {
      update
      # Unfortunately git-cherry-pick writes stuff to stderr even when
      # no error occurs, and exec takes that as an indication of error...
-    if {[catch {safe_exec [list sh -c "git cherry-pick -r $rowmenuid 
2>&1"]} err]} {
+    if {[catch {safe_exec [list sh -c "git cherry-pick $option 
$rowmenuid 2>&1"]} err]} {
          notbusy cherrypick
          if {[regexp -line \
                   {Entry '(.*)' (would be overwritten by merge|not 
uptodate)} \
-- 
2.54.0

