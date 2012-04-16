From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new
	git_complete helper
Date: Mon, 16 Apr 2012 15:59:52 -0500
Message-ID: <20120416205952.GJ12613@burratino>
References: <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
	<7vaa2by8nj.fsf@alter.siamese.dyndns.org>
	<20120416160729.GM5813@burratino>
	<CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
	<20120416200941.GD12613@burratino>
	<CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
	<20120416203320.GF12613@burratino>
	<CAMP44s0Q2A_oKJx27ct9W__KVQkQxzst3H7gq6sZDhrCLDQaag@mail.gmail.com>
	<20120416204641.GH12613@burratino>
	<CAMP44s23_Qx3R9TX4frM-JYNv7XT3eVbcZ_D45nEdh0rq-O8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	bash-completion-devel@lists.alioth.debian.org,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org Mon Apr 16 23:00:18 2012
Return-path: <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcsbc-bash-completion-devel@m.gmane.org
Received: from wagner.debian.org ([217.196.43.132])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>)
	id 1SJt1y-00081f-4P
	for gcsbc-bash-completion-devel@m.gmane.org; Mon, 16 Apr 2012 23:00:14 +0200
Received: from localhost ([::1] helo=wagner.debian.org)
	by wagner.debian.org with esmtp (Exim 4.72)
	(envelope-from <bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org>)
	id 1SJt1x-00086T-Li
	for gcsbc-bash-completion-devel@m.gmane.org; Mon, 16 Apr 2012 21:00:13 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by wagner.debian.org with esmtp (Exim 4.72)
	(envelope-from <jrnieder@gmail.com>) id 1SJt1u-0007kc-5y
	for bash-completion-devel@lists.alioth.debian.org;
	Mon, 16 Apr 2012 21:00:11 +0000
Received: by obceq6 with SMTP id eq6so1454314obc.6
	for <bash-completion-devel@lists.alioth.debian.org>;
	Mon, 16 Apr 2012 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=CVP42AQEpSse1BSMBqVzQbM2EsnrVQ6JF8IPFB5Rnf4=;
	b=S2+dVCjMpueEg2q6jrjyZb5+26kn2nu7UsXJzcyu3WfF+t/T4OuKq19iBgRmAXw9jV
	VTEgF7mpm+JAQLuKNYR5WGNezEBwyVolaXXis7NXadN8kte4ys02zC+VTtxJ9sCM38va
	yRBX5teFaGnr0S6J+3etJ3aSFA1Qjh/hn7m1OaP2Wf3lfn3Uo5rV9j5Fq/lcvmkzCZUh
	+6T0znjO/PhnILN+jdfxHT5Af8m2ZUs0wuZX92dlG7gWnYK/ACm6Wbdh+lFc/zRapqUX
	r+61ycXKk334Aqr+xsm9szVT6r0Vxt7CH5ur8LOKNOWGjhbQpXAGZwHKXFEpMmIxUW64
	HS3Q==
Received: by 10.182.119.74 with SMTP id ks10mr7336014obb.30.1334610003028;
	Mon, 16 Apr 2012 14:00:03 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
	by mx.google.com with ESMTPS id s8sm16604870oec.1.2012.04.16.14.00.00
	(version=SSLv3 cipher=OTHER); Mon, 16 Apr 2012 14:00:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s23_Qx3R9TX4frM-JYNv7XT3eVbcZ_D45nEdh0rq-O8kA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-policyd-weight: using cached result; rate: -8.4
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on wagner.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1
X-BeenThere: bash-completion-devel@lists.alioth.debian.org
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: Coordination of bash-completion's development
	<bash-completion-devel.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/cgi-bin/mailman/options/bash-completion-devel>,
	<mailto:bash-completion-devel-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/bash-completion-devel>
List-Post: <mailto:bash-completion-devel@lists.alioth.debian.org>
List-Help: <mailto:bash-completion-devel-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/cgi-bin/mailman/listinfo/bash-completion-devel>,
	<mailto:bash-completion-devel-request@lists.alioth.debian.org?subject=subscribe>
Sender: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org
Errors-To: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: bash-completion-devel-bounces+gcsbc-bash-completion-devel=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on wagner.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195694>

