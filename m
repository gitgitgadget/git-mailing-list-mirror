From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Sat, 16 Apr 2011 23:17:55 +0200
Message-ID: <201104162317.56045.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104162132.57650.jnareb@gmail.com> <20110416204823.GA5586@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Sat Apr 16 23:18:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBCsq-00056p-FL
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 23:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760447Ab1DPVSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 17:18:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45770 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab1DPVSE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 17:18:04 -0400
Received: by fxm17 with SMTP id 17so2383892fxm.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 14:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=OiPaUf1ASikhKl6TFgrOpSJixwKXJbLwyrpLywcbZLo=;
        b=b+gPZU0vAdr36C39d9K/+AmvBWlcXcT+2W9lKLbLPIrzuKn8G/Yrl1nw2mEIGa4g2E
         /U6Sp3ZxxmxyRinQfvbNa0OqZhFF9X7iOLCkm/IfJStmRyAqk/8EPt4vTI17s4gq8uhU
         cMUlJXo/ZDe9GSaeesgUl0qTr237vlG/6yrO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QaCZHAtRJgz1nrb/FjZBUxTVmiQUznUEmheS/5HNNe7erWxSHjdGJ4BQ4lNlBvWNl2
         aVrZCOa5NBZQvTrQMActQNTwoym4D12ZqGpoUBUncFeRIqDWfc9gESUq0xsJa98mtsug
         dOI8Gjqu5JZg51quChi/6qxyOnOgAplTLyipM=
Received: by 10.223.98.5 with SMTP id o5mr1001887fan.33.1302988682649;
        Sat, 16 Apr 2011 14:18:02 -0700 (PDT)
Received: from [192.168.1.13] (abvu151.neoplus.adsl.tpnet.pl [83.8.218.151])
        by mx.google.com with ESMTPS id j18sm1186273faa.42.2011.04.16.14.18.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 14:18:01 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110416204823.GA5586@external.screwed.box>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171695>

On Sat, 16 Apr 2011, Peter Vereshagin wrote:
> God love is hard to find. You got lucky Jakub!
> 2011/04/16 21:32:56 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
> 
> JN> No, fetching and pushing using HTTP transport, be it "smart" or "dumb"
> JN> Gitweb is web interface for _viewing and browsing_ repositories using
> 
> Good for purposes I described earlier.
> Bad for users to have different URLs as "URL is UI element" (c)

You can configure web server in such way that you can use the same
URL for fetching with git as for browsing repository with web browser
via gitweb, as described in git-http-backend manpage in one of
examples and also at the end of gitweb/README.

Nevertheless web browsing and fetching is done by two different
programs.

> JN> with ModPerl::Registry.
> 
> but not PerlRun?

If it runs ModPerl::Registry (persistently), then it runs 
ModPerl::PerlRun... but the reverse not always is true.

-- 
Jakub Narebski
Poland
