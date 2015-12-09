From: Stefan Beller <sbeller@google.com>
Subject: Re: GPG public keys
Date: Wed, 9 Dec 2015 14:24:17 -0800
Message-ID: <CAGZ79kYk0RkwNj2aX6iixGjceKVYTy24os_Xb_wY8BWDZwY+Fg@mail.gmail.com>
References: <9E65FDC7-B4F6-45DC-9B0E-F017B904C868@pixelrebel.com>
	<xmqqtwnsie6h.fsf@gitster.mtv.corp.google.com>
	<3860CB92-AD83-4372-AE7C-BBA8BF2D8F67@pixelrebel.com>
	<20151209220413.GA21751@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jamie Evans <jamie@pixelrebel.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 09 23:24:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6n9x-0005Jn-GT
	for gcvg-git-2@plane.gmane.org; Wed, 09 Dec 2015 23:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbbLIWYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 17:24:20 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37987 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbbLIWYS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2015 17:24:18 -0500
Received: by igbxm8 with SMTP id xm8so472640igb.1
        for <git@vger.kernel.org>; Wed, 09 Dec 2015 14:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XMifyp9VRBru5qaYMTbVCzXlTzmESXtT4AfTeP50Hf4=;
        b=gc96t5MzHEVP6xwzLGcBz6uvzRqFvL9g9bLnce8ELNPuY0qkFTJ/oFoda7IfoBJsTw
         4ZVL7u+qUABUgl39Obs4ZBLiH4vIKBiY9OhBoJKyc0z+ugWZzUEqltv/zJJ0J2cySxsE
         h4cKku3cSGWxTa/XzdjtL/15ur2Eaz+bOWHAi+ZsrzUXEDkc2/qpwzb9zmsS02WhfiRF
         6qe/CcWyC306aPsnqzWEp3tDzr/hoUqvvzsaQUOdH5E8DnOtXx28Oav1Rg0OOI0EH7pN
         McwP58wyRBG9g+MZvJMHVr0kBmZq8TxE205cNe94KCgN6FMgCl9TTWpxBoveWp6e7e+4
         gw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XMifyp9VRBru5qaYMTbVCzXlTzmESXtT4AfTeP50Hf4=;
        b=bAbqdMcQ+60A5l3wlqAmsI4BO4vtSwfdwQm/JpWTahKXt7Ph6GcykgnwleomD4omds
         Ju2J8bu/vyibyNk2AhCPFLil4JmSNdTUm4dpufEcV7+XProQT+BfzLbsybNGcMiv8pMM
         xWv5sGQU9RVoIBpmgQ0bItzgVfWfHHBsxu9uCSPcpAQgb2UrfQSb/ogp4r2RVX4aBwuk
         kIpCtr2xIWolucySfiuqJ/ZwWJ0zym1pq9XZnIHf+ZftBE1ugIIE2kD0jtSp6nJXFsTq
         QsF6q3ZyGSgVDJBnopd7KK3eydrtQv0PauF/zFUeEByY/bF8Er0j5GwFIhSt3edkXGsj
         gmDA==
X-Gm-Message-State: ALoCoQmCP7fGjjauZtVLZt2tEIcfPtjVOrLdrW7ODkbajiHz8Bzdt6ABRwQ7bhp1v5ELBJ1z3/0l9Raj/nQFsphJdMksAWtWRDJkdLKNFC4r/rYf6ENRqnc=
X-Received: by 10.50.78.231 with SMTP id e7mr30812899igx.93.1449699857476;
 Wed, 09 Dec 2015 14:24:17 -0800 (PST)
Received: by 10.107.19.26 with HTTP; Wed, 9 Dec 2015 14:24:17 -0800 (PST)
In-Reply-To: <20151209220413.GA21751@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282202>

On Wed, Dec 9, 2015 at 2:04 PM, Jeff King <peff@peff.net> wrote:
>
> Of course you can't just fetch the v1.7.1.4 tag _now_, because the same
> person impersonating the most recent tag could also be impersonating
> (and back-dating) the older tags. But you could fetch it now, store it
> somewhere trusted (e.g., on your laptop), and wait two weeks. If you
> find no public outcry over hacked git, then it is probably OK to assume
> that is the real key.
>

With all of us pointing out 96AFE6CB being the right hash, you may or may not
trust the list enough to also trust the key now.

But the mailing list server may be hacked and run a s/good-hash/bad-hash/g on
each email such that we cannot tell you via email what the right hash of Junios
key is.

That's why the web of trust is built using side channels, i.e. not
just the internet.
Usually people meet and check face-to-face if the other person is the
person they
claim to be and if their key checks out.
