From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: tig show <commit> not working anymore?
Date: Thu, 16 Sep 2010 15:59:05 +0200
Organization: ATLAS Elektronik GmbH
Message-ID: <4C9222A9.4070801@atlas-elektronik.com>
References: <20100916125337.GG5785@bowser.ece.utexas.edu> <4C922112.404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonas Fonseca <fonseca@diku.dk>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 16 15:58:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwEz5-0007Gi-V1
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 15:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab0IPN6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 09:58:34 -0400
Received: from lxsrv96.atlas.de ([194.156.172.86]:57642 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724Ab0IPN6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 09:58:34 -0400
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id AB5A71389F
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 15:58:32 +0200 (CEST)
X-AuditID: 0ac86512-00001794000005d0-d7-4c92228832ce
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 16 Sep 2010 15:58:32 +0200
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 291FA2717C;
	Thu, 16 Sep 2010 15:58:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 165E92717B;
	Thu, 16 Sep 2010 15:58:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <4C922112.404@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156334>

On 9/16/2010 3:52 PM, Michael J Gruber wrote:
> Kumar Appaiah venit, vidit, dixit 16.09.2010 14:53:
>> Hi!
>>
>> I observed that, since commit
>> 53c089443cd9885fa677becee4bf7ffd56c3c357, tig show <commit> doesn't
>> seem to work the same way as I had expected it to. The documentation
>> update doesn't seem to indicate that this was to be expected (or I
>> didn't understand it properly). Could someone please confirm that
>> tig show <commit> should actually do something similar to git show <commit> | tig ?
> 
> It seems that since that tig commit, "tig show <commit>" shows HEAD
> rather than <commit>. OTOH, "tig <commit>" does navigate to <commit>.


Oops...how true.

I tested 'tig show <commit>' and noticed it showed something but
didn't look close enough 8-|

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Never argue with a woman when she's tired, or rested.
