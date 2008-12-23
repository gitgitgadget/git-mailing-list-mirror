From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git merge conflicts and encoding of logs
Date: Tue, 23 Dec 2008 09:41:06 +0100
Message-ID: <4950A422.5030100@viscovery.net>
References: <87lju7h4yb.dancerj%dancer@netfort.gr.jp> <7vprjjfgi7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: Junichi Uekawa <dancer@netfort.gr.jp>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 09:42:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF2qX-00006S-08
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 09:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbYLWIlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 03:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbYLWIlO
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 03:41:14 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49251 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYLWIlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 03:41:14 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LF2p9-0002DG-AW; Tue, 23 Dec 2008 09:41:07 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F05C054D; Tue, 23 Dec 2008 09:41:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vprjjfgi7.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103805>

Junio C Hamano schrieb:
> <<<<<<< HEAD:foo
> これはサイドブランチの変更です。
> やはり JIS コードで書いてます。
> =======
> 日本語のファイルです。
> JIS コードで書いてます。
>>>>>>>> master:foo
> 
> The above will probably come out as UTF-8 in this mail text, but the point
> is that the confict side markers do not have anything but filename and the
> branch name.  I am still scratching my head trying to see where in the
> merge-recursive codepath you got snippet of log message.

Try rebase -i instead of merge: This should put summary lines onto the
conflict markers.

-- Hannes
