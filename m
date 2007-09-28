From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/4] Use parse_date_format() in revisions.c to parse the --date parameter
Date: Fri, 28 Sep 2007 19:00:23 +0100
Message-ID: <200709281900.25536.andyparkins@gmail.com>
References: <200709281516.05438.andyparkins@gmail.com> <200709281517.32030.andyparkins@gmail.com> <Pine.LNX.4.64.0709281622240.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 20:01:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbK8o-00014s-2I
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 20:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbXI1SAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbXI1SAh
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 14:00:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:49520 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbXI1SAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 14:00:35 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1524556ugc
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=bxXr36YnWM0sngRJEI5UaERYEquVfRQmHs/qfpcMMqc=;
        b=mwBOeF92YUFMmWa2n8mOIG7laNNYnnYK/2jX2JxzMykyUzPRtEAZJUwQVtyaEB3/LA8Hq3DduVdbB2A0RzigBZ5gJsbESYaYVnT2Yq6YHBYppyaSykWYHByeMiZKcMsNyIfrV9wf4IupzaWxCNpCUijsffl2pQ3hia7siEKHfW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sjoDLTz7ILfHX5kM3xODKLQUAmTzMH47mEkG2PzYoB+gZsejNndG2iZ8zRWHX+mzV32JRGcqvWIWmNOWyq/khdEVW0S9hMna0pD0qbkq7mt5fI57vMc0MAkgAQsWS8pHgGFnDuZ4J71o7MTb4kp2ky51OMxRc6fb6kB0E1aVE9E=
Received: by 10.67.105.10 with SMTP id h10mr5335901ugm.1191002432558;
        Fri, 28 Sep 2007 11:00:32 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id e1sm8539259ugf.2007.09.28.11.00.31
        (version=SSLv3 cipher=OTHER);
        Fri, 28 Sep 2007 11:00:31 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0709281622240.28395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59413>

On Friday 2007, September 28, Johannes Schindelin wrote:

> Since this is really more like a code move, 1/4 and 2/4 should be
> squashed.

I have no problem with that.

Junio: would you like a resend?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
