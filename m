From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 12:23:30 -0700
Message-ID: <F50884C0-3C80-450C-A799-3940D8B68B3D@sb.org>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com> <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com> <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com> <20100831143839.GC16034@foucault.redhat.com> <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com> <20100831155159.GD16034@foucault.redhat.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:23:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWQk-0006sX-7m
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754986Ab0HaTXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:23:33 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59603 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab0HaTXd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 15:23:33 -0400
Received: by pzk9 with SMTP id 9so2572485pzk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:23:32 -0700 (PDT)
Received: by 10.114.110.16 with SMTP id i16mr1168204wac.208.1283282612777;
        Tue, 31 Aug 2010 12:23:32 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id r37sm10307369wak.23.2010.08.31.12.23.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 12:23:32 -0700 (PDT)
In-Reply-To: <20100831155159.GD16034@foucault.redhat.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154970>

This message was originally rejected from the list due to containing an HTML subpart. Resending as plain text.

---

What about using Bonjour (a.k.a. DNS-SD) on OSes that provide this functionality? A lot of us already have local networks that are designed to let Bonjour propagate across the entire network, but hasn't been tested on simple UDP multicast. And with Bonjour you can even get wide-area Bonjour domains, so for example I could set up git hive on my desktop at home, and then get at it via my MobileMe wide-area Bonjour domain from anywhere else in the world.

-Kevin Ballard

On Aug 31, 2010, at 8:52 AM, Casey Dahlin wrote:

> Local networks on the same
> subnet have the option of UDP multicast. Avahi can do that. I'd be willing to
> do it manually or with something else. But yes, for your WAN case its useless.
