From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Migrating SVN to Git, and preserve merge information
Date: Wed, 11 Apr 2012 18:58:31 +0100
Message-ID: <4F85C647.9070302@pileofstuff.org>
References: <4F844F33.5000004@nekoconeko.nl> <4F84BAE2.5090803@pileofstuff.org> <4F8531B3.9030501@nekoconeko.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nick Douma <n.douma@nekoconeko.nl>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:58:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1oh-000611-8d
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735Ab2DKR6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 13:58:40 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:49359 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759508Ab2DKR6h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 13:58:37 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120411175833.BWMH3740.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Wed, 11 Apr 2012 18:58:33 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120411175833.YGQP3795.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Wed, 11 Apr 2012 18:58:33 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <4F8531B3.9030501@nekoconeko.nl>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=5phNfFoJZtEA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=dt9guxH6Fz0ikZnW8o4A:9 a=mKLjzhupfmbVM9idrfwA:7 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195226>

Thanks Nick for the outline - the main thing I take from this is that
"unmerge" is used in real world revision messages, so it's important for
me to test that any regexp does the right thing there.

It sounds like grafts aren't the right solution for your problem.  I
can't really suggest much without a better understanding of what you're
trying to achieve, but you might be interested in `git cherry`, which
tries to detect cherry-picked commits by comparing the diffs.

	- Andrew
