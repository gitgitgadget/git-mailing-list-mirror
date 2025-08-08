Received: from outbound.pv.icloud.com (p-west1-cluster6-host11-snip4-9.eps.apple.com [57.103.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D52698BF
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643528; cv=none; b=E8nsOZHO3yPGxRQ4dN6hJPxBQFpUstdOUmAmO7NJdsNrQ78GVlmkJwDKmoG6uZMkypidDJ6Lsh/sZnYl4TPMDxI+XxGHxq/3lV2K3vUFqY/flsG3kVDDMuvNP8//fARTXbssWb11chiB1vjCqfWVtOc4UetEPh2e8XyipZOMa+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643528; c=relaxed/simple;
	bh=73znUd8jesLGR1173I2rNInEW11My2yC5ubK/MJe1Cg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W4hgO9/M6MsxM9Szu+wWXnd/gH0lmpPwiOa7KuOs+o/kbUpmyw7szsz+Cl5no6f/kj9/vHh0Dhk7wO/M+wDt+t9b50JLUFdzmHaC5Cjo5W+lIcgDyQksk60m02qDiMBtnShNSCzi+uNhtEKRIJp0lULNVE5FijV3h0jK5LKL81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=i3sxTQCH; arc=none smtp.client-ip=57.103.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="i3sxTQCH"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPS id F00B518001A2;
	Fri,  8 Aug 2025 08:58:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=coNIxewQhg6ym4KQAQxFrz5J27AIrTUzNforHwVVMrE=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=i3sxTQCHRbWkJSItcBb8D+U/2xGYo2PIxRe6Gok5P2u/gULb3vOG2ekFsJBHzDxwuoaTn3UHUdDYZZFGIWmo2a5ZdJcol3sJh0aqmgWk4dzUushyfX7Srp4BVsGjQrl/Dd1JOLyqX24u2+nLY6R13BevlfwwZIUWZZikkSW6l+zqv40MtVNIlhcflVzfl9iRMPdKqbpsSma8QS0K1qb6rWqmoIdvpSRjug+p60+cTi7YyQtG6emC+Kxzxi7MvZalID1JvrJsN8ToZxW9wEACcsfhyzjKZrsc5PSVlETgfFVALptgP7XNRSV8Zz5lIJDI3ARV9EhHwrlcYWBuAbtEJw==
Received: from smtpclient.apple (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-20-percent-1 (Postfix) with ESMTPSA id C29DA180056A;
	Fri,  8 Aug 2025 08:58:41 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: Discussion: Future-Proofing Git for Massive AI Parallelism
From: tanish desai <tanishdesai37@icloud.com>
In-Reply-To: <DB7PR02MB4265771098F7314E47D9F2C0B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Date: Fri, 8 Aug 2025 14:28:23 +0530
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Tanish Desai #TD <tanishdesai37@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C289832-28F7-4173-8C65-A95EEAB333B6@icloud.com>
References: <VI1PR02MB4271E311313F60FB07359BB0B352A@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <32989B0A-2DB0-4787-8A08-BDED46258C7D@icloud.com>
 <DB7PR02MB4265771098F7314E47D9F2C0B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
To: Skybuck Flying <skybuck2000@hotmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA3MyBTYWx0ZWRfX6pByXfaT855H
 /lzRNrq68bTsapgpnY835plAs2eMTsDdCdkvmsO5ZVmDvNRcSWqWXjNuhHK5rA8DjcoWClsI0WF
 z1WvomNWremTNit5KQrOU/AMorB1oquyaKmbFIkL8V21hWq91NUL65kkB/LAbYByPs4r7EmSCAD
 l25A5JJ7bSbejBSfXQ9t+P75crEVaD/YF6owEZI2JhYQIB8KroVJxljle7RLOzvOBDQsGyz+/09
 43uqxMdpyTFoCu1Wv8Daf/ung2ve1SVuNlYoDAOjSHOmid7SLLUGZeUJtB7QtzQg317SVK1ww=
X-Proofpoint-ORIG-GUID: KqU3nZpCVom8fDzNvGT6zCF133Hbcph7
X-Proofpoint-GUID: KqU3nZpCVom8fDzNvGT6zCF133Hbcph7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1011 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080073


FIrst of all sorry for such a late reply from last 1 week I was =
travelling and I was not having access to email. ; )=20
> On 2 Aug 2025, at 2:33=E2=80=AFAM, Skybuck Flying =
<skybuck2000@hotmail.com> wrote:
>=20
> Thank you for your reply, it was fun reading !
>=20
> My current plan to experiment with git, ai agents and parallelism is =
as follows:
>=20
> =E2=80=82=E2=80=82=E2=80=821. Windows 11 as base operating system.
why not linux distro(alpine or maybe ubuntu)?
> =E2=80=82=E2=80=82=E2=80=822. PostGreSQL database server (for windows =
11) as back-end/support for:
> =E2=80=82=E2=80=82=E2=80=823. Gitea git server (for windows 11) for =
local git server/github-like support.
Why not git itself?
> =E2=80=82=E2=80=82=E2=80=824. Git client (for windows 11)
> =E2=80=82=E2=80=82=E2=80=825. Gemini cli (for windows 11/npm/etc)
> =E2=80=82=E2=80=82=E2=80=826. Gemini 2.5 pro/cloud access from google.
> =E2=80=82=E2=80=82=E2=80=827. (Perhaps some) custom developed =
communication layer/channel utilizing PostGreSQL database server to =
store/retrieve messages for AI. (Still in testing phase).
>=20
> (Optional 8. I also considered MailEnable mail server (for windows =
11), but I suspect using e-mail for AI-to-AI might be too slow because =
of e-mail anti-spam and      throttling issues/rate limitters, and =
complexity overhead and processing overhead of e-mail protocols in =
general like smtp for sending, pop3/imap for receiving.)
>=20
> (Future maybe 9. Ollama/local AI models, but not powerful-enough =
hardware for now to run either large AI models or AI models with large =
context windows).
> (Also tested 10. LM Studio to serve local AI models and mimic/fake =
OpenAI API for cli tools which use OpenAI API).
>=20
> I'd love to hear more from you, which software solutions you have =
tried so far, or what you are experimenting with it or considering for =
future use.
>=20

I experimented with using a local Git server setup and Docker pods =
(based on Ubuntu 22.04) on a GCP instance. The GCP host acts as the main =
Git server, and each Docker pod connects to it via SSH. This setup =
proved to be very fast.

Each pod contains a clone of a common Git repository that includes an =
instruction file. Every pod has a unique hostname, and the instruction =
file includes commands specific to that hostname. A script reads the =
relevant instructions for each host, formats them, and sends them to the =
gemini-cli (for now).

The CLI applies the changes, and then another script handles the Git =
workflow. I've experimented with multiple approaches for this step:
1. Direct commit and merge: After applying changes, the script commits =
them and tries to merge directly into the master branch. If any merge =
conflict occurs, it=E2=80=99s sent back to the CLI, which can choose to =
accept the new changes, reject them, or perform a manual merge.

2. Patch-based queue: Instead of direct merging, changes are converted =
into patch files and added to a queue (using a Docker-mounted volume on =
the host filesystem, which also solves the email issue). These patches =
are then applied in order using git am -3. This reduces conflicts but =
doesn't scale well.

3. File-level locking: A lock is used to prevent multiple agents from =
modifying the same file at the same time. For example, if one agent is =
working on file1, it's locked until that agent finishes. This approach =
significantly reduces merge conflicts. However, it's slow=E2=80=94while =
it works reasonably well for 2=E2=80=934 agents, with 10=E2=80=9320 =
agents, the performance degrades to the level of a 2=E2=80=934 agent =
setup but with many more conflicts.

> Bye for now,
>   Skybuck Flying.
>=20
>=20
>=20
>=20
>=20
