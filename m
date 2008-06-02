From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Development strategy
Date: Tue, 03 Jun 2008 00:36:44 +0200
Message-ID: <484475FC.8020804@gmail.com>
References: <48441715.4010507@gmail.com> <bd6139dc0806021130p2cc442a3qfe9c00681fdb05e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@eaglescrag.net>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 03 00:37:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Ieq-0003u9-EX
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 00:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbYFBWgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbYFBWgs
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 18:36:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:33703 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbYFBWgr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 18:36:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so859095fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 15:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=KO1OHG5wsPHhRPhjl9wynRzvzygtzHFS2egPtJE4Jew=;
        b=lS39lWPnWcEz1icqqfXn6TbWXYtEhxnIiSl3xTxYSLbLiYdewNihaiZ8NOH7LYSAkep5sDriYxe1xffaRcCtkh0g2Coj4xZ+vzJRYv80o+obAvQqgDD+rUlEsquztwsL9ocFe206HYeSF9egP3yhJNUa9dNMm4z3bvqD9FMN6to=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=xLTmeKodyzFLlI+pETUaoe+X7Ck8t20r49bWd5Y7H6aS9QXOvTlBHgyrn39X0dLO6ETazo/Fjs/tsCV9hCdskmCWfSStqL1yfAWiA7gLV2eu/VxxJFjrQZisYfHfEpJvKZVTmEb3FLD4gQzmTgo0d6bOvqcnK7Kjzjtko8xHEdU=
Received: by 10.86.89.1 with SMTP id m1mr4710058fgb.20.1212446205696;
        Mon, 02 Jun 2008 15:36:45 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.231.153])
        by mx.google.com with ESMTPS id f31sm11700337fkf.5.2008.06.02.15.36.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 15:36:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <bd6139dc0806021130p2cc442a3qfe9c00681fdb05e3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83587>

Sverre Rabbelier wrote:
> Keep your commit strategy as is [with small commits],
> and create a branch whenever you want review and in that branch you
> squash the commits as appropriate

Are you suggesting that the squashed patches get merged, or that the 
squashed patches get reviewed but the finer-granulated patches get 
merged?  In the former case, I'd probably prefer to work with larger 
patches in the first place (and not just squash them on the review 
branch), since they are easier to handle -- e.g. I sometimes need to go 
back and change things in earlier commits, and in those cases larger 
commits are easier.

-- Lea
