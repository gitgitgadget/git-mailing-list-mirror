From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-new-workdir: add windows compatibility
Date: Fri, 29 May 2015 12:52:13 +0200
Organization: gmx
Message-ID: <0ff0ae5b80b4bf5a82444343ac99590b@www.dscho.org>
References: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com>
 <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com>
 <cbfbf842705637b52cde9c6b61f89a75@www.dscho.org>
 <1432642835.17513.22.camel@mad-scientist.net>
 <1fb8315dfaffb91ec4925bcc458e12a2@www.dscho.org>
 <55683700.3010201@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: paul@mad-scientist.net, Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Smith <dansmith65@gmail.com>, Jeff King <peff@peff.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Richard Hartmann <richih@net.in.tum.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 29 12:52:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyHtu-0003Ll-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 12:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638AbbE2Kw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 06:52:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:59569 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839AbbE2KwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 06:52:25 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lg5kl-1ZRuYG3jbf-00pdB2; Fri, 29 May 2015 12:52:15
 +0200
In-Reply-To: <55683700.3010201@drmicha.warpmail.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:sXCzQpUA1HJsLJ6K9fhAdJKEDTd7sFHf7moOfN0PV6NwdYVFlY8
 NN77SPw80TcR2NDcXU0jvU0Uj2iXLGQ5o0CHvXZ0yEAesOvxdYGkMLWRQhbZ/jU30bT1U8n
 ad09QPrY36rGY7Rlb4VnkDFFV2UGGquMaVTBAlq2Dcvsdzll5SK62c1/wVnaI/57jvoRXSF
 I3l9vEspVrdBQh1LBYZ+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nXRs7AHppAg=:g5zwgsR4StNsNNmWbHdpKQ
 BOWPMZCX5jbvkfwNlK+YqycuHm8gbnMaB2002AT0e6cMy18nKRsx00040izcRrwyPXjYxhcMX
 RLtJvppo8KMZlisv3bDMhlvrFkq67vJShVzpGeUfCCoU3ZG3Xxl1cAvVow/uFrSFINAtj3yaw
 Rdw2NMVh9Gf9HixYYskF13n+2RAgApz2c0fcK/l9ydp9Yc04GKIq97ARYQdY8X8iKWOjVBOZs
 tR5gSTGnVTOjT+wochrb6wiBb51mZEKnzXzCBq6pabP9ae/3XY6YSNvL8AKyZr09VBj7N4MtI
 FfYKyvb0flJxZhDwYbBX/c5Lsl7KzOQr3lS8uibV7A895OFHWG0ZvJhhCeGB16IRT2hbapGTR
 hE6IFCWK52LSGsbn5wMeTfrqo+YQs4XcE+K5XEHoPOGEvQwEI4vZBS8YPY6xzYZSzAk1kutXQ
 WRXfEKHxXLyXThkaLSEr28jC3uNC/2jK3bmzKb12kdoG8yYMnTLWb1hYYaYjWY4Nx1jEjK67X
 G6O8K4hA4thMd1v71B/2y6ShzusZ4nGUq3fy63E5SL7CccOScmCjEOfe70/rE4nFgzRKYzsac
 IkQ7Ois41t15p33O96/nVBhr0WtX1aN93JR1sI2hFfPSWsbFw6jcDlEEdicipi9SBX276SJdx
 vEDKD7dnQ7vkCzoQIj64ovKCEaJ+HXWXCLiwyBIqMqOSIwWIXu1p2kKS6L16XYN6Y8yA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270224>

Hi Michael,

On 2015-05-29 11:53, Michael J Gruber wrote:
> Johannes Schindelin venit, vidit, dixit 26.05.2015 14:35:
>> For what it is worth, I tried my hand a couple of years ago at the project to move git-new-workdir to use the `.git` *file* and alternates mechanisms, but that does not work because you really need a separate `.git/HEAD`.
> 
> Isn't that basically the approach that "git checkout --to" is taking? Is
> that one "Windows proof"? I've lost track of its status, though.

I haven't tried `git checkout --to` on Windows yet, and sadly I won't be able to do that for another week...

Ciao,
Dscho
