Received: from outbound.ms.icloud.com (ms-2002l-snip4-3.eps.apple.com [57.103.74.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37238A73C
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871530; cv=none; b=L8hQTF1y5XPoFgt6JIV/dNB24v4Ky9p1TFqhCVhpnA8toSCVFBFZksVXEoAvNcqPmJmzsw6Dg5vqeRvhHNsHqAnmEz/MRUmwzmJbupYy6dAWsD5S4A8TEoXC/I1bJ4eM38jPm0OZsTIdIaJRlIB/i15EEbj0te9sFVqSl1Xm1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871530; c=relaxed/simple;
	bh=o6FCcO6VhipQ2kcf0S2oVuKopD8zUKF+deSRNbt7RIA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=gVKeKTur7mWDmC79ap68xbSAj/To7JtdYF/qsX7IBLvNlLxQ9gcsa+FlmUNHEMaZDqEt9jX6JQ3L3kw+rpsXez2IGpQGaoi1KkIWChS+mOVG2XS/Ok4CjgI/l2+rVeQNX6BisVYv0N8ixlbYzotaUoCWvefjP0qerxD8FIBfSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bi6iUo8M; arc=none smtp.client-ip=57.103.74.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bi6iUo8M"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-4 (Postfix) with ESMTPS id E345118000E7
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 09:12:05 +0000 (UTC)
X-ICL-RepId: 01a009d7-b1d6-7c45-9dd2-ad275654c4f1
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhABEMGUgJeCEwFQwZdAVBcHA4GVhtbE1EZQQFOK1sTVRdGCRkIXR0ZHldQXgheH0wcHQ5YBhICWkUCTV8OXh8EF0YZVQRHHl1WXh4ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FDy4GKgpJCUEGQActAkkUTHEoBkYLNHxBHisELwo2AE5wL3FecDBQG18CQg8cE1YVDU1DEkIVBBFQAVgeVg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1786871527; x=1789463527; bh=OuPghp8nZlvdwx/JeSQ4WKCP0pmZRV81eFdcdlEq7+w=; h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme; b=bi6iUo8ME76UUaS4ftaCUeiuthzT5jhAamwO3wqYJTpbkyjbe4aPxFMgvPXNO+PlUrkmCnAj4miZzeMtvxiBfV8XZG9Efhae/S1EYtb9qS+ZFZhroc9b68tyEVcKkK5U8LQaTWgfXCVZCo0uELSyrhVukaxTRUFZSGeJqzAQrjb3z9qB5Or72ltMm1mkizz4jnrnAblzPrO5G9vf5oLnM0kVjJZxujbQj/l/xPS3wL34qOpl+H0jvAiKl+y6WYeBFJvfx5WCcU6IFBpL1rP1VRPaMLDGFFRDQoAJw0TIeuRNZ1WhYbrTJQ/3Fzsfb1DLssykbRUYqd1RX07TZ7Nb4A==
Received: from smtpclient.apple (unknown [17.156.208.39])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-4 (Postfix) with ESMTPSA id 179E418000EC
	for <git@vger.kernel.org>; Sun, 16 Aug 2026 09:12:05 +0000 (UTC)
From: kapicharly@icloud.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Me commit message itself should describe your changes.
Message-Id: <C1A89095-0F09-4BE1-9DE9-F3D8F96CBF5B@icloud.com>
Date: Sun, 16 Aug 2026 03:11:53 -0600
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.10)
X-Proofpoint-ORIG-GUID: EARlvSHtL6LUP7EU_9UUiTJ5EHhzfmty
X-Authority-Info-Out: v=2.4 cv=LZUxKzfi c=1 sm=1 tr=0 ts=6a817ee6
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=x7bEGLp0ZPQA:10 a=iRWSVGipjf4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WqxMrlxHOXV8-QsRgRwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2OCBTYWx0ZWRfX63qwOb0bbSeT
 cwgvE66HbybCcpACY3vIHa4SbjaKR2D79eNNlsby86zg+2QuZwtelPWJbHVizjteGlDPLUCge/B
 UWCWGoBeLHcEoSN9R9pIEDcwMMoJX8u+IlA7s30f2NVHeJX/BS975537MUMxqyK4zJeLHYdcQRI
 ZuhE/MSA77ejEcL1P/1FheydT21TI45V4Fe0pCnRzzD1rDazi9omsSrWdNxopcqekIKTCFSvOZO
 3soymoAc2GSAa70aJn8D7A0G1Yilzp8tCIdLpjgOE5FgCh1/im4Tl/RALSBrXsx5Aebi+neKGZ3
 lKWXoTTjVVrMs11g6ZBOfW9W45FeNCzu9JRwhevgbblXLhvWMAslaj/qaGDr8k=
X-Proofpoint-GUID: EARlvSHtL6LUP7EU_9UUiTJ5EHhzfmty
X-JNJ: AAAAAAABXc7hC9b025/nIcbYRWLRwjw1bJSVz36ZPz9bLm66NOTtWY59dgQ1dc46QUeSToRl6Grubp2viXa2E1gETLTvc5iAuIjMfVY/MD9XVPYsJoMUrIJ3tc9AXNM64KsC9CAon3bxfbg1HgE2oMfeNbXI++anoFFm1+u3EwVK8AZ3k6ypkjSqa+lZu257ZjmkV0cDfgBLb5tK7q+aWImYrksBYQd5sWSyyVHQXlh/cYet/bZ1CtFOeVvOBKTC0sozJbjeNhIunvss+HIt2WdmOX/VnyNVoa24T8SHIPbnXMI85b6ue9wSiFPOdumCHJqqaZAWZ8CnkZmKWrJqeUPbpMVM5UDwC/nBtk2axPOZkA29iIVf8nbZiSaf2pTmkhqlo2zew3hV3RfKBGkdQwFrOkHxWC4dZ84WpuwK2jsiBUufvhxGkT7NPn2Ec72D2vUF8B7G+kVhGYGw7ZuKv9bUbO8c+lvf41YI38BLRSm6TmUay6OL3repDEFnXzcvxbpRF2emFPYyZy1VYuI+7EDj9PVrme23rUTq//03PctthcoZN0DxQkU0qs7GjtXQdTR38I/A6QOGP0/WHFXrgHnExyU5LG1wXzSbTBkQ/G6WV8glMZqtDsO05lhBAb4Q1jIkhe8dtHejfoVs5MqtGr+AcJrbtIBcFFYlGrCRWZeRCKbj0r9JZ55gH2sbk57Jj/7iTJG21mbuExxo9caSBeY58i64BYqymgWnj+h1S6OoxpSwqO2+c/9re/FzgHmqUh6elglYPwJMcbqjlRuLYmswOvaZ0WtsnyM+MW6Wopqa52guA26kH9xgHu2FwDaLRyHj97RQNxbnMLOoiUTXJlxGgIJA9z6t6XwzZys7IZfVeHCw04EwaKkwA7gRJJgycnmVFCbjnOmZVPEB0X0ojmwaQ9XK/IRTmoPag4YzYYYPim6HaBzDpO/h1wTKNGfe6JiE5W8tDQX3BQOE9pd6t8m/I0hb1eB
 PJWm2uayZdECJnN+CwG17/g8pZ0xcNRQCUZLxlwWsKMERWREO7LkeypvTKdtkfUcVf5Enl//uqGeiniDrJMEc10x4uJSYjfITfPtUp8scnABO9oiChFBxqOWPjWMNlzuNEYAbB8ljCAXjFFh1SkehhvCjsVY8EFIQY76uV53feuaqVCA1PGC7oKf7Cf7FxHh5ggnvHMnnW3L5wDl8c/Eewbpz6FdbhFQ8E1DkUIdJG0fWtaG4LCDq44UThyD9+KqKeAgb7vUCQIt0fGdVHx+GZf2fI4NwmgjT+ikZcd0=

NOTE: The configuration options in `bitmapPseudoMerge.*` are considered
EXPERIMENTAL and may be subject to change or be removed entirely in the
future. For more information about the pseudo-merge bitmap feature, see
the "Pseudo-merge bitmaps" section of linkgit:gitpacking[7].

bitmapPseudoMerge.<name>.pattern::
	Regular expression used to match reference names. Commits
	pointed to by references matching this pattern (and meeting
	the below criteria, like `bitmapPseudoMerge.<name>.sampleRate`
	and `bitmapPseudoMerge.<name>.threshold`) will be considered
	for inclusion in a pseudo-merge bitmap.
+
Commits are grouped into pseudo-merge groups based on whether or not
any reference(s) that point at a given commit match the pattern, which
is an extended regular expression.
+
Within a pseudo-merge group, commits may be further grouped into
sub-groups based on the capture groups in the pattern. These
sub-groupings are formed from the regular expressions by concatenating
any capture groups from the regular expression, with a '-' dash in
between.
+
For example, if the pattern is `refs/tags/`, then all tags (provided
they meet the below criteria) will be considered candidates for the
same pseudo-merge group. However, if the pattern is instead
`refs/remotes/([0-9])+/tags/`, then tags from different remotes will
be grouped into separate pseudo-merge groups, based on the remote
number.

bitmapPseudoMerge.<name>.decay::
	Determines the rate at which consecutive pseudo-merge bitmap
	groups decrease in size. Must be non-negative. This parameter
	can be thought of as `k` in the function `f(n) = C * n^-k`,
	where `f(n)` is the size of the `n`th group.
+
Setting the decay rate equal to `0` will cause all groups to be the
same size. Setting the decay rate equal to `1` will cause the `n`th
group to be `1/n` the size of the initial group.  Higher values of the
decay rate cause consecutive groups to shrink at an increasing rate.
The default is `1`.
+
If all groups are the same size, it is possible that groups containing
newer commits will be able to be used less often than earlier groups,
since it is more likely that the references pointing at newer commits
will be updated more often than a reference pointing at an old commit.

bitmapPseudoMerge.<name>.sampleRate::
	Determines the proportion of non-bitmapped commits (among
	reference tips) which are selected for inclusion in an
	unstable pseudo-merge bitmap. Must be greater than `0` and
	less than or equal to `1`. The default is `1`.

bitmapPseudoMerge.<name>.threshold::
	Determines the minimum age of non-bitmapped commits (among
	reference tips, as above) which are candidates for inclusion
	in an unstable pseudo-merge bitmap. The default is
	`1.week.ago`.

bitmapPseudoMerge.<name>.maxMerges::
	Determines the maximum number of pseudo-merge commits among
	which commits may be distributed.
+
For pseudo-merge groups whose pattern does not contain any capture
groups, this setting is applied for all commits matching the regular
expression. For patterns that have one or more capture groups, this
setting is applied for each distinct capture group.
+
For example, if your capture group is `refs/tags/`, then this setting
will distribute all tags into a maximum of `maxMerges` pseudo-merge
commits. However, if your capture group is, say,
`refs/remotes/([0-9]+)/tags/`, then this setting will be applied to
each remote's set of tags individually.
+
Must be non-negative. The default value is 64.

bitmapPseudoMerge.<name>.stableThreshold::
	Determines the minimum age of commits (among reference tips,
	as above, however stable commits are still considered
	candidates even when they have been covered by a bitmap) which
	are candidates for a stable a pseudo-merge bitmap. The default
	is `1.month.ago`.
+
Setting this threshold to a smaller value (e.g., 1.week.ago) will cause
more stable groups to be generated (which impose a one-time generation
cost) but those groups will likely become stale over time. Using a
larger value incurs the opposite penalty (fewer stable groups which are
more useful).

bitmapPseudoMerge.<name>.stableSize::
	Determines the size (in number of commits) of a stable
	psuedo-merge bitmap. The default is `512`.
