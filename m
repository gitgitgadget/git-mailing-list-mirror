From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 17 May 2010 21:07:13 +0900
Message-ID: <buofx1qhgum.fsf@dhlpc061.dev.necel.com>
References: <878w7ieu4p.fsf@thor.thematica.it>
	<4BF12C96.9030802@drmicha.warpmail.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Scrivano <gscrivano@gnu.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 17 14:07:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODz6X-0004Hp-AV
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 14:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab0EQMHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 08:07:23 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:37969 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab0EQMHX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 08:07:23 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o4HC7E8V011004;
	Mon, 17 May 2010 21:07:14 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o4HC7EO01422; Mon, 17 May 2010 21:07:14 +0900 (JST)
Received: from relay51.aps.necel.com ([10.29.19.60]) by vgate02.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
	id o4HC7Da27023; Mon, 17 May 2010 21:07:13 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay51.aps.necel.com with ESMTP; Mon, 17 May 2010 21:07:13 +0900
Received: from dhlpc061 ([10.114.112.154] [10.114.112.154]) by relay21.aps.necel.com with ESMTP; Mon, 17 May 2010 21:07:13 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 3649152E1F3; Mon, 17 May 2010 21:07:13 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <4BF12C96.9030802@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 17 May 2010 13:46:30 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147228>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> Now, usage messages are displayed on specific request (-h) as well as
> when a command is used with wrong arguments. So the classification
> depends on the use case! But I reckon that even with '-h', usage strings
> are not exactly "regular output", so stderr looks more natural to me.

Usage info specifically requested by the user is not error output, it is
the output of the command.  It should be output to stdout, not stderr.

[Note that for GNU progs, this behavior is explicitly required by the
GNU coding standards, and I think it's a pretty reasonable rule.]

-miles

-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
