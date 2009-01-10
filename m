From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 02:50:15 +0100
Organization: At home
Message-ID: <gk8usj$slh$1@ger.gmane.org>
References: <87wsd48wam.fsf@iki.fi> <1231549039-5236-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 02:51:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLT0t-0001nC-1c
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbZAJBuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 20:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbZAJBuX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:50:23 -0500
Received: from main.gmane.org ([80.91.229.2]:44092 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbZAJBuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 20:50:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LLSzT-0003BV-0L
	for git@vger.kernel.org; Sat, 10 Jan 2009 01:50:19 +0000
Received: from abwp34.neoplus.adsl.tpnet.pl ([83.8.239.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 01:50:18 +0000
Received: from jnareb by abwp34.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 01:50:18 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwp34.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105063>

Thomas Rast wrote:

> --color-words works (and always worked) by splitting words onto one
> line each, and using the normal line-diff machinery to get a word
> diff. 

Cannot we generalize diff machinery / use underlying LCS diff engine
instead of going through line diff?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
