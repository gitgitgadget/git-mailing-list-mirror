From: Aleksey Mokhovikov <moxobukob@gmail.com>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Tue, 18 Mar 2014 21:42:58 +0700
Message-ID: <lg9ljs$29p$1@ger.gmane.org>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com> <vpqd2hlrvo4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 15:40:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPvBk-0004ci-Re
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 15:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbaCROkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 10:40:13 -0400
Received: from plane.gmane.org ([80.91.229.3]:46968 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226AbaCROkM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 10:40:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WPvBT-0004Go-JD
	for git@vger.kernel.org; Tue, 18 Mar 2014 15:40:03 +0100
Received: from l37-193-248-93.novotelecom.ru ([37.193.248.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:40:03 +0100
Received: from moxobukob by l37-193-248-93.novotelecom.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 15:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: l37-193-248-93.novotelecom.ru
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <vpqd2hlrvo4.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244360>

Matthieu Moy <Matthieu.Moy <at> grenoble-inp.fr> writes:

>
> Hi,
>
> Aleksey Mokhovikov <moxobukob <at> gmail.com> writes:
>
> Please, read the threads for other submissions for this microproject.
> Most remarks done there also apply for your case. See for example:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/244210
>


Thank you for your reply.

I've read a bit more GNU gettext manual to get information
about translation with GNU gettext. Long story short, the idea to
generate message from parts will produce even more problems, despite
the message strings passed to the _() are equal before and after the patch.

So I decided to make an array with all messages and mark them for translation with "N_()" to keep them together. Because
we now have an array we can improve it to make a table with message format string and arguments. Now we need just to
find the proper message index to print the message.

Please look at another approach:
http://permalink.gmane.org/gmane.comp.version-control.git/244357
