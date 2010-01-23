From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 3/4] msvc: Fix a compiler warning due to an incorrect
 pointer   cast
Date: Sat, 23 Jan 2010 01:08:32 +0100
Message-ID: <4B5A3E00.3030500@gmail.com>
References: <4B575AB6.4060502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:10:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTZw-0004s5-Nt
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab0AWAKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754128Ab0AWAKK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:10:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:58024 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140Ab0AWAKI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:10:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NYTZk-0004ok-Bc
	for git@vger.kernel.org; Sat, 23 Jan 2010 01:10:04 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:10:04 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:10:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <4B575AB6.4060502@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137791>

On 20.01.2010 20:34, Ramsay Jones wrote:

> Signed-off-by: Ramsay Jones<ramsay@ramsay1.demon.co.uk>
> ---
>
> The warning in question being:
>
>      .../regex.c(2811) : warning C4047: '=' : 'regoff_t *' differs in levels \
> of indirection from 'int'
>
> Note also that the final line of context in the diff below contains an ^L
> character, which will hopefully find it's way to the list...

Acked-by: Sebastian Schuberth <sschuberth@gmail.com>

-- 
Sebastian Schuberth
