From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: don't convert - delimiter to .'s
Date: Wed, 11 Jul 2007 12:49:54 +0200
Organization: At home
Message-ID: <f72cki$ke6$2@sea.gmane.org>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz> <11831937813223-git-send-email-sam.vilain@catalyst.net.nz> <11831937822346-git-send-email-sam.vilain@catalyst.net.nz> <11831937823184-git-send-email-sam.vilain@catalyst.net.nz> <11831937823982-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 12:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8Zlt-0005ej-Il
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 12:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760044AbXGKKuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 06:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760286AbXGKKuM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 06:50:12 -0400
Received: from main.gmane.org ([80.91.229.2]:51406 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760044AbXGKKuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 06:50:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1I8Zli-00040P-IW
	for git@vger.kernel.org; Wed, 11 Jul 2007 12:50:02 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 12:50:02 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 12:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52150>

Sam Vilain wrote:

> Otherwise, a custom "v1.5.2.42.gb1ff" is considered newer than a
> "v1.5.2.1.69.gcafe"

Wouldn't it be better to do what tig did, namely put the extra part,
i.e. the number of commits since tagged revision and shortened sha1 into
REVISION rather than VERSION for an rpm for example?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
