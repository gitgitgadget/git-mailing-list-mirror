From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH/RFC] introduce GIT_WORK_TREE environment variable
Date: Wed, 28 Mar 2007 17:45:35 +0200
Organization: eudaptics software gmbh
Message-ID: <460A8D9F.75323F65@eudaptics.com>
References: <20070328141505.GA16600@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 17:45:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWaLJ-0006pH-3o
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 17:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbXC1Ppc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 11:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbXC1Ppc
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 11:45:32 -0400
Received: from main.gmane.org ([80.91.229.2]:56955 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932468AbXC1Ppb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 11:45:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HWaKz-0007jT-AX
	for git@vger.kernel.org; Wed, 28 Mar 2007 17:45:25 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 17:45:25 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 17:45:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43377>

Matthias Lederhofer wrote:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index c075474..77c6d23 100755
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -25,6 +25,7 @@ GIT_COMMITTER_EMAIL=committer@example.com
>  GIT_COMMITTER_NAME='C O Mitter'
>  unset GIT_DIFF_OPTS
>  unset GIT_DIR
> +unset GIT_WORK_TREE
>  unset GIT_EXTERNAL_DIFF
>  unset GIT_INDEX_FILE
>  unset GIT_OBJECT_DIRECTORY

connect.c:git_connect() unsets some environment variables, most
prominently GIT_DIR; I think it should also unset GIT_WORK_TREE.

-- Hannes
