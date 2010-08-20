From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: wishlist bugreport: make limit configurable for do_fmt_merge_msg
 (merge.log)
Date: Fri, 20 Aug 2010 11:29:58 +0200
Message-ID: <4C6E4B16.2060308@viscovery.net>
References: <20100820020127.GG22469@onerussian.com> <20100820064741.GC12794@kytes> <20100820081641.GA32127@burratino> <4C6E468F.3000800@viscovery.net> <20100820091925.GE12794@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 11:30:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmNvL-0008SS-CZ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 11:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab0HTJaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 05:30:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39548 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751210Ab0HTJaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 05:30:00 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OmNvC-00069b-Ta; Fri, 20 Aug 2010 11:29:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A342B1660F;
	Fri, 20 Aug 2010 11:29:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100820091925.GE12794@kytes>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153991>

Am 8/20/2010 11:19, schrieb Ramkumar Ramachandra:
> I'll use git_config_bool_or_int for this -- we've traded off the
> ability to say "infinite" though.

I don't miss it. But can we still write in the config file

  [merge]
     log

as a short-hand for

  [merge]
     log = true

? If *that* were not possible anymore, it would be a regression.

-- Hannes
