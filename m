From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Sun, 30 Jan 2011 16:36:58 -0800 (PST)
Message-ID: <m3hbcpaozx.fsf@localhost.localdomain>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
	<AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com>
	<15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
	<m3tygt9xmn.fsf@localhost.localdomain>
	<20110129194258.GE602@nibiru.local> <20110129232848.GC7676@gmail.com>
	<20110130193603.GA327@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Enrico Weigelt <weigelt@metux.de>
X-From: git-owner@vger.kernel.org Mon Jan 31 01:37:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjhlX-0002hV-AH
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 01:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab1AaAhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 19:37:03 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55180 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab1AaAhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 19:37:02 -0500
Received: by wwa36 with SMTP id 36so5281321wwa.1
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 16:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=vZqRLPv/b1WNaVVqZZ+Eswz3h7PeLvo5u9/FnmFLvig=;
        b=oazWJpRt6FL0QF/a/qi98t4ZIh8WsYvAYG+vm2TkjI14vmL8UEcs83rfzfiXzYxli/
         bq2rDy1GqmfjyavgljD8UfG8nbZ8naOOYDynX0Km+DWq8oboqmzQb6x8aCzGFyXDvnum
         aATSgHT/TCRD+QVPXmTRaSPVfB3+gpXfWuNAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=cLGUMF7dOHAksm3nuh4bDSEKl42tQTcO+pzAxNTsOrgOMlGnzueoQIs3LQBuMq3a1I
         8ge31d7qiE2PBJagpMRquE/+DyZd1E/NOGcKTUCGG49bC1N2OojI3svigVUW29TubiaP
         0OEiEuKYFQda73JOG6gVCHo3naCoZsdHmw7BU=
Received: by 10.216.165.76 with SMTP id d54mr1409251wel.43.1296434219595;
        Sun, 30 Jan 2011 16:36:59 -0800 (PST)
Received: from localhost.localdomain (abvr78.neoplus.adsl.tpnet.pl [83.8.215.78])
        by mx.google.com with ESMTPS id c54sm10478010wer.30.2011.01.30.16.36.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 16:36:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0V0aMYQ030336;
	Mon, 31 Jan 2011 01:36:32 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0V0a3lB030331;
	Mon, 31 Jan 2011 01:36:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110130193603.GA327@nibiru.local>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165713>

Enrico Weigelt <weigelt@metux.de> writes:
> * David Aguilar <davvid@gmail.com> wrote:
> 
> > This is exactly how we do it at my workplace.  We have literally
> > hundreds of individual git repositories.  Naturally, some
> > packages depend on others and the only "trick" is building them
> > in the correct dependency order.  A simple dependency tree
> > handles this for us.
> 
> perhaps you'd like to have a look at my Briegel build tool:
> 
>     git://pubgit.metux.de/projects/briegel.git
>     
> ;-)

Is it Git-specific build tool?  If it is so, perhaps it would be good
to add it to
 
  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools

page on Git Wiki?

Thanks in advance
-- 
Jakub Narebski
Poland
ShadeHawk on #git
