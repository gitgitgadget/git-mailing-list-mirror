From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: git-commit goes awry after git-add -u
Date: Thu, 16 Aug 2007 08:43:22 +0900
Message-ID: <46C38F9A.2050804@gmail.com>
References: <f9v1t6$uph$1@sea.gmane.org> <7v643gplph.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 01:44:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILSWw-0005kJ-SD
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 01:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbXHOXn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 19:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbXHOXn4
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 19:43:56 -0400
Received: from main.gmane.org ([80.91.229.2]:41909 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762873AbXHOXnz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 19:43:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILSWh-0000t7-N6
	for git@vger.kernel.org; Thu, 16 Aug 2007 01:43:48 +0200
Received: from 221x115x75x108.ap221.ftth.ucom.ne.jp ([221.115.75.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 01:43:47 +0200
Received: from salikh by 221x115x75x108.ap221.ftth.ucom.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 01:43:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 221x115x75x108.ap221.ftth.ucom.ne.jp
User-Agent: Thunderbird 2.0.0.4 (X11/20070708)
In-Reply-To: <7v643gplph.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55970>

Junio C Hamano wrote:
> Salikh Zakirov <salikh@gmail.com> writes:
> 
>> I have observed incorrect behaviour of git-commit after git-add -u, where
>> it records deletions of files not related to the files touched by commit.
> 
> Does this fix the issue?

Thanks, solved the issue nicely.
