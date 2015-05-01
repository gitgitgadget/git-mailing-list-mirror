From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Fri, 01 May 2015 14:09:35 -0700
Organization: Twitter
Message-ID: <1430514575.2806.7.camel@ubuntu>
References: <1430346576.14907.40.camel@ubuntu>
	 <20150429231150.GB3887@peff.net> <20150430003750.GA4258@peff.net>
	 <1430355983.14907.55.camel@ubuntu> <20150430011612.GA7530@peff.net>
	 <1430358345.14907.62.camel@ubuntu> <20150430033725.GB12361@peff.net>
	 <1430450954.22711.69.camel@ubuntu> <20150501053559.GA13393@peff.net>
	 <1430501355.2806.2.camel@ubuntu> <20150501201136.GA3152@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 01 23:09:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoIBr-00015p-Dg
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 23:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbbEAVJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 17:09:39 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34898 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbbEAVJi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 17:09:38 -0400
Received: by pabtp1 with SMTP id tp1so101206022pab.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 14:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=fRNaSv+Vc3fYxAmB9RH5w4R/4lH94TkQ8vqf2X7kMxQ=;
        b=kUPQQCfhFvkkO+X/KI2LhTUQAguMQxVjBti0YpOm20/OQ74HdvOdehDlYniUChoRT1
         f9N3OWrBiZa1hEKMtHUzxyxpBtnIpmCHGjmtAQrV1UpoVj5lTeMMe+Fb5gPucu8CYKAg
         7c79e92iRlnDH/lLy7o+Nem1anfqf7162TwpUZKZ6fkFHuQ8AaISwzCoS3WPHSV7ZvLQ
         yyH/OZXp9rh+91RgeYQ6d5ue/VS5d8b1Elm0Uw9FkG69cy7vfG8ftkPFREbuFDc2hpCa
         qY6pwGOGdmOCz5twsOwRck2pQGum5Z5eKTGZXg+3Wb/l/YMSS9WiF7BSlP0Yqz5RzHUX
         ludQ==
X-Gm-Message-State: ALoCoQlzA+fuXEqdh7Nw0egBnr4HxtK8otbl0OjekqWM7+3UMCIv/WggWfdnmzM8ZpHcJShHfbdP
X-Received: by 10.68.250.194 with SMTP id ze2mr21436585pbc.24.1430514577889;
        Fri, 01 May 2015 14:09:37 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id e5sm5681189pdc.94.2015.05.01.14.09.35
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 14:09:36 -0700 (PDT)
In-Reply-To: <20150501201136.GA3152@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268180>

On Fri, 2015-05-01 at 16:11 -0400, Jeff King wrote:

> So maybe (c) really is the simplest way forward. I dunno. I know that's
> coming full circle to your original proposal. Hopefully that isn't too
> infuriating for you. ;)

It's exactly the opposite of infuriating.  Now I understand all the
issues much better, and it will probably be easier for me to implement.
