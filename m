From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Aug 2008, #05; Tue, 19)
Date: Tue, 19 Aug 2008 13:02:07 +0200
Message-ID: <48AAA82F.9060500@viscovery.net>
References: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 13:03:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVOze-0006rv-37
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 13:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbYHSLCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 07:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbYHSLCM
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 07:02:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61959 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbYHSLCL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 07:02:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KVOyV-0003vN-Sw; Tue, 19 Aug 2008 13:02:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8566F4FB; Tue, 19 Aug 2008 13:02:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vpro5cr2x.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92846>

Junio C Hamano schrieb:
> * js/mingw-stat (Mon Aug 18 22:01:06 2008 +0200) 2 commits
>  - Revert "Windows: Use a customized struct stat that also has the
>    st_blocks member."
>  - compat: introduce on_disk_bytes()
> 
> This gets rid of use of st_blocks member (which is XSI but not POSIX
> proper), which was originally prompted by recent Haiku port but it turns
> out MinGW has the same issue as well.  Queued on 'pu' just to have a
> chance to make sure I munged the version j6t sent me correctly before
> merging it upwards.

I tested this again, and it works as expected.

-- Hannes
