From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [fsck] What's cooking in git.git (Feb 2009, #02; Wed, 04)
Date: Thu, 05 Feb 2009 10:42:09 +0100
Message-ID: <498AB471.1000609@viscovery.net>
References: <7vr62dk6ru.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 10:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV0lw-0003ve-8n
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 10:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbZBEJmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 04:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbZBEJmT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 04:42:19 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56730 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbZBEJmS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 04:42:18 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LV0kM-0004cy-74; Thu, 05 Feb 2009 10:42:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F053D69F; Thu,  5 Feb 2009 10:42:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vr62dk6ru.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108547>

Junio C Hamano schrieb:
> * jc/fsck (Fri Jan 30 02:44:13 2009 -0800) 5 commits
>  - fsck: revert --quick to the default and introduce --medium
>  - fsck: three levels of validation
>  - verify-pack: add --quick
>  - verify_pack(): allow a quicker verification for a pack with
>    version 2 idx
>  - pack-check.c: minor formatting fix to match coding style
> 
> I haven't heard anything positive nor negative about this series.  I think
> the tip two commits should be squashed (and perhaps the option parser
> cleaned up as suggested on the list).

If you *do* squash the top two commits due to the surprisingly expensive
--medium check level, what is the whole point of the series?

That is, if I can have a reasonably thorough check only by passing an
option to 'git fsck', then why would I want to choose --medium when I can
have --full for only a 30% higher price (according to the timings you gave)?

-- Hannes
