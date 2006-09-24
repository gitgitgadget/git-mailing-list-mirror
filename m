From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 24 Sep 2006 11:42:24 -0700
Message-ID: <4516D190.3020608@gmail.com>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net> <4516B8A7.6010007@lsrfire.ath.cx> <Pine.LNX.4.63.0609242031410.25371@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 20:42:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRYvv-0002VV-LN
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 20:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWIXSm2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 14:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWIXSm2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 14:42:28 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:30140 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752129AbWIXSm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 14:42:27 -0400
Received: by py-out-1112.google.com with SMTP id n25so2167847pyg
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 11:42:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OR+J/4FW9WoCXmV8JP6Ytvtu07ozvC73VSlN7fAEVgybjSXz16rBAR/hjJph6gksXgbZ8iBeWYKdpAD1HmH344b/LEuqbTg9RY0fjHCaZ8BxRaRiv6Vu290FC4SSKdMOlxtKVRWrc2uvnoWdskzFPi0rO4AHTckWfkuVFH/Krl8=
Received: by 10.35.66.12 with SMTP id t12mr6543636pyk;
        Sun, 24 Sep 2006 11:42:26 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.70.66.154])
        by mx.gmail.com with ESMTP id k62sm1896413pyk.2006.09.24.11.42.25;
        Sun, 24 Sep 2006 11:42:26 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609242031410.25371@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27688>

Johannes Schindelin wrote:
[...]
> I think that this could be done very efficiently (both in terms of time 
> and size) as a "pure" builtin, i.e. something with works as
> "git tar-tree", but not as "git-tar-tree". Of course, this would break 
> scripts using the latter instead of the former. Just my 2 yinyangs.

That would be a bug. If "git foo" works, then "git-foo" should also work.
