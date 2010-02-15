From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Usage messages produced by parseopt (Re: [PATCH] Add an optional
 argument for --color options)
Date: Sun, 14 Feb 2010 19:23:16 -0600
Message-ID: <20100215012316.GA16643@progeny.tock>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com>
 <20100214064408.GB20630@coredump.intra.peff.net>
 <ca433831002140658r30aa539fy5480cae8298d6d6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 02:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgpgJ-0004LI-GH
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 02:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab0BOBXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 20:23:16 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:40680 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab0BOBXP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 20:23:15 -0500
Received: by iwn39 with SMTP id 39so1732118iwn.1
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 17:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OgegI+Qvzhzwb/UcroZIUlVshWoPZpJ2jROcPnfnT3g=;
        b=stQK8+Ru9D7/hnSBF1BnWipWCVa2WIfoMXlMjcdsyFNDhILa1FdAPpG/mJ+vUPBncb
         PWcC4jfdpHjS7IIWJPRV+nD6PM1ZWoiFvaBfJnLGuAA7Q0FV+OZ214kWz3ChKsqXUwZp
         Y6Tw+P3N0eV2VzNsCzQa+kqZEDCNZyGwm18IA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V8HeNp69IaiL7Xr32w6ckO/TdyPOPW2BZQzh/n80+U9BFby+LGzqFDbZ8UTc0wKrWa
         VDoIIlPlMruyImhJp3MLs95iLQSAm2liD0hHE7BboMW+WcQ3zJn1SBEArh8dV/GfJBQ7
         ydVP/YJ0ON1jJVJiX3tQgh65dOY+ynCPLGZAs=
Received: by 10.231.147.199 with SMTP id m7mr3945120ibv.87.1266196994736;
        Sun, 14 Feb 2010 17:23:14 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm5794776iwn.5.2010.02.14.17.23.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 17:23:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ca433831002140658r30aa539fy5480cae8298d6d6c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139954>

Mark Lodato wrote:

> Would it be worthwhile to switch to
> parse_opt?  This may make the code cleaner, and it would definitely
> make the command-line interface more consistent with the rest of the
> suite.  From a user's point of view, the biggest win would be "-h"
> printing all of the options, like all the non-diff commands do.

Side note: I actually prefer the shorter usage messages, since when I
use the "-h" option, I tend to be just looking for a reminder.  Am I
alone in this?  Would there be interest in a "git <whatever>
--help=short" option or similar?

Jonathan
