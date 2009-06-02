From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCHv3 (resend) 0/4] git-am foreign patch support
Date: Tue, 02 Jun 2009 19:56:08 +0900
Message-ID: <20090602195608.6117@nanako3.lavabit.com>
References: <1243897841-8923-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 12:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBRfY-0006BY-3P
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 12:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913AbZFBK4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 06:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757340AbZFBK4P
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 06:56:15 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35043 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756814AbZFBK4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 06:56:14 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 512F411B8D2;
	Tue,  2 Jun 2009 05:56:16 -0500 (CDT)
Received: from 4886.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id KABGWDWMGLO2; Tue, 02 Jun 2009 05:56:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=POr6PSmFJfBj1hZ0JObFhsmCYScQbddg0a2kEDkmTMO7MuGcWjfFXPgTi22EkkyWSgCisympf33IWlqHX03eYuG/lrsKbSqMNkZcmHOIfbkXPrQAkMnX1l/9Tbze4r8IntIN333LfInN3jfCFDNVNAbni5Qv00UrjaBfVsaurqA=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1243897841-8923-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120503>

Quoting Giuseppe Bilotta <giuseppe.bilotta@gmail.com>:

> Junio mentioned that he's ready to apply the series cleanly, so here's
> a resend rebased on latest 'next' and without any 'bis' patches ;-)
>
> Giuseppe Bilotta (4):
>   git-am foreign patch support: introduce patch_format
>   git-am foreign patch support: autodetect some patch formats
>   git-am foreign patch support: StGIT support
>   git-am: refactor 'cleaning up and aborting'
>
>  git-am.sh |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 129 insertions(+), 4 deletions(-)

May we have a summary of what's updated, compared to the version that has been in the "pu" branch?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
