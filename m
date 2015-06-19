From: Scott Schmit <i.grok@comcast.net>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Fri, 19 Jun 2015 19:57:48 -0400
Message-ID: <20150619235748.GA23394@odin.ulthar.us>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
 <xmqq1th77829.fsf@gitster.dls.corp.google.com>
 <95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
 <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 01:58:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z66AY-00005G-VO
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 01:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbbFSX5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 19:57:54 -0400
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:36019 "EHLO
	resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752194AbbFSX5w (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 19:57:52 -0400
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
	by resqmta-ch2-08v.sys.comcast.net with comcast
	id iPxi1q0072VvR6D01PxsQv; Fri, 19 Jun 2015 23:57:52 +0000
Received: from odin.ulthar.us ([IPv6:2001:470:8c86:0:225:64ff:fe8b:c2f2])
	by resomta-ch2-19v.sys.comcast.net with comcast
	id iPxp1q0052Ekl4801PxrWV; Fri, 19 Jun 2015 23:57:51 +0000
Received: from odin.ulthar.us (localhost [127.0.0.1])
	by odin.ulthar.us (8.14.8/8.14.5) with ESMTP id t5JNvmfg026807;
	Fri, 19 Jun 2015 19:57:48 -0400
Received: (from draco@localhost)
	by odin.ulthar.us (8.14.8/8.14.8/Submit) id t5JNvmYv026806;
	Fri, 19 Jun 2015 19:57:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1434758272;
	bh=AcfToeH8yXNTxrVE+teilNpWcJH7HCP2UyS6inR3Yhw=;
	h=Received:Received:Received:Received:Date:From:To:Subject:
	 Message-ID:MIME-Version:Content-Type;
	b=aU6fFlVJQtSC6QLTINLh51f7gWgKm6lIfFkvn3uhNBZ+TgT/kXDgxSDnxSzt/vz83
	 fWJVAhxNGD/7RSfd44GQSJ+5p7HghR7ZVo4jT7lfnk37DiXaL2qm7XWo9mCbLLTvRz
	 HYCbae4izC3dVw6ORlwrHAiSefWlc/ja/c66kcRW2ybWchdpo9FiEx6IadXKsYygnt
	 rGlThWwDk0lkRn+luEZWr8FIMIJ0ePDEijo1rbuTKOEFM6WKb787wWfwPvzbiCCU74
	 9sKDAd6oy6sYWA3GD2tdosktuOLEGYsM+XV4DYPw5UjAXlf7jETS6w3Sjg7NgFbtM6
	 m1IbR8QzJVCRQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272218>

On Fri, Jun 19, 2015 at 01:53:01PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Can you think of a name for the option that is as short as `--quick`
> > but means the same as `--connectivity-only`?
> 
> No I can't.  I think `--connectivity-only` is a very good name that
> is unfortunately a mouthful, I agree that we need a name that is as
> short as `--xxxxx` that means the same as `--connectivity-only`.  I
> do not think `--quick` is that word; it does not mean such a thing.

How about `--linkage` or `--links`?

-- 
Scott Schmit
