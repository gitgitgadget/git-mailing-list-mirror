From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 1/4] engine.pl: Fix a recent breakage of the buildsystem
   generator
Date: Sat, 23 Jan 2010 00:48:40 +0100
Message-ID: <4B5A3958.5060505@gmail.com>
References: <4B5A03EF.1030208@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, pgit@pcharlan.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 00:50:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTGj-00068e-PF
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 00:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab0AVXuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 18:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073Ab0AVXuV
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 18:50:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:42030 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab0AVXuU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 18:50:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NYTG7-0005g5-2f
	for git@vger.kernel.org; Sat, 23 Jan 2010 00:49:47 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 00:49:47 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 00:49:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <4B5A03EF.1030208@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137788>

On 22.01.2010 21:00, Ramsay Jones wrote:

> Commit ade2ca0c (Do not try to remove directories when removing
> old links, 27-10-2009) added an expression to a 'test' using an
> '-o' or connective. This resulted in the buildsystem generator
> mistaking a conditional 'rm' for a linker command. In order to
> fix the breakage, we filter out all 'test' commands before then
> attempting to identify the commands of interest.
>
> Signed-off-by: Ramsay Jones<ramsay@ramsay1.demon.co.uk>
> ---
>
> Changes from v1, in response to comments from Pete Harlan and
> Sebastian Schuberth:
>
>      - remove second (useless) regex from condition in filter code
>      - remove the commented out version of the original filter code
>      - re-worded commit message to reflect the above changes

Acked-by: Sebastian Schuberth <sschuberth@gmail.com>

Thanks again!

-- 
Sebastian Schuberth
