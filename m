Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442E747A
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ojBQ1LWT"
Received: from st43p00im-ztfb10063301.me.com (st43p00im-ztfb10063301.me.com [17.58.63.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4074A4
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1698045331;
	bh=Bow+9jBm3TpH3zaMcxNv5t26UtwHRU0Jddezk5ogQd4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ojBQ1LWTjvcGAa9ioADWUVPBxuzM7neTKTmD7FuzOvD6BZKisilt0wnO+Se5wTuzj
	 ECeRX/fXDvsFJ5dBvJqwqVrXveiDFP74oiLI8SEnQEQFKpVbZUe9YGNW0o+9FmLgVN
	 wT72Waa8zTAz7Nu7BRN0EsvIpXDkNONGd6WhxtvA7+m7i3XeubvtO3QPNEqcQCpwc2
	 nAADVUIN1918PADM+pThVRwZKCvdvuUtpx1RSuLhECl+9LL56B74af6eG/cSDBCeyf
	 G96aD+vKQ1g/YPG4P68//A7HFz3Wd3SrR/3EMrPDH+uqfBZ3K5TZPOcjeUO+9qvA7h
	 VBNVCe128Rj0Q==
Received: from [169.254.14.109] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10063301.me.com (Postfix) with ESMTPSA id 4DD5E700177;
	Mon, 23 Oct 2023 07:15:30 +0000 (UTC)
From: Sebastian Thiel <sebastian.thiel@icloud.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, Josh Triplett <josh@joshtriplett.org>,
 git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Date: Mon, 23 Oct 2023 09:15:28 +0200
X-Mailer: MailMate (1.14r5937)
Message-ID: <918D0772-CDEE-4892-828E-BD8A06C3F1F4@icloud.com>
In-Reply-To: <xmqqmswjsv8c.fsf@gitster.g>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g> <ZSouSI_zPusOefsv@localhost>
 <CABPp-BEg6vxiUpcJAG_=KB_sTrVgCF19JZh-+ZGCTPXdbo9ekg@mail.gmail.com>
 <B088FC28-BE30-424D-9CDD-7A53EDFC1710@icloud.com>
 <xmqqmswjsv8c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: d55azfhC3Y49G22PI5ei1JUwH9zu904o
X-Proofpoint-ORIG-GUID: d55azfhC3Y49G22PI5ei1JUwH9zu904o
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.573,18.0.957,17.11.170.22.0000000_definitions?=
 =?UTF-8?Q?=3D2023-05-18=5F15:2023-05-17=5F02,2023-05-18=5F15,2023-02-09?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 mlxlogscore=788 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2310230063

On 16 Oct 2023, at 8:02, Sebastian Thiel wrote:

> I don't know if this time will be different as I can only offer to implement
> the syntax adjustment, whatever that might be (possibly after validating
> the candidate against a corpus of repositories), along with the update
> to `git clean` so it leaves precious files alone by default and a new flag
> to also remove precious files.

I am happy to announce this feature can now be contributed in full by me once
you give it a go. This would mean that the entirety of `git` would become
aware of precious files over time.

To my mind, and probably out of ignorance, it seems that once the syntax is
decided on it's possible for the implementation to start. From there I could
use Elijah's analysis to know which parts of git to make aware of precious files
in addition to `git clean`.

I am definitely looking forward to hearing from you :).


