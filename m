From: Cord Seele <cowose@googlemail.com>
Subject: Re: [PATCH 2/2] use new Git::config_path() for aliasesfile
Date: Fri, 30 Sep 2011 23:16:33 +0200
Message-ID: <20110930211633.GE13435@laptop>
References: <vpqty7wk9km.fsf@bauges.imag.fr>
 <1317379945-9355-1-git-send-email-cowose@gmail.com>
 <1317379945-9355-3-git-send-email-cowose@gmail.com>
 <7vsjndoldq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 23:16:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9kRw-0007UW-5g
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 23:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656Ab1I3VQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 17:16:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47119 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756316Ab1I3VQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 17:16:37 -0400
Received: by fxe4 with SMTP id 4so3367660fxe.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CsPyQ6aQlpYEFuqh+C1hDwidAu6loWxl3+hmO0jSNnM=;
        b=t/43qgF/zoTn3oPrICKqZh6KGl42R1bUV3PhE2RmqqaRLkHVzZV8ySjUenMps2vTkf
         lAFDrM6pSTEviqZFfuAwgzpt5OxYrMs+oYFm3eRCTxkR9GX0je6LJKachjZno1T5J4vB
         bCcZqPJXhwp7NZfQ+FdnUzNlS0qVHrbsmpiF8=
Received: by 10.223.18.73 with SMTP id v9mr2846144faa.70.1317417396606;
        Fri, 30 Sep 2011 14:16:36 -0700 (PDT)
Received: from laptop (p4FF1A78A.dip.t-dialin.net. [79.241.167.138])
        by mx.google.com with ESMTPS id c5sm8381878fai.2.2011.09.30.14.16.34
        (version=SSLv3 cipher=OTHER);
        Fri, 30 Sep 2011 14:16:35 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <7vsjndoldq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182510>

On Fri 30 Sep 2011 12:55:45 -0700, Junio C Hamano <gitster@pobox.com> wrote:

> I think the addition of "config --path" support is a good idea, but the
> resulting code suffers from too many cut&paste cruft across the config*
> family of methods.
> 
> How about doing a bit of refactoring, perhaps something like this, on top
> as a separate patch?

Sound very reasonable to me - unfortunately it's beyond my perl-scope to be of
much help here.

-- Cord
