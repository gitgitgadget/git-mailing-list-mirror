From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 23:58:17 +0900
Message-ID: <878x6wrtyu.fsf@catnip.gol.com>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz>
	<ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com>
	<86ejgowl5g.fsf@lola.quinscape.zz>
	<20070924080134.GA9112@artemis.corp>
	<20070924080436.GB9112@artemis.corp>
	<Pine.LNX.4.64.0709241128460.28395@racer.site>
	<87ps08s3zt.fsf@catnip.gol.com>
	<20070924113556.GI8111@void.codelabs.ru>
	<87k5qgrxcu.fsf@catnip.gol.com>
	<Pine.LNX.4.64.0709241502330.28395@racer.site>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:58:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZpOA-0005xJ-PC
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 16:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbXIXO6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 10:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbXIXO6O
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 10:58:14 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:46812 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbXIXO6N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 10:58:13 -0400
Received: from 203-216-103-127.dsl.gol.ne.jp ([203.216.103.127] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IZpNs-0001Fr-SI; Mon, 24 Sep 2007 23:58:04 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 838F52F41; Mon, 24 Sep 2007 23:58:18 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <Pine.LNX.4.64.0709241502330.28395@racer.site> (Johannes Schindelin's message of "Mon\, 24 Sep 2007 15\:04\:32 +0100 \(BST\)")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59055>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> In practice that's not an issue though -- every reasonable shell has 
>> test as a builtin these days, so the "works when test is not a builtin" 
>> criteria is really important only for robustness.
>
> AAAAAAAAAAAAAARRRRRGGGHHHHHHHHHHHH!
>
> _Exactly_ the same reasoning can be said about the old code: _every_ 
> reasonable shell can grok the code that used to be there!

As has been stated, that's not true.  Some "real" shells don't handle
the old code correctly (and the old code is less readable as well).

AFAIK, the new code works all cases, it's merely very slightly slower in
unusual circumstances.

-Miles

-- 
/\ /\
(^.^)
(")")
*This is the cute kitty virus, please copy this into your sig so it can spread.
