From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: wishlist bugreport: make limit configurable for do_fmt_merge_msg
 (merge.log)
Date: Fri, 20 Aug 2010 11:10:39 +0200
Message-ID: <4C6E468F.3000800@viscovery.net>
References: <20100820020127.GG22469@onerussian.com> <20100820064741.GC12794@kytes> <20100820081641.GA32127@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 11:10:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmNcf-0000Mt-Ag
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 11:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab0HTJKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 05:10:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21574 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0HTJKn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 05:10:43 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OmNcV-0003Fy-Om; Fri, 20 Aug 2010 11:10:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 80F241660F;
	Fri, 20 Aug 2010 11:10:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100820081641.GA32127@burratino>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153987>

Am 8/20/2010 10:16, schrieb Jonathan Nieder:
> This also provides --log-limit=0 / "[merge] loglimit = 0" to not limit
> the number of commits summarized at all, which I would expect to
...
>  [verse]
> -'git fmt-merge-msg' [--log | --no-log] <$GIT_DIR/FETCH_HEAD
> -'git fmt-merge-msg' [--log | --no-log] -F <file>
> +'git fmt-merge-msg' [--log | --no-log] [--log-limit=<n>] <$GIT_DIR/FETCH_HEAD
> +'git fmt-merge-msg' [--log | --no-log] [--log-limit=<n>] -F <file>

Do we need --log-limit? Why not just --log=42 and --no-log equals --log=0?

Ditto for the config option:

  merge.log=42
  merge.log=0

and for backwards compatibility:

  merge.log=false  ===  merge.log=0
  merge.log=true   ===  merge.log=20

-- Hannes
