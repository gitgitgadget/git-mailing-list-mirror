From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Repo with only one file
Date: Fri, 09 Aug 2013 12:32:38 +0200
Message-ID: <5204C546.1030502@viscovery.net>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com> <520224E0.5060206@viscovery.net> <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com> <CABURp0o_07HdB2o0knPABtAiiuHQ6-fYgemvdCYOsdSghO7v1w@mail.gmail.com> <52048B5B.5060009@viscovery.net> <CAH_OBicF3xn8+MsKH0nTg-HnPg58T-TWHW20r7GqXOm3Nbutfg@mail.gmail.com> <52049121.2080604@viscovery.net> <CAH_OBifYFyVVo_OEfniWJE=0peX+UPLkRznqyQzvO4gGGLu_tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 12:32:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7jzy-00015q-Q0
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 12:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966769Ab3HIKcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 06:32:43 -0400
Received: from so.liwest.at ([212.33.55.14]:25970 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966522Ab3HIKcm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 06:32:42 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1V7jzr-0007vK-4n; Fri, 09 Aug 2013 12:32:39 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D9E661660F;
	Fri,  9 Aug 2013 12:32:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CAH_OBifYFyVVo_OEfniWJE=0peX+UPLkRznqyQzvO4gGGLu_tQ@mail.gmail.com>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231968>

Am 8/9/2013 12:03, schrieb shawn wilson:
> The question still stands though - why is that unassociated commit left there?

Because your command did not remove it. filter-branch does not know that
it is "unassociated" when you ask it to follow all commits beginning at
HEAD. But when you say 'HEAD -- webban.pl', you ask it to follow only
commits that touch webban.pl, which automatically skips that commit.

-- Hannes
