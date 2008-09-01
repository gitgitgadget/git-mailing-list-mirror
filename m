From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] checkout --conflict=<style>: recreate merge in a
   non-default style
Date: Mon, 01 Sep 2008 09:52:37 +0200
Message-ID: <48BB9F45.4070509@viscovery.net>
References: <7v4p501j2y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 09:53:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka4EO-0001XI-Pw
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 09:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbYIAHwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 03:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYIAHwn
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 03:52:43 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34392 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYIAHwn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 03:52:43 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ka4DG-0003K4-7G; Mon, 01 Sep 2008 09:52:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id ECE9954D; Mon,  1 Sep 2008 09:52:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v4p501j2y.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94539>

Junio C Hamano schrieb:
> +--conflict=<style>::
> +	The same as --merge option above, but changes the way the
> +	conflicting hunks are presented, overriding the
> +	merge.conflictstyle configuration variable.  Possible values are
> +	"merge" (default) and "diff3" (in addition to what is shown by
> +	"merge" style, shows the original contents).
> +

If --conflict is basically the same as --merge, couldn't we then pass
style argument to --merge or omit it to get the default style?

-- Hannes
