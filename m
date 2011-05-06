From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH for maint] git-completion: fix zsh support
Date: Fri, 6 May 2011 05:06:03 -0500
Message-ID: <20110506100543.GA2016@elie>
References: <20110505185907.GD1377@goldbirke>
 <1304625144-5206-1-git-send-email-felipe.contreras@gmail.com>
 <20110505232503.GA7507@elie>
 <BANLkTikk1wfaC4Aic4iyJZXbZ5kkuEDxaA@mail.gmail.com>
 <20110506095920.GA1635@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 12:06:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIHvN-0002LJ-CM
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 12:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab1EFKGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 06:06:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64007 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab1EFKGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 06:06:09 -0400
Received: by iwn34 with SMTP id 34so2541149iwn.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EZ6vBBRqWna8KF480vhdki2Vk6n4NL64yp3uFzJZoCs=;
        b=cvbZJCtEAkCgSyCE5EkqPFp9Ha+Ug/+BCDwuk62Mq0aBF3bTm3tK/Rh+DLC35OxeZx
         F5baZzJGaKRwm/Gf3yTauhMAM6Kfmw8r/LNafgmtXHggwc8kqsL+DMUQO2L1BggkgVg6
         TUmek6+xyuJWUyEWgeEDOlt8fksy8gIWHsJK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oscr29q+g1yWw2iz0dxozcAhYBgIvsxvQp0HWeao1uoJ2PpOYJCW6X1DFG7ct1TeGs
         aWoltM3MYoWMROMw4jkMO86XFwTMsNPrjaw8DHE4NC9A45i4HF3cktvCrXH6nQfxGJQ5
         wb9rbzQyErbKRmDA8hEUBw2+4JUeaNegOjEt8=
Received: by 10.42.161.193 with SMTP id u1mr2508779icx.20.1304676369354;
        Fri, 06 May 2011 03:06:09 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id c1sm1289731ibe.34.2011.05.06.03.06.07
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 03:06:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110506095920.GA1635@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172966>

Jonathan Nieder wrote:

> What happens if someone
> calls "compgen -F" after words is hidden?

For avoidance of doubt: here "after words is hidden" means "from a
scope in which words is hidden".
