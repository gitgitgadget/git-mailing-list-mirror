From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 33/40] When installing, be prepared that template_dir
   may be relative.
Date: Thu, 28 Feb 2008 16:57:13 +0100
Message-ID: <fq6lko$skq$1@ger.gmane.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-34-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281542000.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 16:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUl92-0003wB-9R
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758490AbYB1P52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757572AbYB1P52
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:57:28 -0500
Received: from main.gmane.org ([80.91.229.2]:60472 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757398AbYB1P52 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:57:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JUl8N-0002fC-H5
	for git@vger.kernel.org; Thu, 28 Feb 2008 15:57:23 +0000
Received: from 195.176.178.209 ([195.176.178.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 15:57:23 +0000
Received: from bonzini by 195.176.178.209 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 15:57:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 195.176.178.209
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.LSU.1.00.0802281542000.22527@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75417>


>> +ifeq ($(firstword $(subst /, ,$(template_dir))),..)
> 
> How portable is "firstword"?  Would it not be better to use

At least make 3.78.1 (1999), search func_firstword in 
http://snipurl.com/20lle (Google Code Search).

Paolo

