From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Wed, 30 Nov 2011 14:55:53 +0000 (UTC)
Message-ID: <loom.20111130T155409-599@post.gmane.org>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 15:56:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVla2-0007rt-Vg
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 15:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab1K3O4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 09:56:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:33243 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042Ab1K3O4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 09:56:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RVlZu-0007mb-LF
	for git@vger.kernel.org; Wed, 30 Nov 2011 15:56:06 +0100
Received: from 57.79.130.188 ([57.79.130.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 15:56:06 +0100
Received: from vitor.hda by 57.79.130.188 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 15:56:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 57.79.130.188 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20100101 Firefox/8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186126>

Luke Diamand <luke <at> diamand.org> writes:

> In adding the test case for labels I also found and fixed a few other
> small bugs in the label handling:
> 
>  - labels missing a description or "EOT" in their text cause problems;
>  - labels without an owner cause problems.
> 
> I also noticed, but did not fix, that you can't have more than one label
> per commit (the others are silently dropped) and the documentation for
> branch import could be improved. I've added a (failing) test case for
> the multiple label problem.

Hi Luke,

Seeing that you have some experience using labels, could I kindly ask you to
include some description of it in git-p4.txt?

Thanks,
Vitor
