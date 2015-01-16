From: John Keeping <john@keeping.me.uk>
Subject: Re: RFC: update hook for GPG signed submission on secured branches
Date: Fri, 16 Jan 2015 19:59:50 +0000
Message-ID: <20150116195950.GK26383@serenity.lan>
References: <BBE88A3EA44D47159C483F1046AC747E@black>
 <xmqqsifa1px6.fsf@gitster.dls.corp.google.com>
 <BD3DE7B299FE458287DC8C829CEADEC2@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Fri Jan 16 21:05:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCD9V-00040q-7p
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 21:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232AbbAPUFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2015 15:05:49 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:59712 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbbAPUFs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2015 15:05:48 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jan 2015 15:05:48 EST
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 64F38CDA59A;
	Fri, 16 Jan 2015 20:00:00 +0000 (GMT)
X-Quarantine-ID: <yYWEeSjZE+jU>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yYWEeSjZE+jU; Fri, 16 Jan 2015 19:59:59 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 6D2AFCDA5B3;
	Fri, 16 Jan 2015 19:59:51 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <BD3DE7B299FE458287DC8C829CEADEC2@black>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262573>

On Fri, Jan 16, 2015 at 02:47:25PM -0500, Jason Pyeron wrote:
> > I am not sure if the design of this, to require signature only on
> > the tip commit, is sound.  That is not a -bug- in the script,
> > though.
> 
> It is to handle the "all my devs worked on this, they do ________
> GPG", so as long as the tip os signed, it is an implicit I am
> responsible for what is submitted.

Isn't this an ideal scenario for using the signed pushes introduced in
Git 2.2.0?
