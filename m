From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [BUG] Documentation: git log: --exit-code undocumented?
Date: Tue, 02 Dec 2014 14:30:31 +0300
Message-ID: <87ppc2xp9k.fsf@osv.gnss.ru>
References: <87zjb78u7g.fsf@osv.gnss.ru>
	<xmqqegsjqqox.fsf@gitster.dls.corp.google.com>
	<874mtfl1hx.fsf@fencepost.gnu.org>
	<xmqqwq6bp8ey.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 12:30:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvlfD-0000yI-A3
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 12:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbaLBLaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 06:30:35 -0500
Received: from mail.javad.com ([54.86.164.124]:43871 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbaLBLae (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 06:30:34 -0500
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 7198361812;
	Tue,  2 Dec 2014 11:30:33 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1Xvlf5-0007C6-Mn; Tue, 02 Dec 2014 14:30:31 +0300
In-Reply-To: <xmqqwq6bp8ey.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Dec 2014 09:49:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260552>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> I disagree that --exit-code does nothing: it indicates whether the
>> listed log is empty.  So for example
>>
>> git log -1 --exit-code a..b > /dev/null
>>
>> can be used to figure out whether "a" is a proper ancestor of "b" or
>> not.
>
> Hmph.
>
>     $ git log --exit-code master..maint >/dev/null; echo $?
>     0
>     $ git log --exit-code maint..master >/dev/null; echo $?
>     1
>
> That is a strange way to use --exit-code.

What's the best way then to tell if "a" is an ancestor of "b"?

-- 
Sergey.
