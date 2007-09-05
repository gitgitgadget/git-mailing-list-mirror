From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH] Rework strbuf API and semantics.
Date: Wed, 05 Sep 2007 13:44:04 +0900
Message-ID: <buoabs1raaz.fsf@dhapc248.dev.necel.com>
References: <buobqcjrycl.fsf@dhapc248.dev.necel.com>
	<11888956802504-git-send-email-madcoder@debian.org>
	<Pine.LNX.4.64.0709041209280.28586@racer.site>
	<20070904115317.GA3381@artemis.corp>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 06:44:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISmkJ-00060X-Tx
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 06:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbXIEEoC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 00:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbXIEEoB
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 00:44:01 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:64918 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbXIEEoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 00:44:00 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l854hA1n028295;
	Wed, 5 Sep 2007 13:43:52 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Wed, 5 Sep 2007 13:43:52 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay31.aps.necel.com with ESMTP; Wed, 5 Sep 2007 13:43:52 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id E583E58A; Wed,  5 Sep 2007 13:44:05 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20070904115317.GA3381@artemis.corp> (Pierre Habouzit's message of "Tue\, 04 Sep 2007 13\:53\:17 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57667>

Pierre Habouzit <madcoder@debian.org> writes:
>   In my own coding rules, I have _new/_delete and _init/_wipe functions,
> the former acts on pointers, the latter on the structs. Hence the
> naming.

A little off-topic, but my own personal convention for the latter case
are _init/_fini -- I've always thought the "fini" name was a pretty good
partner for "init", so I share it here... :-)

-Miles

-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
