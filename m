From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH 1/1] git-send-email: Add a --suppress-all option
Date: Tue, 18 Sep 2007 09:29:02 -0400
Message-ID: <31e679430709180629p328abba8ud4c4ce7fef7645e4@mail.gmail.com>
References: <11900540373215-git-send-email-felipebalbi@users.sourceforge.net>
	 <46EF8107.1030607@op5.se> <20070918132251.GB12120@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	"Felipe Balbi" <felipe.lima@indt.org.br>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 15:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXd8b-0003my-VE
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 15:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbXIRN3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 09:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbXIRN3H
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 09:29:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:30777 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbXIRN3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 09:29:03 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2413876wah
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=jzUBFQlvcorBQoibBWrZgIa+2mN1p0Azfi3hD+guB7Y=;
        b=d5x7uVbZXvyGOs4EcggWKU5yr8U4etO4LEZVQEOHzAP5ZGtSKQZ3ss09UT2c93VEwIp9JgSvC0OYVg3uBEJSFTJe32MB7VmwnoZTUjRVk/1yXODYL9+bnt8wWK04EOXIjDNxRbC27U2Nf7JE3NerZTQHmbEDwM409rnkKBJOil4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SzGy7+RiGFlhgdxkYd12MiAl9j8SE4BjXxA3PrgNvjPivqtjmxRzZB9D/zzEl8qOLzblWaTipjRbVbx9qsLj3bMMKAS538dZlomknkeWSYvOZOUccefdHP25nh4mdz+8CcLXZ4HPCZufJmbpwOYXBcdU605p1kB0g8Osd7Tgccw=
Received: by 10.114.80.4 with SMTP id d4mr3964125wab.1190122142583;
        Tue, 18 Sep 2007 06:29:02 -0700 (PDT)
Received: by 10.114.61.4 with HTTP; Tue, 18 Sep 2007 06:29:02 -0700 (PDT)
In-Reply-To: <20070918132251.GB12120@fieldses.org>
Content-Disposition: inline
X-Google-Sender-Auth: 542778297532f1a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58607>

Hi,

On 9/18/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Tue, Sep 18, 2007 at 09:40:55AM +0200, Andreas Ericsson wrote:
> > Felipe Balbi wrote:
> >> From: Felipe Balbi <felipe.lima@indt.org.br>
> >> This patch adds a --suppress-all option to avoid sending emails
> >> to everybody but the ones listed by --to option.
> >
> > To my minds eye, --suppress-all is equivalent to --dry-run. Could you
> > rename it to "--cc-nobody" or some such?
> >
> > On a side-note, I've never really understood why git-send-email *by
> > default*
> > sends to a bazillion people. Does anybody ever use it without suppressing
> > most of the CC targets?
>
> Yes.  I never suppress the cc's.  The cc-everyone thing is standard on
> the kernel mailing lists.
>
> The one exception is if I'm just sending the series to myself as a test.

And that the motivation for this patch :-p

Internally (in my company, where I work), we send patches to each
other for code review before sending it publicly.

>
> --b.
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
