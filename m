From: David Turner <dturner@twopensource.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 16:22:17 -0400
Organization: Twitter
Message-ID: <1435090937.28466.68.camel@twopensource.com>
References: <1435020656.28466.8.camel@twopensource.com>
		 <CAGZ79kap++fZx3X0D95d35XioRURU468xATDZpWHDOAPapAh+Q@mail.gmail.com>
	 <1435089895.28466.65.camel@twopensource.com>
	 <005101d0adf0$964bca10$c2e35e30$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: 'Stefan Beller' <sbeller@google.com>,
	'git mailing list' <git@vger.kernel.org>,
	'ronnie sahlberg' <ronniesahlberg@gmail.com>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:22:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7UiC-0004HH-7P
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbbFWUWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 16:22:24 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36660 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130AbbFWUWU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:22:20 -0400
Received: by qkfe185 with SMTP id e185so11162239qkf.3
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 13:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=EN0G/rmKuff+FgizX+pnaWxQ49kbXcuEDOlZAg5ydyY=;
        b=WLfOAnb2fT6rPASFdeVUMPZLLl0ExWX2kY8VdpnwGkIAEX/cHwgfGk4E9g12XoXJKr
         DKsDcxdqkOkF+SZ1bxWwdjqEd5BHOUOlJVgT/9ywPS955CDjjUJA39qy6FkOO5qPrZWf
         ssYGsZUwp/6jdYQRJgD06NgjsDQMejEldpcmIQSXRneq9JXGDbnRUeFQw+utrg/43mea
         aDcOrDwmS4pg/wnVnFHsGR3QTi47pKkOhN2yxP4XB9HCsd0E8OMMKrjIzSrZ69ZIFsA0
         zpLrAEWpmZ3wBsWafa1/GfDkrbpNUeqAiua+DeM4OadTUXZ/90govPQl9dR5NAYbzVNK
         rUSA==
X-Gm-Message-State: ALoCoQnru/EKVzHq+osRaCP57syftxvO2sbC1hVW5CMGom1cSwuQdkFF3i7TsyyY4F5jJ8e17ugB
X-Received: by 10.55.23.146 with SMTP id 18mr75679034qkx.99.1435090939927;
        Tue, 23 Jun 2015 13:22:19 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id u10sm2037374qgd.14.2015.06.23.13.22.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 13:22:18 -0700 (PDT)
In-Reply-To: <005101d0adf0$964bca10$c2e35e30$@nexbridge.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272496>

> Just to beg a request: LMDB is not available on some MPP architectures to which git has been ported. If it comes up, I beg you not to add this as a dependency to base git components.

My changes make `configure` check for the presence of liblmdb. The LMDB
code is only built if liblmdb is present.  So, I think we're good.
