From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/4] remote show/prune improvement
Date: Tue, 10 Jun 2008 08:09:31 -0700 (PDT)
Message-ID: <m3ej75pbrw.fsf@localhost.localdomain>
References: <7vd4mqdrhi.fsf@gitster.siamese.dyndns.org>
	<1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:10:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65UV-0003WZ-25
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 17:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbYFJPJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 11:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbYFJPJi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 11:09:38 -0400
Received: from gv-out-0910.google.com ([216.239.58.184]:6373 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYFJPJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 11:09:37 -0400
Received: by gv-out-0910.google.com with SMTP id e6so623277gvc.37
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=5HIqX1Os+jFmjZ337KVPhMRyiIXwW15sY2sl4/8OylE=;
        b=w+RCeVJnJ5d2S3SrvjSgK4o6+PLIFEVRMfkvpAbpkCOb48gETlf21hDLIbGMccgbH/
         F1w/qLAsiqrpNlqLYzJAxiLAQ4Hf21LaaFG+YVeyvHo83P5O1/fbKi1x9qtC+OwX2i29
         wl9NV194wiYUaevW9wW/FmSd5WdLBSh68a668=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=A+VVEbXY3pRQZyzXD6ojeP4KeIlWKCjJeBciu/zn7/ry5NkZbvm7lkAyUyQBG6iUP9
         PSy+ACP++DHOmm9yoOZ8wp6LTaFvQm1Rtw4N6/duDf8sOTj7djkezQJZq+TuP0hoW118
         OPtiSdElLS/mgZjt2BQq2dcpLCiajIRRXepo0=
Received: by 10.78.130.14 with SMTP id c14mr2736206hud.105.1213110573013;
        Tue, 10 Jun 2008 08:09:33 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.192.165])
        by mx.google.com with ESMTPS id 32sm15250826hui.33.2008.06.10.08.09.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 08:09:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5AF9PEN031121;
	Tue, 10 Jun 2008 17:09:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5AF9NMg031118;
	Tue, 10 Jun 2008 17:09:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84515>

Olivier Marin <dkr+ml.git@free.fr> writes:

> 
>   [1/4] remote show: fix the -n option
>   [2/4] builtin-remote: split show_or_prune() in two separate functions.
>   [3/4] remote prune: print the list of pruned branches
>   [4/4] remote show: list tracked remote branches with -n.
> 
>  Documentation/git-remote.txt |    9 +--
>  builtin-remote.c             |  160 ++++++++++++++++++++++++++++++------------

I like this series... but the [4/4] lacks documentation (all other
patches update documentation).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
