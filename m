From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 7/8] Use test_set_editor in t9001-send-email.sh
Date: Wed, 09 Apr 2008 09:01:31 +0200
Message-ID: <47FC69CB.1080400@viscovery.net>
References: <> <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <1207704604-30393-2-git-send-email-bdonlan@fushizen.net> <1207704604-30393-3-git-send-email-bdonlan@fushizen.net> <1207704604-30393-4-git-send-email-bdonlan@fushizen.net> <1207704604-30393-5-git-send-email-bdonlan@fushizen.net> <1207704604-30393-6-git-send-email-bdonlan@fushizen.net> <1207704604-30393-7-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 09:02:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjUK1-00056w-S2
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 09:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbYDIHBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 03:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbYDIHBe
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 03:01:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8784 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbYDIHBd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 03:01:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JjUJH-0005qi-UV; Wed, 09 Apr 2008 09:01:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BFC4F546; Wed,  9 Apr 2008 09:01:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1207704604-30393-7-git-send-email-bdonlan@fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79083>

Bryan Donlan schrieb:
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 030f66c..0a65785 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -144,10 +144,7 @@ test_expect_success 'setup fake editor' '
>  	chmod +x fake-editor
>  '
>  
> -FAKE_EDITOR="$(pwd)/fake-editor"
> -export FAKE_EDITOR
> -GIT_EDITOR='"$FAKE_EDITOR"'
> -export GIT_EDITOR
> +test_set_editor "$(pwd)/fake-editor"
>  
>  test_expect_success '--compose works' '
>  	clean_fake_sendmail &&

I'd squash this into 5/8 or 8/8. Dunno.

-- Hannes
