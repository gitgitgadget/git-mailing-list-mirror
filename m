From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Add Pascal/Delphi (.pas file) funcname pattern.
Date: Fri, 1 Aug 2008 16:38:43 -0400
Message-ID: <32541b130808011338t17a45e51sd0df245dc456b087@mail.gmail.com>
References: <1217619915-9331-1-git-send-email-apenwarr@gmail.com>
	 <7v8wvgsd6s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:39:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1Pd-00063j-Q3
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbYHAUio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbYHAUio
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:38:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:6453 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYHAUio (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 16:38:44 -0400
Received: by yw-out-2324.google.com with SMTP id 9so732644ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 13:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=T02VPq/59VctXXmXJsk6jtrA8TYzoWU6Lh0GjkUDCvU=;
        b=j1xuUGgd1rBOrhaqSl6ew+Vqs4xryTvEeJnjZ56Pz9DkZ58jYGB3wJj0pT8DYo+IcG
         vEXX1B4b035onH3r+BlfEGQN+NU+mWKvl4MxcfpAcnX6rqQz/MIqSYpsjJcQIQb2JmGB
         R9QLLkIuqHe2/TpobboVEIGmoCE7zfAxxoz9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=J1IS1yVdxKW1LnZSU2hP0Nept8QojbbveHHIFPpIDdu5JHBwB8pQD04Sc+C2TTq3HJ
         c3Ll73IErAaOCJ0u1wPvQCmsozCtWAs4mGAjiBLh3ZMdofhPWdzNouussEUWnbyRGoBw
         VfKHxRcKcDH6DWzAd6f6EOYjmAt0duw/DGtRw=
Received: by 10.151.84.12 with SMTP id m12mr3882116ybl.11.1217623123102;
        Fri, 01 Aug 2008 13:38:43 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Fri, 1 Aug 2008 13:38:43 -0700 (PDT)
In-Reply-To: <7v8wvgsd6s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91094>

On 8/1/08, Junio C Hamano <gitster@pobox.com> wrote:
> Is Delphi the only surviving Pascal?  Why is the name "pas", not "pascal"
>  or even "delphi-pascal"?

No, but all surviving Pascals pretty much support the same syntax, so
when I say Pascal/Delphi, I mean either one.  And Delphi does use the
.pas extension.

>  The keys are not file extensions ("ruby" example did the right thing by
>  not saying "rb").

Will fix.

Avery
