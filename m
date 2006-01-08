From: Tony Luck <tony.luck@intel.com>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 12:50:27 -0800
Message-ID: <12c511ca0601081250h726b0e14u7703f9d6910891ee@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	 <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
	 <7vace61plu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0601081156430.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932766AbWAHUu3@vger.kernel.org Sun Jan 08 21:50:47 2006
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932766AbWAHUu3@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvhV0-0004pf-36
	for glk-linux-kernel-3@gmane.org; Sun, 08 Jan 2006 21:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWAHUu3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 8 Jan 2006 15:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbWAHUu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 15:50:29 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:334 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932394AbWAHUu2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 15:50:28 -0500
Received: by wproxy.gmail.com with SMTP id 57so3173551wri
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2006 12:50:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ajgAx95WkPgdm/ZBwPVwxXE0sKj150c+CZT2wtnRrq3vUd7ZVuoTgrhCiHsJZSVluTenncMo+VcSFNMqNaOA3Ke3gih/NC8iklg8CQge6nWX16yu8sd5kUBt9TxmzxDM+htTG0NAKmfFnVEVQR3ZmucPZgPJziAPWL0WwMXUMZI=
Received: by 10.65.95.5 with SMTP id x5mr2367003qbl;
        Sun, 08 Jan 2006 12:50:27 -0800 (PST)
Received: by 10.64.27.2 with HTTP; Sun, 8 Jan 2006 12:50:27 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601081156430.3169@g5.osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14334>

I'll try to update the using-topic-branches document to capture this.
Some of the problem is that it doesn't quite capture what I'm doing
with my test/release branches.

My release branch really is just used as a transfer point to Linus.
I usually[1] don't leave patches sitting in "release" for long enough
that I'll be tempted to merge in from Linus ... once I decide that
some patches are ready to go to Linus I'll update "release" from Linus
(which will be a fast-forward, so no history) merge in the topic
branches, do one final sanity build, push to kernel.org and send
the "please pull" e-mail.

The huge majority of my "automatic update from upstream" merges
go into my test branch ... which never becomes part of the real
history as I never ask Linus to pull from it.

-Tony

[1] Sometimes I goof on this because I forget that I've applied
a trivial patch directly to the release branch without going through
a topic branch.  I think I'll fix my update script to check for this case.
