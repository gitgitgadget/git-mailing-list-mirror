From: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
Subject: Re: Push not writing to standard error
Date: Mon, 18 Oct 2010 12:39:38 -0400
Organization: MAD House Graphics
Message-ID: <4CBC784A.1040805@mhg2.com>
References: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: cbrammer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 18 18:40:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7sl4-0003gv-VG
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 18:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932995Ab0JRQjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 12:39:52 -0400
Received: from lo.gmane.org ([80.91.229.12]:50154 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932990Ab0JRQjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 12:39:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P7skV-0003UE-2b
	for git@vger.kernel.org; Mon, 18 Oct 2010 18:39:47 +0200
Received: from 74.102.83.28 ([74.102.83.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 18:39:47 +0200
Received: from scottg.wp-hackers by 74.102.83.28 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 18:39:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 74.102.83.28
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.7
In-Reply-To: <AANLkTim6j7cXj2-1JnKdNLb8KFJK86F02tzeByDBskEa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159263>

On 10/12/2010 03:04 PM, Chase Brammer wrote:
> git fetch origin master --progress>  /fetch_error_ouput.txt 2>&1

Just as a small tip, you can shorthand this in bash using
	git fech origin master --progress >& /fetch_error_output.txt

HTH :)


-- 
(please respond to the list as opposed to my email box directly,
unless you are supplying private information you don't want public
on the list)
