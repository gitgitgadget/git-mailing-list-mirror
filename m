From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Tue, 27 Jul 2010 03:28:17 -0700 (PDT)
Message-ID: <m3k4ohkyns.fsf@localhost.localdomain>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
	<AANLkTimdYfv-Z57iHD+YLfjKi66av5xmaC3JEMRNRw+Y@mail.gmail.com>
	<AANLkTin9kbMp5nOS=GaM2rX1w+y8vbzYfWunkSSeoPZg@mail.gmail.com>
	<20100727053040.GA6014@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 27 12:28:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdhOb-0008To-OW
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab0G0K2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 06:28:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33987 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab0G0K2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 06:28:19 -0400
Received: by bwz1 with SMTP id 1so3226143bwz.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 03:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=MstL7UP7HWA8liJ6BCNWTe6RSBO7WbvdgPdXbnJz+i4=;
        b=ozp2Ns3CMRx7rjDwTiZGjEkXGowWSq916YL4gH8JMgQQi/9ZpOMmVgm/ykVJcNzx5P
         TIC+qEaphcf0TIZvLavko6LwlYgNUZRe2PyVzgqtpdcmYuT8DEu+LUmiVTErBV8W6Us6
         JPkxXWXjF0vH6jJyMkcNCsdv+1Gsd3uHotTZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OslG+8rBAtRo0rSmAEReQgLxevgLBcD0bvf7xLCfq3K4nC0ivGN3q1WpjoO+buGq0X
         r6X0mYxKaU+VYOBkGl4R9WlEjT62tlq4Le07iX58iMa7/LQI29JSU7MChq9vfpH4vXnS
         H75YB+ktv3CV7pkffm04aoQkLgaEI4CFhMFYM=
Received: by 10.204.152.4 with SMTP id e4mr6437173bkw.120.1280226497940;
        Tue, 27 Jul 2010 03:28:17 -0700 (PDT)
Received: from localhost.localdomain (abwn25.neoplus.adsl.tpnet.pl [83.8.237.25])
        by mx.google.com with ESMTPS id y27sm3671621bkw.2.2010.07.27.03.28.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 03:28:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6RARd9n027594;
	Tue, 27 Jul 2010 12:27:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6RARJES027590;
	Tue, 27 Jul 2010 12:27:19 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100727053040.GA6014@coredump.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151928>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 23, 2010 at 02:16:45AM -0400, Avery Pennarun wrote:
> 
> > Only this: Junio said that there are no major downsides to this change
> > - and given the slow pace of change in gitk/git-gui, this is probably
> > true - but are there any *upsides*?  What problem does this solve?
> 
> One minor complaint with the current setup is that browsing the history
> with path limiting is unintuitive. You can't do "gitk gitk" in the
> gitk-git directory. You must instead do "cd .. && gitk -- gitk".

Do 'gitk --relative=gitk' or 'gitk --relative' work?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
