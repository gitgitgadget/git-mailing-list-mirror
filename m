From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RGC/PATCHv2] grep: submodule support
Date: Sat, 16 Oct 2010 17:54:59 +0200
Message-ID: <4CB9CAD3.7060109@web.de>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 16 17:56:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P797D-0007U1-HR
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 17:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab0JPP4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Oct 2010 11:56:00 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:34497 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0JPPz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Oct 2010 11:55:59 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 769BE16F3D272;
	Sat, 16 Oct 2010 17:55:04 +0200 (CEST)
Received: from [93.246.57.44] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P7968-0007ey-00; Sat, 16 Oct 2010 17:55:04 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+dYAez/1JZOYlIIkfg01cv56zoxy9wUHlFJMMK
	b13zohNu9slaQHnl6XCnbNLGZT434b6wgHv9baV4AOlBZVhSC9
	iFLongxANcLOFDfypj2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159166>

Am 16.10.2010 01:26, schrieb Chris Packham:
> Here is my updated grep support for submodules series.

Thanks Chris and Duy, I added this series to my git-submod-enhancements
repo on github and will give it some testing next week.

> Chris Packham (4):
>       grep: output the path from cwd to worktree
>       grep_cache: check pathspec first
>       add test for git grep --recursive

Hmm, is it useful to add tests before adding the feature tested? I
thought it makes more sense to add them in the same commit or after
adding what is tested (e.g. to reduce the noise when bisecting
later). Or am I missing something here?

(And by the way: the test script should be executable)

>       grep: add support for grepping in submodules

Nit: The commit message (5/5) talks about the old option name
"--recurse-submodules" instead of the "--recursive" the patch
is adding.

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
>       worktree: provide better prefix to go back to original cwd
