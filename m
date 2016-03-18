From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Fri, 18 Mar 2016 16:49:03 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603181647160.4690@virtualbox>
References: <56E9F5B3.6030903@fb.com> <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal> <xmqq37rp35k1.fsf@gitster.mtv.corp.google.com> <CACsJy8A2D8CqeWZ6CFdTVXzXiWdonBE=3tWFPpe7-ZmDtNGYNw@mail.gmail.com> <alpine.DEB.2.20.1603171402330.4690@virtualbox>
 <CACsJy8DH297aV2pYL7xGNZ5X24rR5PxvrpJQ+15YxpDNvqgS5Q@mail.gmail.com> <alpine.DEB.2.20.1603171444210.4690@virtualbox> <CACsJy8D1e5zd-b6CsszHGcNjMPedyZSrZpqdWeCUGdMD5UP7qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Durham Goode <durham@fb.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 16:50:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agwfQ-0004XS-SW
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 16:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541AbcCRPuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 11:50:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:56227 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757514AbcCRPuL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 11:50:11 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LzLJR-1ZmDBI0moL-014Vkj; Fri, 18 Mar 2016 16:49:05
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8D1e5zd-b6CsszHGcNjMPedyZSrZpqdWeCUGdMD5UP7qQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:M4gpctWpz5BA326ZwMC0Ox3cYyq5CcxAW6ycKwNvY/EY7n1vSNV
 JtvMgefa5KD6AKmqkafhgen5tA0TVyKMQ4kxg8Z8AModZdpHQGNkESJ5rE8JsR6nc4P2+Q3
 3E5sGZQaQVCQ0kpDt2qVBDk46oTm57sJayWhNY1YYPOB7w1+r+nH7o7BHsidjrw/Z9obAF8
 4AudxScqLjj5xV3PnCbMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wjOTCYjYlqs=:FnZ0RVRNvp5+dw5/hHGKlm
 pUkngPBcX4A6c1laxx4J8L+svipC4gkj2zi6NhmEaowGBtt2OkWBzOe0hPk1GMre0yh8IQrZ4
 uce9lk24+MTZsPKNPon7JULx7Z21mXz5ICJWdvOVgvdMwzhJwn8EwU8/hvYXvqURjeEuD1FiC
 X+8NflsGHp4Hd1rXaV8ltjtoXFXmUlPDlTdu56DQWjv6w4X0aYXOkyvfCWkJ0Q21QKBQfbqhv
 msmbtlXTVCFGTu8mCvNHPh6ELL73b+nz1Vz5SmOVsoCUEjIUAVmyXocDp/1e+Akl9d1SQIeSE
 3vJApQSQQy+oGb/mDdfU+9tETs2WHGEXE34DgdwjbyXfAFSnyGVH44aNglOFQSSJcKzFiuumt
 RnfMBKhwSih2WTrw9t+9O+A6UXNFkc8CtmASaNPFzrUFU7H0VYKsC1hhdg+Q2rk1uN6ASzWmD
 kxVaqWtzCm8LXkozqlj6boC5YQkyMHg+9eAzMwk36HduFHSSSRlGjQYWGKXn0PpFoDx/tvrBz
 LDiaFSmYDzU/61eo+B6kmyOLKomJbUaEBLi2eFoFhbwMeXBNgoxrKX3ZO+oEG3a4n3M5GO29p
 4iUXsudYlwonA/y107mUxu3G7+u6SUx5C5zSDxjkNE+3sbQygjtT+FMBxuyvovH/tklC8KINK
 jP2eO5vMNCx1wxqA0Qc1aRGw+jMYImQKDxmRRjaj8aXxsz9hYQIYl86JpjQLDlR8xRbseWXyV
 LTdSdDNkEP4Ndtddv5kxpn1O6Cv++8xnNM2qryRPpPxHcLK1dhjFi/FOCQi5Hg/bZZszwLMt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289227>

Hi Duy,

On Thu, 17 Mar 2016, Duy Nguyen wrote:

> On Thu, Mar 17, 2016 at 8:46 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Unfortunately, this does not help me at all. In the use case I am trying
> > to get to work fast, we have tons and tons of directories and need *one*
> > file in pretty much *all* of those directories, and exclude most of the
> > other files.
> >
> > To make matters even worse, the list of excluded (or included) files is
> > constantly changing.
> 
> OK very weird use case to me :) There's something you might try. [1]
> can help trimming unrelated patterns, fewer patterns to match for a
> dir, faster matching.

Sadly, [1] (exclude: filter out patterns not applicable to the current
directory) would not help at all, because the regular use case really
would use the top-level directory as current one.

So I really need to speed up the sparse machinery from O(m*n) (where m is
the number of entries in the sparse-checkout file and n is the number of
files in the index).

Ciao,
Dscho
