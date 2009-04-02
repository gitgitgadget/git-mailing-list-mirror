From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] {diff,merge}tool: rename helpers to remove them from tab-completion
Date: Thu, 2 Apr 2009 22:04:33 +0200
Message-ID: <200904022204.34019.markus.heidelberg@web.de>
References: <1238672296-10265-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:06:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpTB3-0006mt-9h
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 22:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762253AbZDBUEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 16:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbZDBUEi
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 16:04:38 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57934 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467AbZDBUEh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 16:04:37 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 598E0FC6A7EC;
	Thu,  2 Apr 2009 22:04:35 +0200 (CEST)
Received: from [89.59.93.159] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LpT9P-00026o-00; Thu, 02 Apr 2009 22:04:35 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238672296-10265-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+J1OhCUwPL1tfxIdNvck3fKcE2AaDj/+KMncf0
	wxVUME24Po9V7rVSZDKdmPICGRMLGG/JfLk26LALZzcSk2lsG8
	tFVl7YBq5GOF/h0LzRJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115492>

David Aguilar, 02.04.2009:
> diff --git a/Makefile b/Makefile
[..]
>  SCRIPT_SH += git-merge-resolve.sh
>  SCRIPT_SH += git-mergetool.sh
> -SCRIPT_SH += git-mergetool-lib.sh
> +SCRIPT_SH += git-mergetool--lib.sh
>  SCRIPT_SH += git-parse-remote.sh
>  SCRIPT_SH += git-pull.sh
>  SCRIPT_SH += git-quiltimport.sh

This conflicts with commit 496c021 (Add a script to edit/inspect notes)
in 'pu', which seems to be just merged today. If you build your patches
on top of 'da/difftool' (99511d8) instead of 'pu', then these conflicts
won't arise and avoid hassle.

In fact I already applied all your patches on top 'da/difftool' and not
'pu' all the time, until now.

Thanks for your work on this

Markus
