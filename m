From: Miles Bader <miles@gnu.org>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Thu, 05 Feb 2009 14:46:06 +0900
Message-ID: <buobptho2qp.fsf@dhlpc061.dev.necel.com>
References: <1233432317.26364.5.camel@wren>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Thu Feb 05 06:47:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUx5X-0005NP-Vh
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 06:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbZBEFqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 00:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZBEFqV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 00:46:21 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:51431 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbZBEFqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 00:46:20 -0500
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n155k6CD020845;
	Thu, 5 Feb 2009 14:46:06 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Thu, 5 Feb 2009 14:46:06 +0900
Received: from dhlpc061 ([10.114.112.240] [10.114.112.240]) by relay11.aps.necel.com with ESMTP; Thu, 5 Feb 2009 14:46:06 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 6C85952E27C; Thu,  5 Feb 2009 14:46:06 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <1233432317.26364.5.camel@wren> (Jesse van den Kieboom's message
	of "Sat, 31 Jan 2009 21:05:17 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108499>

I tried to clone using http (firewall), and it though it appears to
start working, I get an error eventually:

   $ git --version
   git version 1.6.0.6

   $ git clone http://github.com/jessevdk/gitg.git
   Initialized empty Git repository in /usr/local/src/gitg/.git/
   got b6905b4a594d43471dda682069912304d00d09eb
   walk b6905b4a594d43471dda682069912304d00d09eb
   got c559141e06684a257840ec25c492a559d762c6b4
   walk c559141e06684a257840ec25c492a559d762c6b4
   Getting alternates list for http://github.com/jessevdk/gitg.git
   got 8fdef672ca37fba292666a35ae63c7fdc9ceae05
   got becd09a6a05f55c3741f17dd60011f26ff0ad874
   got 1688b6f4c46dd6328ef4bd2d57001758d2cf87bc
   Getting pack list for http://github.com/jessevdk/gitg.git
   Getting index for pack 019562eeb660cc8f1998353b219a3000c647bba9
   Getting index for pack ca4b00556f8e389b94c726653bf57a23f70b5a0b
   Getting pack ca4b00556f8e389b94c726653bf57a23f70b5a0b
    which contains a9ac1b4d3ed7eae52bfbbaeed0a525c50e481b3f
   walk a9ac1b4d3ed7eae52bfbbaeed0a525c50e481b3f
   walk becd09a6a05f55c3741f17dd60011f26ff0ad874
   walk 09fa7f817482d655a17bf1c7215b8ec7b7d5e697
   walk b7d1d352bcb070a5e73f46bdc487e74c449e436d
   Getting pack 019562eeb660cc8f1998353b219a3000c647bba9
    which contains bc49446c1ab52217992bd73ade9bd9f6574d995f
   got b79e613eef67c570dff79c86d7155180fc0d1993
   got c6da20bc4c8d99d148affb8f4605cabfa08f0cf5
   got 9717983538ba087b26d32a3823e500c59b18ba93
   got e2f46af996c641dec74313fe3db2fef04678ca7a
   walk e2f46af996c641dec74313fe3db2fef04678ca7a
   got 8971bd20ee4c457a8ac32f26efa36b735ff954ba
   walk 0365be545a2156e77d9eec0804adec69b35db632
   walk 19d3917fe5fcb7ef25f2c76e53a9742354a12cc7
   got ce40340f97057dc50ea314fa2a6a25c1ae4b6053
   got fdca485305da4e49842004a793ed2c7e4e6ae765
   got b0ee0d42e9597f94adbb732b783de9b0b42f27f3
   got 94183c7e640174baf49c9e17ba59bddf98a8c8a1
   got 864fad05580300d4baa44aba2f472aebc63c38c0
   got 6d2b4734c562559f64581dd720dd6f7760a97124
   got d5d59822ef7dffb9eea1bff9a22b55f444734792
   got 1bd98d6397207409b2d00c8e1e1e7ec6066f9300
   got e700b08924147d61b9299130ee47ca5256bf6895
   got e359f0b9fc690b0d83a8e7e59b7069942f616cc4
   got cad64b422dc0a48a701d22ad586cc219a14a589d
   got 0756b0f050651f88fa541d154c6631bd298c3a99
   got be8cf3be5d2b499be2d7eadb9254c84709f885f3
   got 02ef6e9b53ede0495023862a460b952a7f0e41a8
   got 6d7a6159dd2797d8b01d49b615e1380f6bdc646c
   got 27b8f2d6c73b5c2eaf9b23c5ca0893957631fedb
   got 97d57428c4649edc653f9d50875acd8388ace724
   got 3f2cafcf18b14c75607eb7366be1ad10dd924962
   got 494b20433224100558e0625aebb2bb0f7168656f
   got 95f1f1e37f4e9ce33be2b29ff52bf670d2f27e15
   got 807f07450726a5aae13978c7b04ca5f4ae73a0b2
   got 7cf9ac5c258058017eca5ff91e6577cd31bed7d3
   got 867fff716512d15932980f703f2b3141fa1cfaca
   got 5fb67720ee8c962cbada9f572118ab12a3312249
   got 514777443f83cb6527042295444bf2e10e36e008
   got 032efecf0d387f8ee74c14dc88ab3d71491d55ed
   got 17e5cf02238de9c2636f6cf563a3a92ad75a077b
   got 31ed6bed0e57588c36349ee2ffb56fda45f9648b
   got 8b44321297cc6593cf93829b7b9ed322dbfc4a7b
   walk 8b44321297cc6593cf93829b7b9ed322dbfc4a7b
   got f74d7432fe2d86af12195b504ad45a2413a56cba
   got 48c31a1729ef64a96229eb5d259da51a60baf5ea
   walk 29e4a12594a6715db381757e820222ffc4f7c604
   walk 1b911a24f8f2cd0d52fa2cbec4a1dd9a9c5fc8b0
   got 56c41000b3762029629368794352d6aee91c7321
   got cae311b6c8277d6649ee692b2ef5a4863b854eb5
   got 9eeb2d6ef373540b1fbc1ad9239e5129ad445ad4
   error: Unable to find abd95fbc10fd6734ab17dde11ace646106def960 under http://github.com/jessevdk/gitg.git
   Cannot obtain needed blob abd95fbc10fd6734ab17dde11ace646106def960
   while processing commit 1b911a24f8f2cd0d52fa2cbec4a1dd9a9c5fc8b0.
   fatal: Fetch failed.

-miles

-- 
Electricity, n. The cause of all natural phenomena not known to be caused by
something else.
