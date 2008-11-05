From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: let git-diff allow patch to delete empty files?
Date: Thu, 06 Nov 2008 06:09:40 +0900
Message-ID: <20081106060940.6117@nanako3.lavabit.com>
References: <49118FEE.30408@liddicott.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Sam Liddicott" <sam@liddicott.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 22:11:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxpf3-00024L-69
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 22:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbYKEVKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 16:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbYKEVKR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 16:10:17 -0500
Received: from karen.lavabit.com ([72.249.41.33]:58605 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbYKEVKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 16:10:16 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 3867CC8406;
	Wed,  5 Nov 2008 15:10:13 -0600 (CST)
Received: from 3880.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id ONTTGVXF04YT; Wed, 05 Nov 2008 15:10:13 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=aHc0JCY5Jo7Xbk65QbhzGMyWMcHobjsasqdKmYZaKJXziUyI4CG4aSOh/vKFH02VGDlUn2A5f6S0PhIQUNw7apwvxrokJmEawedR2xzyAvp7eCFw5se/QOwvbhdy7ity0kh4t16R2Tab8rx0fMDXxb3WKB67sCU8bVYKQ5mBmxE=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <49118FEE.30408@liddicott.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100184>

Quoting "Sam Liddicott" <sam@liddicott.com>:

> In some cases "patch" cannot apply diff's generated using git-diff, I've
> had a "git diff" output look like this when an empty file was removed as
> the only change:

Even if you do not use git to manage your changes, you can use "git apply" from outside of a git repository as a replacement for "patch".

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
