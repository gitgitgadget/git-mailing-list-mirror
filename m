From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/9] Define a structure for object IDs.
Date: Mon, 05 May 2014 07:19:35 +0200
Message-ID: <87lhugu7iw.fsf@fencepost.gnu.org>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
	<1399147942-165308-2-git-send-email-sandals@crustytoothpaste.net>
	<5365D91E.70207@alum.mit.edu> <536606AB.1020803@kdbg.org>
	<m2mwexke34.fsf@linux-m68k.org> <5366A09E.6030802@kdbg.org>
	<87ppjt6xjv.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:32:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhvF-0005Yp-My
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbaEEJEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 05:04:20 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:56486 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129AbaEEJET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 05:04:19 -0400
Received: from localhost ([127.0.0.1]:55518 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WhEor-0000S0-3d; Mon, 05 May 2014 05:04:17 -0400
Received: by lola (Postfix, from userid 1000)
	id 8A7B9E08BB; Mon,  5 May 2014 07:19:35 +0200 (CEST)
In-Reply-To: <87ppjt6xjv.fsf@igel.home> (Andreas Schwab's message of "Sun, 04
	May 2014 23:31:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248140>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Isn't internal padding only allowed between members to achieve correct
>> alignment of later members, and at the end only sufficient padding so
>> that members are aligned correctly when the struct is part of an array?
>
> The standard allows arbitrary internal padding, it doesn't have to be
> minimal.

What the standard does guarantee is that a pointer to a struct can be
cast to a pointer to its first member and vice versa.  It does not as
far as I can see guarantee that a pointer to something of the same type
of its first member can be converted to a pointer to a struct even if
the struct only contains a member of such type.

-- 
David Kastrup
