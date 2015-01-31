From: Andreas Gruenbacher <agruen@gnu.org>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Sat, 31 Jan 2015 21:27:37 +0000 (UTC)
Message-ID: <majhc9$ant$1@ger.gmane.org>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<CA+5PVA5RdtLyRiYerG=u--bRZQ87qU0EGf7kGPMiQs9_KB3hRw@mail.gmail.com>
	<CA+55aFwa1-pudNus+r=5EghpGkm33h--GZNND5UHt=ZKvP15Xw@mail.gmail.com>
	<CAPc5daVu=hjjYwDoCwco=cdg16kib80ZBbArh3z8R+j2vq6C6g@mail.gmail.com>
	<CA+55aFxdssyi_CrhB_yf8yXrG2PnuEHxf-=X6NnoVFxJnG0Jww@mail.gmail.com>
	<ma8btn$t01$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: linux-kernel@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Jan 31 22:27:58 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YHfa9-0002ms-Vh
	for glk-linux-kernel-3@plane.gmane.org; Sat, 31 Jan 2015 22:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbbAaV1t (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 31 Jan 2015 16:27:49 -0500
Received: from plane.gmane.org ([80.91.229.3]:54440 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbbAaV1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2015 16:27:47 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glk-linux-kernel-3@m.gmane.org>)
	id 1YHfZv-0002dV-JV
	for linux-kernel@vger.kernel.org; Sat, 31 Jan 2015 22:27:43 +0100
Received: from 80-110-112-196.cgn.dynamic.surfer.at ([80.110.112.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jan 2015 22:27:43 +0100
Received: from agruen by 80-110-112-196.cgn.dynamic.surfer.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jan 2015 22:27:43 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80-110-112-196.cgn.dynamic.surfer.at
User-Agent: Pan/0.139 (Sexual Chocolate; GIT bf56508
 git://git.gnome.org/pan2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263230>

On Tue, 27 Jan 2015 15:47:04 +0000, Andreas Gruenbacher wrote:
> On Mon, 26 Jan 2015 13:50:10 -0800, Linus Torvalds wrote:
>> I _think_ we allow arbitrary symlinks to be created, but then we should
>> be careful about actually _following_ them.
> 
> I would prefer to allow arbitrary symlinks even in GNU patch, but patch
> still must not be allowed to leave the working directory. The only way
> to achieve that I can think of is to implement path traversal in user
> space, which is not so easy to do correctly and efficiently.

This should be working in patch-2.7.4 now.

Andreas
