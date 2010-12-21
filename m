From: Adam Kellas <Adam.Kellas@gmail.com>
Subject: Re: Basic Git Questions
Date: Mon, 20 Dec 2010 21:59:38 -0500
Message-ID: <iep54u$tqp$1@dough.gmane.org>
References: <20101220192152.4509.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 21 04:00:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUsSS-0007Od-3b
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 04:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933497Ab0LUC6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 21:58:53 -0500
Received: from lo.gmane.org ([80.91.229.12]:37995 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933446Ab0LUC6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 21:58:52 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PUsR7-0006sf-GV
	for git@vger.kernel.org; Tue, 21 Dec 2010 03:58:49 +0100
Received: from c-76-24-28-236.hsd1.ma.comcast.net ([76.24.28.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 03:58:49 +0100
Received: from Adam.Kellas by c-76-24-28-236.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 03:58:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-76-24-28-236.hsd1.ma.comcast.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20101220192152.4509.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164024>

On 12/20/2010 2:21 PM, George Spelvin wrote:
> 1) .gitignore.  If the files are such that you never want git to pay
>     attention to them, you can add them to the .gitignore file.

My own preferred pattern is to flip the default: I put a '*' in 
.gitignore and use "add -f" when I want files tracked.

AK
