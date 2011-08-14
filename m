From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4 0/2] push limitations
Date: Sun, 14 Aug 2011 19:29:49 +0200
Message-ID: <4E48060D.9010106@web.de>
References: <1313312262-2460-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, gitster@pobox.com,
	hvoigt@hvoigt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 19:31:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QseWz-0005UD-W0
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 19:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab1HNR3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 13:29:52 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:52247 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355Ab1HNR3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 13:29:51 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 07F7B1A8AA819;
	Sun, 14 Aug 2011 19:29:50 +0200 (CEST)
Received: from [79.247.252.183] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QseVR-0001Zf-00; Sun, 14 Aug 2011 19:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1313312262-2460-1-git-send-email-iveqy@iveqy.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19PDTIY1BcPCvVIVFGDsATWicz/AirlSrhVN2YK
	jGxLiJm49V97CkNtYu4Ffhuoe2HVUJHputyn7SuVRkZrXgXUSl
	XzB5Wi25MNhaSIX3z4lQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179337>

Please ignore this series, it slipped through by accident.

Am 14.08.2011 10:57, schrieb Fredrik Gustafsson:
> The first iteration of this patch series can be found here:
> http://thread.gmane.org/gmane.comp.version-control.git/176328/focus=176327
> 
> The second iteration of this patch series can be found here:
> http://thread.gmane.org/gmane.comp.version-control.git/177992
> 
> The third iteration of this patch series can be found here:
> http://thread.gmane.org/gmane.comp.version-control.git/179037/focus=179048
> 
> 
> Fredrik Gustafsson (2):
>   rev-parse: add option --is-well-formed-git-dir [path]
>   push: Don't push a repository with unpushed submodules
> 
>  Documentation/git-push.txt      |    6 ++
>  Documentation/git-rev-parse.txt |    4 ++
>  builtin/push.c                  |   17 ++++++
>  builtin/rev-parse.c             |    8 +++
>  cache.h                         |    1 +
>  combine-diff.c                  |    2 +-
>  setup.c                         |    7 +++
>  submodule.c                     |  108 +++++++++++++++++++++++++++++++++++++++
>  submodule.h                     |    1 +
>  t/t5531-deep-submodule-push.sh  |   94 ++++++++++++++++++++++++++++++++++
>  t/t7400-submodule-basic.sh      |    4 +-
>  t/t7403-submodule-sync.sh       |    5 +-
>  t/t7407-submodule-foreach.sh    |   97 ++++++++++++++++++-----------------
>  transport.c                     |    9 +++
>  transport.h                     |    1 +
>  15 files changed, 312 insertions(+), 52 deletions(-)
> 
