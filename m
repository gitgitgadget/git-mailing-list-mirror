From: Ralf Ebert <info@ralfebert.de>
Subject: Re: [PATCH v2] Do not unquote + into ' ' in URLs
Date: Fri, 06 Aug 2010 12:46:42 +0200
Message-ID: <i3gp6i$qap$1@dough.gmane.org>
References: <201007240104.25341.trast@student.ethz.ch> <ed2d311355fca478f97b82f8d955494509d6b9de.1279982471.git.trast@student.ethz.ch> <AANLkTikY_ayRzdbQ2Qsf6wus+=yg99aTLDTahVXUw0eK@mail.gmail.com> <201007312333.38471.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 12:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhKVB-0000P9-DD
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 12:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933766Ab0HFKuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 06:50:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:49241 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761184Ab0HFKuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 06:50:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OhKV2-0000NB-Lr
	for git@vger.kernel.org; Fri, 06 Aug 2010 12:50:04 +0200
Received: from i59f7b502.versanet.de ([89.247.181.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 12:50:04 +0200
Received: from info by i59f7b502.versanet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 12:50:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: i59f7b502.versanet.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <201007312333.38471.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152774>

Hi,

> To be precise, if the client ever attempts to decode URLs with query
> strings (for whatever reasons) then it would break.  Probably there
> are no such URLs, but I don't know for sure.

url_decode seems to be called only from connect.c to support 
percent-encoding for git/ssh-URLs, so at least as of now, there should 
be no problem here. Since applying the patch, git clone 
'git://git.gnome.org/gtk+' works ok again for me.

Greetings,

Ralf
