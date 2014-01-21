From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 22:30:22 +0100
Message-ID: <87mwipowep.fsf@fencepost.gnu.org>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
	<87d2jlqp7x.fsf@fencepost.gnu.org> <20140121165546.GE18964@google.com>
	<874n4xqlly.fsf@fencepost.gnu.org> <20140121174448.GG18964@google.com>
	<87zjmpp672.fsf@fencepost.gnu.org> <20140121191531.GH18964@google.com>
	<87r481p0rt.fsf@fencepost.gnu.org> <20140121200149.GJ18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 22:30:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5ity-00044I-BK
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 22:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbaAUVaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 16:30:25 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:45830 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259AbaAUVaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 16:30:23 -0500
Received: from localhost ([127.0.0.1]:44871 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1W5itq-0004VL-IS; Tue, 21 Jan 2014 16:30:22 -0500
Received: by lola (Postfix, from userid 1000)
	id 26015E051D; Tue, 21 Jan 2014 22:30:22 +0100 (CET)
In-Reply-To: <20140121200149.GJ18964@google.com> (Jonathan Nieder's message of
	"Tue, 21 Jan 2014 12:01:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240776>

Jonathan Nieder <jrnieder@gmail.com> writes:

> David Kastrup wrote:
>
>> and contrib.  The README file states
>>
>>     Git is an Open Source project covered by the GNU General Public
>>     License version 2 (some parts of it are under different licenses,
>>     compatible with the GPLv2). It was originally written by Linus
>>     Torvalds with help of a group of hackers around the net.
>>
>> without mentioning _which_ parts are under different licenses.
>
> Okay, how about this patch?
>
> diff --git i/README w/README
> index 15a8e23..6745db5 100644
> --- i/README
> +++ w/README
> @@ -21,8 +21,9 @@ and full access to internals.
>  
>  Git is an Open Source project covered by the GNU General Public
>  License version 2 (some parts of it are under different licenses,
> -compatible with the GPLv2). It was originally written by Linus
> -Torvalds with help of a group of hackers around the net.
> +compatible with the GPLv2, and have notices to that effect). It was
> +originally written by Linus Torvalds with help of a group of hackers
> +around the net.

Clearer.  I think it would be most accurate to state:

    Git is an Open Source project covered by the GNU General Public
    License version 2.  Those parts of it which may be also be
    distributed under other licenses contain notices to that effect.

The point is that as a whole, the software is distributed under GPLv2
(that's what "compatible" licensing actually means since the GPL demands
distribution of the software "as a whole" under the GPL) but parts of it
may optionally be distributed under other licenses.

-- 
David Kastrup
