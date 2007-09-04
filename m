From: Miles Bader <miles.bader@necel.com>
Subject: Re: strbuf API
Date: Tue, 04 Sep 2007 10:52:26 +0900
Message-ID: <buobqcjrycl.fsf@dhapc248.dev.necel.com>
References: <20070902224213.GB431@artemis.corp>
	<200709030743.44188.johan@herland.net>
	<20070903084610.GA21759@artemis.corp>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Sep 04 03:52:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISNau-0007cJ-1i
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 03:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbXIDBwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 21:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbXIDBwj
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 21:52:39 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:33411 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbXIDBwi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 21:52:38 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l841pboa023256;
	Tue, 4 Sep 2007 10:52:13 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay31.aps.necel.com with ESMTP; Tue, 4 Sep 2007 10:52:13 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay21.aps.necel.com with ESMTP; Tue, 4 Sep 2007 10:52:13 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 07CD1476; Tue,  4 Sep 2007 10:52:26 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20070903084610.GA21759@artemis.corp> (Pierre Habouzit's message of "Mon\, 03 Sep 2007 10\:46\:10 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57510>

Pierre Habouzit <madcoder@debian.org> writes:
>   For the record, I dislike the fact that bstring pullutes the b*
> namespace, whereas it should use bstr as a prefix everywhere, and some
> functions (like bstrcpy, that should definitely be named bstrdup) are
> really named the _wrong_ way

Yeah, I got the same impression.  There's an odd "accumulated
haphazardly over time" feel to much of it.

[One thing I found especially weird is the way the "core" interface uses
lowercase names, but the "aux" interfaces all seem to use StUDlyCaPS...]

-Miles
-- 
Ich bin ein Virus. Mach' mit und kopiere mich in Deine .signature.
