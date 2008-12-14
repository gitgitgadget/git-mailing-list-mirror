From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 02:47:31 -0800 (PST)
Message-ID: <m3zlizdofy.fsf@localhost.localdomain>
References: <200812090956.48613.thomas@koch.ro>
	<bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com>
	<87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nix <nix@esperi.org.uk>,
	Thomas Koch <thomas@koch.ro>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 11:49:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoWr-0005Nn-Tk
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 11:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbYLNKrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 05:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYLNKrg
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 05:47:36 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:45149 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbYLNKre (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 05:47:34 -0500
Received: by ewy10 with SMTP id 10so2509211ewy.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 02:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=evR+HyNwwocrvOp2MxDVmW+/vixpHCsueHwnF9TPMxk=;
        b=rssueyUXUS1/wZV5a0jT5/IsLOorA+FiyzSJ5UtnIl6yv/WkOz3yAx/O3548MDW3Fh
         5TnlyHnWERmMEYhK2P2JH06x8yA7k8BKtJl3M4fH9H7UJ7BR2bAkuEqtyEyIqBaBhdZH
         JSZ0+bw81haz1krIPV4O414Xvyl0PQ3iunxPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=KTFWog/Dzhmguw/b1e51GF2V39dgOksPIqUz1lJ0IrsdnmT4srcQ/+y7EiSftkdw2n
         6YD7+fOnQ8DIlyEe7aor4C1IFN6SYx1si5cD7JrxOquPaKicisJi0q+i1WwtUdasy7Ou
         wFxmwTDm471U0ryDi7nhK8fs19+xouPiJToIM=
Received: by 10.210.87.19 with SMTP id k19mr3153420ebb.64.1229251652854;
        Sun, 14 Dec 2008 02:47:32 -0800 (PST)
Received: from localhost.localdomain (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id 20sm784442eyk.4.2008.12.14.02.47.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 02:47:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBEAkllE015669;
	Sun, 14 Dec 2008 11:46:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBEAkQYb015665;
	Sun, 14 Dec 2008 11:46:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <gi1qsl$22p$1@ger.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103062>

Sitaram Chamarty <sitaramc@gmail.com> writes:
> On 2008-12-13, Nix <nix@esperi.org.uk> wrote:

> > telnet. I do not jest, this is our sysadmins' stated reasons for not
> > opening the git port and for tweaking their (mandatory) HTTP proxy to
> > block HTTP traffic from git.
> 
> Wow -- my sympathies!
> 
> But on occasion, when real or imaginary issues prevented me
> from making a live connection, I have used "git bundle" to
> do the job.  Not as satisfactory as a real connection, but
> when you have a proper, non-fast-forwarding, repo as the
> "mother ship", git bundle with some custom procmail scripts
> on both sides can work OK enough.

Perhaps one would be interested in adding bundle support to gitweb.
The problem is in the interface, but I think in simplest case gitweb
could present 'bundle' link along snapshot link(s) in the 'heads' view
(showing branches), which link would generate bundle for a given
branch, starting from latest annotated tag.  But this is only for
download...
 
Another solution would be to help with "smart" HTTP protocol,
i.e. git-over-http solution.  This would hopefully change signature so
at least for some time it would pas proxy filters.  Also only for
download.


BTW. is outgoing SSH transport (from network to outside) blocked as
well?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
