From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 21 Jan 2013 17:20:56 +0100
Message-ID: <8738xuo6c7.fsf@pctrast.inf.ethz.ch>
References: <50D861EE.6020105@giref.ulaval.ca>
	<50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca>
	<50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca>
	<CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
	<50F8273E.5050803@giref.ulaval.ca>
	<871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
	<50F829A9.7090606@calculquebec.ca>
	<871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
	<50F98B53.9080109@giref.ulaval.ca>
	<CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
	<87a9s2o6ri.fsf@pctrast.inf.ethz.ch>
	<50FD696B.5000205@calculquebec.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>, <kusmabite@gmail.com>,
	Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Boisvert 
	<sebastien.boisvert@calculquebec.ca>
To: Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>
X-From: git-owner@vger.kernel.org Mon Jan 21 17:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxK7x-0000eu-0l
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 17:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755278Ab3AUQVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 11:21:00 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:19077 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753854Ab3AUQU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 11:20:59 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 21 Jan
 2013 17:20:56 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.208.154) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 21 Jan 2013 17:20:56 +0100
In-Reply-To: <50FD696B.5000205@calculquebec.ca> (Maxime Boissonneault's
	message of "Mon, 21 Jan 2013 11:14:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.208.154]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214127>

Maxime Boissonneault <maxime.boissonneault@calculquebec.ca> writes:

> Hi Thomas,
> Can you tell me what is the version of the lustre servers and the
> lustre clients ?

$ uname -a
Linux brutus4.ethz.ch 2.6.32-279.14.1.el6.x86_64 #1 SMP Tue Nov 6 23:43:09 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux
$ cat /proc/fs/lustre/version
lustre: 2.3.0
kernel: patchless_client
build:  2.3.0-RC6--PRISTINE-2.6.32-279.14.1.el6.x86_64

I have no idea what the servers are running, I only have client access.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
