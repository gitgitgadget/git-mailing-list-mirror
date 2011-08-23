From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to check out the repository at a particular point in time
Date: Tue, 23 Aug 2011 11:05:25 -0500
Message-ID: <20110823160525.GB3545@elie.gateway.2wire.net>
References: <201108221525.32982.trast@student.ethz.ch>
 <1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
 <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rdiezmail-temp2@yahoo.de, Thomas Rast <trast@student.ethz.ch>,
	in-git-vger@baka.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 18:05:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvtTs-0001qG-Be
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 18:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab1HWQFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 12:05:32 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55563 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab1HWQFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 12:05:31 -0400
Received: by qyk34 with SMTP id 34so197988qyk.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CIh5ki1xM7rXUgpXGZcMiyPtk5ZAICXFVdKjPK1jxWI=;
        b=uIITumGNsqGtAosW/GEkWqnbXntOrT05sbc4q9vbf89wpqAOj0jwBzuSmsajjWiatr
         gXLeyahlDUPhi9+70q4iZCTIchmXGmCTutjZlHOi9ZyGI5haKKWoNGOJD8NGIuAuHa1h
         KKbh/t/7ZePiynbbowUiPifM+oOi+IbKbARC8=
Received: by 10.224.200.1 with SMTP id eu1mr2518692qab.63.1314115530232;
        Tue, 23 Aug 2011 09:05:30 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-73-45.dsl.chcgil.ameritech.net. [69.209.73.45])
        by mx.google.com with ESMTPS id ed3sm142210qab.9.2011.08.23.09.05.27
        (version=SSLv3 cipher=OTHER);
        Tue, 23 Aug 2011 09:05:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179943>

Michael Witten wrote:
> On Mon, Aug 22, 2011 at 15:18, R. Diez <rdiezmail-temp2@yahoo.de> wrote:

>> I still don't quite understand how git works, but let me
>> risk a naive statement here. If "a-b-c-M" were 'master',
>> and "d-e-f" were 'new-feature', then on April 1st the
>> current version on 'master' is 'b', because I merged the
>> 'new-feature' branch at a later point in time. Does that
>> make sense?
>
> O! for the love all that is Holy!

Wait, what's wrong with what R. Diez said?  It's exactly what
--first-parent gives you.
