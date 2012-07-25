From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 6/7] Remove dead code which contains bad gettext block
Date: Wed, 25 Jul 2012 06:30:09 -0500
Message-ID: <20120725113009.GA4732@burratino>
References: <cover.1343205009.git.worldhello.net@gmail.com>
 <b22ea7d7306745555bfd39bf4ff51f485a005a02.1343205009.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 13:30:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StznN-00023c-1d
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 13:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403Ab2GYLaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 07:30:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42091 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab2GYLaR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 07:30:17 -0400
Received: by yhmm54 with SMTP id m54so553381yhm.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rD8R4W7WS4GZXZEY/GBYw9pu88uAmG+sPC5+3LWknUo=;
        b=YDxlWDoFDZyabepYIwFHUFbG99U1DOWp6FW2kDDb2OSKxIY7W7rpo9dG36XjAKP6UE
         WCyEHhvmbm/skJUjsId+3hDNXxazx/6ngycCpDA5hgGC1wI880daR9uHecQLpq0Fai/2
         PPIik/JjomF+gU/M6N56sTFJPsda2MbyipqP9eyQg6IbmJvbIfe/WSDrs4j/uYhmZ2n2
         A8x2w+LGHisLfjjhqCYPg040EnfzVtHQY1w9jdWo97ENAlGD+k+ZJPiUpHmGgfOATz5m
         VVVAanUKrOMaTiAPEk/2XkQzv/w8WRTgz7CewJCBnspCvQXLRmyCMk+Exl1/AMKFgr0p
         HoCg==
Received: by 10.42.70.136 with SMTP id f8mr24033475icj.28.1343215817310;
        Wed, 25 Jul 2012 04:30:17 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id qo3sm2066367igc.8.2012.07.25.04.30.16
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 04:30:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b22ea7d7306745555bfd39bf4ff51f485a005a02.1343205009.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202148>

Jiang Xin wrote:

> Found this dead code when I examine gettext messages in shell scripts
> start with dash ('-' or '--'). An error will be raised for this case,
> like:
>
>     $ gettext "-d option is no longer supported.  Do not use."
>     gettext: missing arguments
>
> Indead, this code has been left as dead for a long time, as Junathan
> points out:

s/Junathan/Jonathan/, please, unless you are trying to say that both
Junio and I pointed it out at the same time.
