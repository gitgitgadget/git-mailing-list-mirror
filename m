From: Johannes Sixt <j.sixt@telecom.at>
Subject: Re: [PATCH] git-filter-branch: more detailed USAGE
Date: Thu, 30 Aug 2007 18:20:53 +0200
Message-ID: <46D6EE65.3040503@telecom.at>
References: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 18:56:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQnJ8-00048Y-Dz
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 18:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbXH3QzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 12:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbXH3QzS
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 12:55:18 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31374 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197AbXH3QzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 12:55:16 -0400
X-Greylist: delayed 2009 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2007 12:55:16 EDT
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@telecom.at>)
	id 1IQmm4-000404-1S; Thu, 30 Aug 2007 18:21:42 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 07AEB81C1; Thu, 30 Aug 2007 18:21:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57052>

Giuseppe Bilotta schrieb:
> -USAGE="git-filter-branch [-d TEMPDIR] [FILTERS] [REV-RANGE]"
> +USAGE="[-d <tempdir>] \
> +[--env-filter <command>] \
> +[--tree-filter <command>] \
> +[--index-filter <command>] \
> +[--parent-filter <command>] \
> +[--msg-filter <command>] \
> +[--commit-filter <command>] \
> +[--tag-name-filter <command>] \
> +[--subdirectory-filter <command>] \

+[--subdirectory-filter <directory>] \

> +[--original <namespace>] [rev-range]"

-- Hannes
