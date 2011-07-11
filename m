From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 26/48] merge-recursive: Allow make_room_for_path() to
 remove D/F entries
Date: Mon, 11 Jul 2011 09:14:47 +0200
Message-ID: <4E1AA2E7.5020301@viscovery.net>
References: <1307518278-23814-1-git-send-email-newren@gmail.com> <1307518278-23814-27-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 09:16:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgAin-0002qQ-Gm
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 09:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203Ab1GKHOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 03:14:50 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37885 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067Ab1GKHOu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 03:14:50 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QgAhc-0004Qo-4T; Mon, 11 Jul 2011 09:14:48 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D91491660F;
	Mon, 11 Jul 2011 09:14:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <1307518278-23814-27-git-send-email-newren@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176835>

Am 6/8/2011 9:30, schrieb Elijah Newren:
> diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
> index 423fb62..dea2a65 100755
> --- a/t/t6036-recursive-corner-cases.sh
> +++ b/t/t6036-recursive-corner-cases.sh
> @@ -477,7 +477,7 @@ test_expect_success 'setup differently handled merges of directory/file conflict
>  	git tag E2
>  '
>  
> -test_expect_failure 'git detects conflict and handles merge of D & E1 correctly' '
> +test_expect_success 'git detects conflict and handles merge of D & E1 correctly' '
>  	git reset --hard &&
>  	git reset --hard &&
>  	git clean -fdqx &&

This fails on Windows, very likely for the same reason as t6020 that I
posted earlier: the message "Removing a... to make room..." is missing as
well.

-- Hannes
