From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 17:11:44 -0700 (PDT)
Message-ID: <m3fxr2jruy.fsf@localhost.localdomain>
References: <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
	<7vwskjazql.fsf@gitster.siamese.dyndns.org>
	<20080621121429.GI29404@genesis.frugalware.org>
	<7vwskfclfs.fsf@gitster.siamese.dyndns.org>
	<9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
	<20080624160224.GA29404@genesis.frugalware.org>
	<alpine.DEB.1.00.0806241709330.9925@racer>
	<20080624185403.GB29404@genesis.frugalware.org>
	<alpine.DEB.1.00.0806242007150.9925@racer>
	<7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
	<20080624221049.GE29404@genesis.frugalware.org>
	<7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 02:13:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBIdB-0004Ru-JU
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 02:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYFYAMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 20:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYFYAMB
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 20:12:01 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:8564 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbYFYALt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 20:11:49 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1615284ika.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=hSQP4G9E6havmSVEgSWfqEVU0RwWH420X25M0kOS4dI=;
        b=K9e+vbu5TFqkoJJVtBBFUx6ZmF9eW61/VFQ831Aj7/OKVCyPtU3yzG4VzJhZtHKa9C
         LQxnT4EsQnDdUzLIdjJMAfO/wBBrvcK/xPX26+/nHKqZ7HY5rDaFxoya3lT0dNif0jbY
         qAVthWiGOAs4cRsG2er8L+mcgmZGf9smaYOyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=YuA/HLY7YSuASDLNUSSUg8TH9Anaq1/P0IJpRoEpfdwqkyc/yBBOvRC3Kba75P43ZC
         KPaJKYW3kksXml4nhPgoHhb1xZAeSKm2CWl7VovQnEI+MFFWCwCXv7eD82RmCoJL98MI
         TNSAM2rHkspHFZCa+nzgptEmNBEBJmYdiHfdg=
Received: by 10.210.49.19 with SMTP id w19mr904060ebw.69.1214352705936;
        Tue, 24 Jun 2008 17:11:45 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.223.44])
        by mx.google.com with ESMTPS id c25sm11093624ika.11.2008.06.24.17.11.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 17:11:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5P0Bc0C012298;
	Wed, 25 Jun 2008 02:11:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5P0BXaG012292;
	Wed, 25 Jun 2008 02:11:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86190>

Junio C Hamano <gitster@pobox.com> writes:

> Ah, there is not much we can do in that case then.  git-upload-pack is
> what the client asks you to run, and if you do not have it in the path,
> you can (1) either make sure it is on the path, (2) have the client be
> more explicit when asking for git-upload-pack (--upload-pack=$where), or
> (3) leave the minimum git-* binaries that can remotely be launched
> directly in the usual $PATH.
> 
> It most likely makes sense to do (3) anyway.  upload-pack, receive-pack,
> anything else?

What does "git ls-remote server:/home/vmiklos/git/test" invoke on server? 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