KGNjLWluZyB0aGUgYmFzaC1jb21wbGV0aW9uLWRldmVsIGxpc3QpCkZlbGlwZSBDb250cmVyYXMg
d3JvdGU6Cj4gT24gTW9uLCBBcHIgMTYsIDIwMTIgYXQgMTE6NDYgUE0sIEpvbmF0aGFuIE5pZWRl
ciA8anJuaWVkZXJAZ21haWwuY29tPiB3cm90ZToKPj4gRmVsaXBlIENvbnRyZXJhcyB3cm90ZToK
Cj4+PiBOb3csIGV2ZW4gaWYgeW91IHVzZSB0aGUgYmFzaCBjb21wbGV0aW9uIGxpYnJhcnksIGl0
IHN0aWxsIGRvZXMgZXhwb3J0Cj4+PiBmdW5jdGlvbnMgd2l0aG91dCBhIHByZWZpeAo+Pgo+PiBB
cmUgeW91IHN1cmU/IMKgImNvbXBsZXRlIiBpcyBhIGJhc2ggYnVpbHRpbiBhbmQgaGFzIG5vdGhp
bmcgdG8gZG8gd2l0aAo+PiB0aGUgYmFzaCBjb21wbGV0aW9uIGxpYnJhcnkgZXhjZXB0IHRoYXQg
dGhlIGxhdHRlciB1c2VzIGl0Lgo+Cj4gSSBhbHJlYWR5IHByb3ZpZGVkIGV4YW1wbGVzOgo+IGhh
dmUoKSwgcXVvdGUoKSwgZGVxdW90ZSgpLCBxdW90ZV9yZWFkbGluZSgpCgpBaCwgdGhhdCdzIHdo
YXQgeW91IG1lYW4uICBUaGFua3MgZm9yIHRoZSBwb2ludGVycywgYW5kIHNvcnJ5IHRvIGhhdmUK
bWlzdW5kZXJzdG9vZC4KClRoZXJlJ3MgYSBsaXR0bGUgb2RkaXR5IGhlcmUuICAiaGF2ZSIgaXMg
Y2xlYXJseSBhbiB1bndhbnRlZCBiYWNrd2FyZApjb21wYXRpYmlsaXR5IGZlYXR1cmU6CgoJIyBA
ZGVwcmVjYXRlZCBzaG91bGQgbm8gbG9uZ2VyIGJlIHVzZWQ7IGdlbmVyYWxseSBub3QgbmVlZGVk
IHdpdGggZHluYW1pY2FsbHkKCSMgICAgICAgICAgICAgbG9hZGVkIGNvbXBsZXRpb25zLCBhbmQg
X2hhdmUgaXMgc3VpdGFibGUgZm9yIHJ1bnRpbWUgdXNlLgoJaGF2ZSgpCglbLi4uXQoJdW5zZXQg
LWYgaGF2ZQoJdW5zZXQgaGF2ZQoKQnV0ICJxdW90ZSIsICJkZXF1b3RlIiwgYW5kICJxdW90ZV9y
ZWFkbGluZSIgZG8gbm90IGdldCB0aGUgc2FtZQp0cmVhdG1lbnQuICBQZXJoYXBzIHRoZXkgYXJl
IGZvciBiYWNrd2FyZCBjb21wYXRpYmlsaXR5LCB0b28sIGJ1dCBhcmUKc28gd2lkZWx5IHVzZWQg
dGhhdCB0aGVyZSBpcyBubyBob3BlIG9mIGV2ZXIgZ2V0dGluZyByaWQgb2YgdGhlbS4KCkhvcGVm
dWxseSB0aGlzIGluZm9ybWF0aW9uIGhlbHBzIGNsYXJpZnkgdG8gd2hhdCBleHRlbnQgdGhlIGxl
YWRpbmcKdW5kZXJzY29yZXMgaW4gZnVuY3Rpb25zIGV4cG9zZWQgYnkgY29tcGxldGlvbiBzY3Jp
cHRzIGFyZSBtZWFudCBvcgphcmUgbm90IG1lYW50IGFzIGEgY29udmVudGlvbi4KCkpvbmF0aGFu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpCYXNoLWNv
bXBsZXRpb24tZGV2ZWwgbWFpbGluZyBsaXN0CkJhc2gtY29tcGxldGlvbi1kZXZlbEBsaXN0cy5h
bGlvdGguZGViaWFuLm9yZwpodHRwOi8vbGlzdHMuYWxpb3RoLmRlYmlhbi5vcmcvY2dpLWJpbi9t
YWlsbWFuL2xpc3RpbmZvL2Jhc2gtY29tcGxldGlvbi1kZXZlbA==
