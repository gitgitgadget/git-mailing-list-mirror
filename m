From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: 'git rebase' silently drops changes?
Date: Sat, 07 Feb 2015 22:32:05 +0100
Message-ID: <54D68455.5070305@gmail.com>
References: <87386ispb3.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 22:32:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKCzE-0003U1-US
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 22:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682AbbBGVcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 16:32:16 -0500
Received: from plane.gmane.org ([80.91.229.3]:32783 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758672AbbBGVcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 16:32:15 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YKCz7-0003Rs-QD
	for git@vger.kernel.org; Sat, 07 Feb 2015 22:32:13 +0100
Received: from p57a25c1b.dip0.t-ipconnect.de ([87.162.92.27])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 22:32:13 +0100
Received: from sschuberth by p57a25c1b.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 22:32:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p57a25c1b.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <87386ispb3.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263456>

On 06.02.2015 22:28, Sergey Organov wrote:

> # Now rebase my work.
> git rebase -f HEAD~1
>
> # What? Where is my "Precious" change in "a"???
> cat a
> </SCRIPT>
>
> I.e., the modification marked [!] was silently lost during rebase!

Just a wild guess: Maybe because you omitted "-p" / "--preserve-merges" 
from "git rebase"?

-- 
Sebastian Schuberth
