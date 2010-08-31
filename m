From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Tue, 31 Aug 2010 12:21:35 -0700
Message-ID: <9CA6AC3D-5C51-4770-BF78-077DE5CD80C5@sb.org>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com> <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com> <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com> <20100831143839.GC16034@foucault.redhat.com> <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com> <20100831155159.GD16034@foucault.redhat.com> <815C806E-E7DC-4B7D-9B45-4C9B289DFEEF@sb.org> <20100831191909.GF16034@foucault.redhat.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:21:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWOt-0005iO-TI
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209Ab0HaTVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:21:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42841 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab0HaTVj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 15:21:39 -0400
Received: by pzk9 with SMTP id 9so2572052pzk.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:21:38 -0700 (PDT)
Received: by 10.114.12.15 with SMTP id 15mr4061846wal.134.1283282497590;
        Tue, 31 Aug 2010 12:21:37 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id o17sm10760227wal.21.2010.08.31.12.21.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 12:21:36 -0700 (PDT)
In-Reply-To: <20100831191909.GF16034@foucault.redhat.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154969>

On Aug 31, 2010, at 12:19 PM, Casey Dahlin wrote:

> On Tue, Aug 31, 2010 at 12:15:39PM -0700, Kevin Ballard wrote:
>> What about using Bonjour (a.k.a. DNS-SD) on OSes that provide this functionality? A lot of us already have local networks that are designed to let Bonjour propagate across the entire network, but hasn't been tested on simple UDP multicast. And with Bonjour you can even get wide-area Bonjour domains, so for example I could set up git hive on my desktop at home, and then get at it via my MobileMe wide-area Bonjour domain from anywhere else in the world.
>> 
>> -Kevin Ballard
>> 
> 
> Avahi is Linux's Bonjour implementation ;)
> 
> --CJD

Ah hah, now it makes sense. I guess I should have looked up Avahi before just assuming it was some other P2P doohickey. Now, if git-hive is running on OS X, will it still be using a bundled version of Avahi, or will it default to using the system-provided mDNSResponder daemon (e.g. OS X's Bonjour)?

-Kevin Ballard