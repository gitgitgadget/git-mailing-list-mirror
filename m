From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: html page display via cgit
Date: Wed, 01 Sep 2010 12:23:29 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4C7E29A1.8020304@atlas-elektronik.com>
References: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Shivdas Gujare <shivdas.tech@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 12:23:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqkTc-0000Lt-N5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 12:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab0IAKX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 06:23:27 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:38889 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752379Ab0IAKX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 06:23:26 -0400
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id E2070138AD
	for <git@vger.kernel.org>; Wed,  1 Sep 2010 12:23:24 +0200 (CEST)
X-AuditID: 0ac86512-00001794000005d0-1e-4c7e299c4ab2
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 1 Sep 2010 12:23:24 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 34FF82717A;
	Wed,  1 Sep 2010 12:23:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 208842716A;
	Wed,  1 Sep 2010 12:23:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155033>

On 9/1/2010 11:32 AM, Shivdas Gujare wrote:
> Hi All,
> 
> I hope, this is the right mailing list for cgit as well.
> I am trying to add some "html logs" inside cgit, but I can't open
> these logs via cgit inside firefox, i.e. cgit open every files in
> "plain" format,
> would like to know if it is possible to open "html" pages inside cgit
> so that if I click on html page added into git, it opens in html and
> not in plain format.

Set this in /etc/cgitrc

mimetype.gif=image/gif
mimetype.html=text/html
mimetype.jpg=image/jpeg
mimetype.jpeg=image/jpeg
mimetype.pdf=application/pdf
mimetype.png=image/png
mimetype.svg=image/svg+xml

HTH

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Don't stop posting, a good laugh breaks up my day nicely
