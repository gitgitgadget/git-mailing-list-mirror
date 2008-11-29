From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: add patch view
Date: Sat, 29 Nov 2008 16:43:51 +0100
Message-ID: <bd6139dc0811290743s6cf8e534nddd8a09698ea22b9@mail.gmail.com>
References: <1227966071-11104-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1227966071-11104-2-git-send-email-giuseppe.bilotta@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 29 16:45:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6S0L-0005NW-NO
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 16:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbYK2Pnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 10:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbYK2Pnx
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 10:43:53 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:33391 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbYK2Pnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 10:43:53 -0500
Received: by yw-out-2324.google.com with SMTP id 9so730448ywe.35
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 07:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EkzL5lYmbB5LcgvhV06tMHq1OnCGEzDLEweLeFS6en8=;
        b=UMUz2hhmCS8iMrFulomlfAfMiH2ZJ+uNNQ2HmmhvA43ch/dPn80TcSrSeXAKukHBPS
         iqsRE+SgXEyhA8Ci/koHHxKKcXl76DCBG4WTq3XUjGOtIL06Zo5mbz9TqA4JfjN0Aux8
         gVZw9TyC7qMhwxk4/X5+6TQYveIKEWxUGo1n0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=q3zXouezxnVopViWOuisaayjKqRDTTIpA7X1gYN+SS3VHx3nmIGw5NGupe42ycgtkY
         fGqSBU5D8TFLXKKSmrclDy32DJD8lsgwKSEQ+9waQlCKNauFi+PRmW+mCso5IyAli+sr
         KHg+CJBIs4kbgtzuAExdvatfqwlzQD7pqqleI=
Received: by 10.150.177.20 with SMTP id z20mr17857448ybe.201.1227973431888;
        Sat, 29 Nov 2008 07:43:51 -0800 (PST)
Received: by 10.151.108.18 with HTTP; Sat, 29 Nov 2008 07:43:51 -0800 (PST)
In-Reply-To: <1227966071-11104-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101915>

On Sat, Nov 29, 2008 at 14:41, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Trying to use 'commitdiff_plain' output as input to git am results in
> some annoying results such as doubled subject lines. We thus offer a new
> 'patch' view that exposes format-patch output directly. This makes it
> easier to offer patches by linking to gitweb repositories.

If this does what I think it does I would be very happy with this
feature :). Only yesterday I wanted to link someone to a patch I put
up on repo.or.cz, but instead ended up telling them to download the
snapshot.

As an additional feature request; would it be possible to have a view
that exposes a patch that is directly applyable by the patch command?

-- 
Cheers,

Sverre Rabbelier
