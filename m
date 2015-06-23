From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jun 2015, #05; Mon, 22)
Date: Tue, 23 Jun 2015 19:24:39 +0200
Organization: gmx
Message-ID: <3fe144b0808827da3efbfcc44ad43524@www.dscho.org>
References: <xmqqzj3re4u5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:24:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7RwI-0004uT-FR
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 19:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbbFWRYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 13:24:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:59566 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754661AbbFWRYp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 13:24:45 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MJjOu-1Z8Xrp1DzI-001C48; Tue, 23 Jun 2015 19:24:41
 +0200
In-Reply-To: <xmqqzj3re4u5.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:H0JJus2aGVNeYO5w+BLXUsMPEtL8hDud95vGvBAdvsmKTzhO7BB
 Yz834KXiFaKae4eBhNWPMXsuETDV2uqnqhjcrBydMPy64l1ejLxC66SCsIa4ggca6vtz9Y1
 LdByeN8n7vhspGzGZJgN+lW6As5FA7AhFXvLUyfzpuFgrRgQYqGsLYvVNdaNBqZzC8FDCTD
 QYH1uZVHwjdD56sIo9urg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RgMAFBr0y+I=:fs3wXfq+9eXA2QNrL4mTz+
 8fxtTGttuuJz/+9ryB9ozCeKW+JrktG41PIQZV1wMZ7H3wIWyS0cvIaGfhoj9fWNFkE6jidDC
 wwMFALBdrURoF/M/fB6KNen5nCow8xQAEELJyH6GcudQbQoN8VYYL3lXkMOR/qTs7VzfAfHjQ
 jxfyHhZ78MCY8cQ99thQKopWxSkhL9fYqu/YFB7LjAYjhfjSlgEMuG0MjLwO2WjYBafTWqTmZ
 j2oTlSgwyL5Fxl4SUpet/IOPPloCbsXOx+E3nTuddWSESuC3w+C04ccG3E/4cyMep1AEqoETG
 bKUulZOTXJKcj0POeaKx/UzbOnceAJB+DEPfmyt+145vLmDpKt9HDG/5qp43V2UAp5jR4E5Ou
 04DWY87nW6FFi3a4lislxjCh/4OVLkcKnv8BE4VDGk7DrCa8qeLi5SnnIDIge8Imju3QHnbib
 fTbG0/NSOw8Z6U7YeyISW+SwRPbjTapHy81lvzJ7YguL8269R+Zty/X1S9xOzJfuKtQ0JNPzA
 2GybIK6nogOSqdQDAAJ9Dilh1IZ+/576wA1SzqBL0hcpOs8I/llDyVBvRrtZSheohEvV0o5Om
 GZiE/yXZBf8J/Wubu1GJG73YJwBKg7SA5KUXwPs7ZIm9flw6/t1793rCoXjbCTyji12r1AIFB
 js9weCdJBvv4js+BiVl/0Id2SFRIghTF56IZiZ43d0RYyWOmSlFj6IXrGfL8Urr5ITJ0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272462>

Hi Junio,

On 2015-06-23 00:49, Junio C Hamano wrote:

> * js/rebase-i-clean-up-upon-continue-to-skip (2015-06-18) 3 commits
>  - rebase -i: do not leave a CHERRY_PICK_HEAD file behind
>  - SQUASH: test_must_fail is a shell function
>  - t3404: demonstrate CHERRY_PICK_HEAD bug
> 
>  Abandoning an already applied change in "git rebase -i" with
>  "--continue" left CHERRY_PICK_HEAD and confused later steps.
> 
>  Expecting a reroll.
>  ($gmane/271856)

Actually, there had been two re-rolls, and v3 seemed to be okay: $gmane/272037. It also looks as if 726a35ebd^..726a35ebd^2 is identical with v3... Anything you want me to change in addition?

Also:

> * js/fsck-opt (2015-06-22) 19 commits
>  - fsck: support ignoring objects in `git fsck` via fsck.skiplist
>  - fsck: git receive-pack: support excluding objects from fsck'ing
>  - fsck: introduce `git fsck --connectivity-only`
>  - fsck: support demoting errors to warnings
>  - fsck: document the new receive.fsck.<msg-id> options
>  - fsck: allow upgrading fsck warnings to errors
>  - fsck: optionally ignore specific fsck issues completely
>  - fsck: disallow demoting grave fsck errors to warnings
>  - fsck: add a simple test for receive.fsck.<msg-id>
>  - fsck: make fsck_tag() warn-friendly
>  - fsck: handle multiple authors in commits specially
>  - fsck: make fsck_commit() warn-friendly
>  - fsck: make fsck_ident() warn-friendly
>  - fsck: report the ID of the error/warning
>  - fsck (receive-pack): allow demoting errors to warnings
>  - fsck: offer a function to demote fsck errors to warnings
>  - fsck: provide a function to parse fsck message IDs
>  - fsck: introduce identifiers for fsck messages
>  - fsck: introduce fsck options
> 
>  Rerolled (at v7) and seems more or less ready for 'next'.

I see that you used `downcased` instead of my `lowercased`, which makes more sense, but the style of the multi-line `for` loop as per `pu` is still as *I* wrote it... I also saw that you downcased the first letter after `fsck:` in the commit messages, and touched up the message of the "report the ID of the error/warning" commit. Do you want to touch up the `for` loop style in "offer a function to demote fsck errors to warnings" or shall I send a v8 (it is ready to go: https://github.com/dscho/git/compare/next...fsck-api)?

Ciao,
Dscho
