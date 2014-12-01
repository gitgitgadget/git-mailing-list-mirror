From: David Kastrup <dak@gnu.org>
Subject: Re: [BUG] Documentation: git log: --exit-code undocumented?
Date: Mon, 01 Dec 2014 18:32:26 +0100
Message-ID: <874mtfl1hx.fsf@fencepost.gnu.org>
References: <87zjb78u7g.fsf@osv.gnss.ru>
	<xmqqegsjqqox.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:32:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvUpt-0001Jg-Dh
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 18:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbaLARc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 12:32:29 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:38743 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbaLARc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 12:32:28 -0500
Received: from localhost ([127.0.0.1]:37784 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1XvUpn-0003xn-6Q; Mon, 01 Dec 2014 12:32:27 -0500
Received: by lola (Postfix, from userid 1000)
	id BB948E0A95; Mon,  1 Dec 2014 18:32:26 +0100 (CET)
In-Reply-To: <xmqqegsjqqox.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Dec 2014 08:29:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260495>

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Hello,
>>
>> $ git help log | grep exit-code
>>            problems are found. Not compatible with --exit-code.
>> $
>>
>> What --exit-code does in "git log"?
>
> It doesn't.  That is why it is not listed.

I disagree that --exit-code does nothing: it indicates whether the
listed log is empty.  So for example

git log -1 --exit-code a..b > /dev/null

can be used to figure out whether "a" is a proper ancestor of "b" or
not.

-- 
David Kastrup
