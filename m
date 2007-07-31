From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add an option to specify a file to config builtin
Date: Tue, 31 Jul 2007 14:02:13 +0200
Message-ID: <81b0412b0707310502x588c9c6dh7d9290360b27647a@mail.gmail.com>
References: <81b0412b0707310453pc6b11d2r90ca0f22b5ed601e@mail.gmail.com>
	 <Pine.LNX.4.64.0707311258340.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 31 14:02:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFqQd-0003Kp-UG
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 14:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbXGaMCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 08:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbXGaMCQ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 08:02:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:11835 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbXGaMCP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 08:02:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so66293ugf
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 05:02:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gaVGl0El5OXvTq6y9Jj+BAv3FNSCAlB6vF+AsPqplnuS/ZiXJyA1b8JJ/bYLrouqJ4pbAq0zPU4RV3lMw0ADPq2Zh25IX+wLNMadSTBGQH8wR2sGurCnhDWyOdsfnOQ8XRG7p+DaQIdGfhRlRAqKXBRveIaoVsRx2KuylRCsRv4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BSUMBZ/sG3STeDyVC1amzSQ2qdFwrKLtKsN+PPKfREsYbTm3dZ9OWUZxq0i/+kh0u8ZZoli06/vp+EMlE21qzal5/NQGCy02+59cgbAHHANN6ish6EKznWNBiB+aiaB7ygy/6vF7pJSXW+Wsmsk7vq0GAvgvu5lkQlGstZ2Ss4c=
Received: by 10.78.150.7 with SMTP id x7mr1772396hud.1185883333974;
        Tue, 31 Jul 2007 05:02:13 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Tue, 31 Jul 2007 05:02:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707311258340.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54341>

On 7/31/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > There are (really!) systems where using environment variables is very
> > cumbersome (yes, Windows, it has problems unsetting them). Besides this
> > form is shorter.
>
> You could use this chance to make the verse nicer, i.e. split it into a
> [<file-option>] and an [<action>] part.

Missed that opportunity for today, I'm afraid. Will try to get to it
the next evening
