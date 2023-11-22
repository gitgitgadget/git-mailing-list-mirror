Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="iwgvkG3B"
X-Greylist: delayed 413 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 16:35:58 PST
Received: from qs51p00im-qukt01080501.me.com (qs51p00im-qukt01080501.me.com [17.57.155.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8E610E
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 16:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1700612944; bh=sQbRyWGMYXCgfsjLnjz8IXZPAxjxidlq9M7JJbC0HIo=;
	h=From:Content-Type:Mime-Version:Date:Subject:Message-Id:To;
	b=iwgvkG3BAW1DWsivG4AN/M6mwDVVDt/Sm3dqRdXdkEgOZo81K1HYBRVVAybRW1kZo
	 ejAV+giDTuJJydk3nj+fVkoszVfxcurjuUgg3lYbWEFfy3pGE/dEiJ3XIc3C4IHxt4
	 ZAIy/DmRDVMnCJe1kR/DkwSfL8REBz4Svwso0G8eteeVANwCQjzes3353QAHny9JNu
	 KL3g1wtLfBS3PxJr/e1FIGxE6EXAnZcV2/5r555eAAwtp1Mr809wfk7WVoB9oycAer
	 fx6+uW3VGUxkySlxEyaaAXAWRwktN13A1OMLIdOwuIEgauEUGtFelffAOgBDhd+CFg
	 Lu/8qOTiYNnzA==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080501.me.com (Postfix) with ESMTPSA id A8EB819803DB;
	Wed, 22 Nov 2023 00:29:02 +0000 (UTC)
From: Craig H Maynard <chmaynard@me.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Date: Tue, 21 Nov 2023 19:28:36 -0500
Subject: Orphan branch not well-defined?
Message-Id: <FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com>
To: Git Community <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Proofpoint-ORIG-GUID: obKtxcOtGXu_q8yaMbyGh_E1FaRpadSD
X-Proofpoint-GUID: obKtxcOtGXu_q8yaMbyGh_E1FaRpadSD
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 adultscore=0 mlxscore=0
 mlxlogscore=863 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2311220000

Team,

Recently I tried creating an orphan branch in an existing repo using =
git-checkout and git-switch.=20

Both commands have an --orphan option.

The results were different:

git checkout --orphan <newbranch> retained the entire working tree, =
including subdirectories and their contents.

git switch --orphan <newbranch> retained subdirectories but NOT their =
content.

Leaving aside the question of whether or not this is a bug, there =
doesn't appear to be any formal definition of the term "orphan branch" =
in the git documentation. Am I missing something?

Thanks,
Craig


