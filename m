From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 09:54:08 +0200
Message-ID: <48859220.6080509@viscovery.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <48858D95.7060409@viscovery.net> <20080722074632.GA3999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCiG-0007O9-0z
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbYGVHyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYGVHyN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:54:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22894 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbYGVHyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:54:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KLChF-0003rs-FK; Tue, 22 Jul 2008 09:54:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 209236D9; Tue, 22 Jul 2008 09:54:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080722074632.GA3999@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89467>

Jeff King schrieb:
> On Tue, Jul 22, 2008 at 09:34:45AM +0200, Johannes Sixt wrote:
> 
>>> -		{ "diff-files", cmd_diff_files, RUN_SETUP },
>>> +		{ "diff-files", cmd_diff_files, RUN_SETUP | FORBID_PAGER },
>> Every now and then I want to use 'git -p diff-files', and I think that is
>> a valid use-case. But your suggested patch seems to forbid the pager even
>> in this case. :-(
> 
> Actually, it doesn't. If you read earlier in the message, this applies
> only to pager.* config. That being said, I think Junio's ultimate goal
> was to not allow stupid people to accidentally set the pager on
> plumbing, at the expense of any smart people who might want to do it for
> a good reason.
> 
> Though I have to wonder why "git diff --raw" is not enough for you.

Usually, I use plumbing with a pager while I'm writing or debugging a
script, and I'm studying its output. So, no, I'm not interested in "git
diff --raw". ;)

-- Hannes
