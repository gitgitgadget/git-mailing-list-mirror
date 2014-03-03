From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Mon, 03 Mar 2014 20:51:30 +0100
Message-ID: <87siqzjc1p.fsf@fencepost.gnu.org>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
	<CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
	<xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
	<CAPig+cTmejtWXRzr6qk-kd+P8j4b6xMJSUVnNnqObqNXc-S9UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, He Sun <sunheehnus@gmail.com>,
	Faiz Kothari <faiz.off93@gmail.com>, git <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:52:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYu6-0007wi-KE
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbaCCTve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:51:34 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:59090 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbaCCTvc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:51:32 -0500
Received: from localhost ([127.0.0.1]:58130 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKYtf-0002n6-2a; Mon, 03 Mar 2014 14:51:31 -0500
Received: by lola (Postfix, from userid 1000)
	id 95134E07E8; Mon,  3 Mar 2014 20:51:30 +0100 (CET)
In-Reply-To: <CAPig+cTmejtWXRzr6qk-kd+P8j4b6xMJSUVnNnqObqNXc-S9UA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 3 Mar 2014 14:46:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243262>

Eric Sunshine <sunshine@sunshineco.com> writes:

> As a potential GSoC student and newcomer to the project, Faiz would
> not have known that this would be considered unwanted churn when he
> chose the task from the GSoC microproject page [1]. Perhaps it would
> be a good idea to retire this item from the list?
>
> On the other hand, it did expose Faiz to the iterative code review
> process on this project and gave him a taste of what would be expected
> of him as a GSoC student, so the microproject achieved that important
> goal, and thus wasn't an utter failure.

And the microproject has the fabulous property that we can use it over
and over again to have a newcomer try committing patches: the previously
reported problem that we were running out of microprojects will not
occur when every patch is eventually going to be rejected.

Joking aside, this is a motivational disaster.  It should be retired.

-- 
David Kastrup
