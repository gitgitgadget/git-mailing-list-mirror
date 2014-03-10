From: Nemina Amarasinghe <neminaa@gmail.com>
Subject: Re: [PATCH] simplified the chain if() statements of  =?utf-8?b?aW5zdGFsbF9icmFuY2hfY29uZmlnKCk=?= function in branch.c
Date: Mon, 10 Mar 2014 08:51:05 +0000 (UTC)
Message-ID: <loom.20140310T094407-5@post.gmane.org>
References: <loom.20140310T083649-236@post.gmane.org> <loom.20140310T085652-521@post.gmane.org> <vpqd2huihsc.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 09:51:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMvvs-00016f-CA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 09:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbaCJIvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 04:51:32 -0400
Received: from plane.gmane.org ([80.91.229.3]:42193 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbaCJIvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 04:51:31 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WMvvm-00011k-8W
	for git@vger.kernel.org; Mon, 10 Mar 2014 09:51:30 +0100
Received: from 61.245.163.2 ([61.245.163.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 09:51:30 +0100
Received: from neminaa by 61.245.163.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Mar 2014 09:51:30 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 61.245.163.2 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243716>

> 
> Nemina Amarasinghe <neminaa <at> gmail.com> writes:
> 
> Is it me, or is (origin || !origin) a tautology?
> 
Thanks for the advices Matthieu. I will go through the documentations again. 
Is there anything wrong with my logic? 
What I wanted to express is
((!remote_is_branch && origin) || (!remote_is_branch || !origin))
