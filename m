From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: can't redirect git's progress output (stderr)
Date: Mon, 01 Nov 2010 21:38:10 +0100
Message-ID: <4CCF2532.3070703@web.de>
References: <4CCEB53E.9080102@azabani.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: delan@azabani.com
X-From: git-owner@vger.kernel.org Mon Nov 01 21:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD18z-0005mB-U1
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 21:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab0KAUiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 16:38:13 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:34986 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab0KAUiM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 16:38:12 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5B4FA17D42B87;
	Mon,  1 Nov 2010 21:38:11 +0100 (CET)
Received: from [213.64.3.195] (helo=birne.lan)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PD18t-0001iM-00; Mon, 01 Nov 2010 21:38:11 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CCEB53E.9080102@azabani.com>
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX19/qPMjnCEKqDFXDOynICMzbge1WdZDOtsN1bSc
	L+f495006Qb/NSJDW6q8fh7bpWIYpVRG94cqDPjgsI2NcEZjJ0
	zePrEz0ao=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160497>

Try
git clone git://your.favourite/git/repo > file2 2>&1
/Torsten


On 01.11.10 13:40, Delan Azabani wrote:

> Hi all,
>
> I'm writing a URI handler for git that uses bash/zenity to allow the
> user to clone a git repository when a git:// link is clicked in a browser.
>
> I'm having a bit of trouble getting git's output into zenity, however.
> git outputs its progress messages (everything except the "Initializing"
> message) on stderr, which shouldn't be a problem. Something weird has
> happened though; the moment I try to pipe git's stderr to stdout or a
> file, it disappears.
>
> A simple way to test this:
>
> git clone git://your.favourite/git/repo 2>  file1
> git clone git://your.favourite/git/repo 2>&1>  file2
>
> file1 will be empty (why?) and file2 will contain only the
> "Initializing" message, which came from stdout.
>
> TL;DR why can't I pipe git's stderr output?
>
> Help would be greatly appreciated; thanks in advance.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
