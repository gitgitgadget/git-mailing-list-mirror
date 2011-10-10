From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5/RFC 1/6] Documentation: Preparation for gitweb manpages
Date: Mon, 10 Oct 2011 23:52:24 +0200
Message-ID: <201110102352.25456.jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com> <1318098723-12813-2-git-send-email-jnareb@gmail.com> <7vwrcck1jm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 23:52:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDNlx-0006yQ-2j
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 23:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1JJVw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 17:52:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57868 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab1JJVw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 17:52:27 -0400
Received: by wwf22 with SMTP id 22so9552480wwf.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=ExJU4vrQYBP6YjjZHennFbGC+4tqdegVBr2waA/p17g=;
        b=Jrweu4gmyP4ITlaUXSidlC4468o8x8wCV+lF8h18cqUcA1fQ77YYXr452iMxNVxEhB
         RaJlyamjsYppp/+v8xripD/X0y5Oi9KwLjB8X47zd8PWqKWaYalUwfNLP6KvSzqdi4oI
         ygeuOwgFD67GDBMQHUQdrUX34F0Sh7ERpOThU=
Received: by 10.223.62.19 with SMTP id v19mr34662057fah.27.1318283546063;
        Mon, 10 Oct 2011 14:52:26 -0700 (PDT)
Received: from [192.168.1.13] (abvx204.neoplus.adsl.tpnet.pl. [83.8.221.204])
        by mx.google.com with ESMTPS id n18sm33906831fah.2.2011.10.10.14.52.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Oct 2011 14:52:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vwrcck1jm.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183260>

On Mon, 10 Oct 2011, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > This patch adds infrastructure for easy generation of only
> > gitweb-related manpages.  It adds a currently empty 'gitweb-doc'
> > target to Documentation/Makefile, and a 'doc' proxy target to
> > gitweb/Makefile.
> 
> I tend to agree with your after-three-dash comment that this separation is
> not necessary, it may be expedient while working on the series, but wants
> to be removed once the series is complete.

Also it is a bit of historical remains, as in original patch by Drew
the manpage (the AsciiDoc source) was in 'gitweb/' directory.

Anyway, I'll remove this patch from the future versions of this patch
series (if there would be need for next version).

[...]
> > ---
> > This commit is not strictly necessary: it only adds "doc" target to
> > gitweb/Makefile, and "gitweb-doc" target to Documentation/Makefile;
> > neither is run when e.g. generating RPM.
> >
> > They are here because they would be here if documentation source was
> > kept along with gitweb script in the 'gitweb/' subdirectory, and to
> > make it easier and faster to test the changes.

-- 
Jakub Narebski
Poland
