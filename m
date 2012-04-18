From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Wed, 18 Apr 2012 09:15:30 +0200
Message-ID: <4F8E6A12.9090708@viscovery.net>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:15:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKP77-0007QE-EY
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 09:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab2DRHPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 03:15:35 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20915 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab2DRHPf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 03:15:35 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SKP7G-0006wN-GA; Wed, 18 Apr 2012 09:15:50 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 946781660F;
	Wed, 18 Apr 2012 09:15:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195841>

Am 4/16/2012 8:44, schrieb Junio C Hamano:
> * nd/threaded-index-pack (2012-04-11) 3 commits
>  - index-pack: support multithreaded delta resolving
>  - index-pack: split second pass obj handling into own function
>  - compat/win32/pthread.h: Add an pthread_key_delete() implementation

With this series, t9300.92 (fast-import, Q: verify pack) consistently
fails for me on Windows.

I'll have to see when I can dig deeper into this topic...

-- Hannes
