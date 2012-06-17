From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Sun, 17 Jun 2012 10:50:23 +0200
Message-ID: <4FDD9A4F.2060605@web.de>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org> <4FDD7AE6.6000000@web.de> <7vipeq76ke.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	vfr@lyx.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 10:50:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgBBq-0004Ye-3Y
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 10:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492Ab2FQIu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 04:50:26 -0400
Received: from mout.web.de ([212.227.17.11]:58750 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715Ab2FQIu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 04:50:26 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Lu4q2-1RxbI119iY-011dFg; Sun, 17 Jun 2012 10:50:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7vipeq76ke.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:Kg3yIxeMUFMmHKbxsi5qpqt+a3E38Bj3lYUJjm/Nlgv
 bDOnQiqB0Qd6Pxk46qJy3ku5PgdpolUjVdISWNn9M7r9JgifDT
 +K7oohOew3k+u8QSwQ+0g+/jvePxk/JtOFhKQdEvwUvcUkxbSV
 by7YmWvz+OI+IylC73DfoYb+ELRTfDeX6spBpuHOlNTa9f5bP1
 NvJYljzAZkFuYqU2HEPVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200121>


> PERL_PATH should be exported from test-lib.sh; we dot-source
> GIT-BUILD-OPTIONS to get its value, but it is not propagated to the

Thanks, that works for me.
Do you squeeze some like that onto pu?

@@ -493,6 +493,7 @@ GIT_ATTR_NOSYSTEM=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
 
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+export PERL_PATH
