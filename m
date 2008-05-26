From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: how to union 2 repos
Date: Mon, 26 May 2008 13:10:42 +0200
Message-ID: <483A9AB2.706@viscovery.net>
References: <1211796504.20622.26.camel@bee.datamax.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jamil Djadala <djadala@datamax.bg>
X-From: git-owner@vger.kernel.org Mon May 26 13:12:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0ac5-0005X2-SU
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 13:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbYEZLKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 07:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbYEZLKq
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 07:10:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13947 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbYEZLKp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 07:10:45 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K0abD-0003bE-7L; Mon, 26 May 2008 13:10:43 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 04DF4AFCC; Mon, 26 May 2008 13:10:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1211796504.20622.26.camel@bee.datamax.bg>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82921>

Jamil Djadala schrieb:
> i have 2 repos with history, assuming initial commit in both repos are
> same:
> 
> 1:
> a-b-c-d-e-f
> 2:
> a-B-C-D-E-F
> 
> 
> i want repository with this history:
> 
> a-b-c-d-e-f
>  \B-C-D-E-F

$ git fetch ../other master:otherMaster
$ echo $B $a > .git/info/grafts
$ git filter-branch -- --all

The man page of git-filter-branch mentions the grafts trick.

-- Hannes
