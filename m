From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] PAGER_ENV: remove 'S' from $LESS by default
Date: Mon, 28 Apr 2014 11:14:50 +0200
Message-ID: <87k3a96cj9.fsf@fencepost.gnu.org>
References: <20140425154722.GC11479@google.com>
	<1398674062-24288-1-git-send-email-Matthieu.Moy@imag.fr>
	<87vbtt6dyq.fsf@fencepost.gnu.org> <vpqsioxn82l.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 28 14:05:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WekJQ-0005Hm-7J
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 14:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbaD1MFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 08:05:19 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:33268 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059AbaD1MFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 08:05:13 -0400
Received: from localhost ([127.0.0.1]:60532 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WekJ6-0001Nc-3Q; Mon, 28 Apr 2014 08:05:12 -0400
Received: by lola (Postfix, from userid 1000)
	id A8F57E05FE; Mon, 28 Apr 2014 11:14:50 +0200 (CEST)
In-Reply-To: <vpqsioxn82l.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	28 Apr 2014 10:59:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247305>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> There seem to be a few more occurences (git-sh-setup.sh and pager.c):
>
> Not since f82c3ffd862c7 (Wed Feb 5 2014, move LESS/LV pager environment
> to Makefile).

The only upstream branch containing this commit is pu.  So this patch
should likely not go anywhere else for now.

-- 
David Kastrup
