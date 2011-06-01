From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git annotate with date option not working?
Date: Wed, 01 Jun 2011 02:40:51 -0700 (PDT)
Message-ID: <m3aae1yjnm.fsf@localhost.localdomain>
References: <4DE5F655.9020400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chengwei Ding <waterding@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 11:41:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRhvD-00074a-FS
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 11:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049Ab1FAJk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 05:40:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39481 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861Ab1FAJk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 05:40:56 -0400
Received: by bwz15 with SMTP id 15so4375133bwz.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=lAXrld0SF4oIgPaOzc0S6kI3wRhx0mk6oui6aYPu9xQ=;
        b=s/9+fu1sDIEaFrmsso28SbeFKrP2Cc9FmJBxtmmc3mS0bZlNOsFgMV4fz9pQ3psS4x
         ko0OMSOEwm/CZgMYDJhnefylaGEXmIDiE6FHrmeGLbTrHoNEFAWpgKO3EDAyzI0ANZYK
         DYzFRFdnNL5jOU9mcYD7y4ykfIpfWBOyDgDPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=d1aTHrDVClJ2rkAXryF6neT4WzDDsEW1aQ/BKx6URnJmUTUwl66Bqq9FOBXu8K91+/
         D/7nHzkRjdhyzSKopGYT5OENz98ekc0KOQwS01XIi9v0VJNmGUCOApbgd2ucM7ILDc70
         2flI/oLoJDiPR6ZPu0kZiCKhXVDbYPkmgbO/4=
Received: by 10.204.83.212 with SMTP id g20mr1921382bkl.55.1306921254422;
        Wed, 01 Jun 2011 02:40:54 -0700 (PDT)
Received: from localhost.localdomain (abwk140.neoplus.adsl.tpnet.pl [83.8.234.140])
        by mx.google.com with ESMTPS id t23sm701909bkf.16.2011.06.01.02.40.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 02:40:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p519eNl2010783;
	Wed, 1 Jun 2011 11:40:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p519eDK5010778;
	Wed, 1 Jun 2011 11:40:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4DE5F655.9020400@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174857>

Chengwei Ding <waterding@gmail.com> writes:

> can anyone confirm that this "--date" option is working for git
> annotate cmd.
> 
> i tried the same option on blame cmd which seems to be working, but
> not on the annotate which i use git annotate --date=relative or i
> wrote date config variable as blame.date which again work for blame
> but not annotate, but document says it should share same variable.

"git annotate" is left for backwards compatibility, so it might be
that not all git-blame switches work correctly with it.  

Does "git blame -c --date=relative" work?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
