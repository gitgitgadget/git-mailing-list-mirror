From: Martin Gregory <marting@adelaideinterim.com.au>
Subject: re[2]: sparse checkout file with windows line endings doesn't work
Date: Wed, 18 Sep 2013 07:48:47 +0930
Organization: AI
Message-ID: <SDZTMjNKSyNOVFAgPVQvNzQyNzg1MzE@IBMLT4>
References: <CACsJy8CRoZYWExHMjwG3ZOv=eJ9irq_mM_bM78ss_DssSq7szw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	Martin Gregory <marting@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Wed Sep 18 00:21:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM3eD-000749-Cw
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 00:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab3IQWV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 18:21:26 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:53397 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab3IQWVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 18:21:25 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so6104063pbc.23
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 15:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :mime-version:organization:content-type:content-transfer-encoding;
        bh=OxkYM9rfkQh/GUeDlx/SHkzw23++p7M/CaygE4PsZyI=;
        b=BHNyzITgxWqPoNYEa1Ff3SSrYG079jHwOPOC4+ljdXtXIArOcRygQamRYyfwUZ+twW
         w0rVDwJIryTritZlww4k/O5Vrf+jn54AKBKxDhDlKbskUA/4fAJpv2nS2+zE5c1d1BWb
         NVuTo3jNOAGCJAtRvX+ltLIJll+4IyGD2QoBAhAs3EvC2FQpGLR6C94pesN0oh5KMM6n
         DVqpf3TAjVkN90IEGKq4HvbsLd7npJc6VFmr+s5z1SK1B5b7zFxqbkvAbKdaxdNGexKE
         jbBZNUU1pG6quObAEOdj/BkZ6DMQ21ZnE0Dg4EdN2GqkWfMxNZ2KrMF2ew5Lyr6nGOsi
         0MOA==
X-Gm-Message-State: ALoCoQkBlmvvKHke3PvO2qqb0uy7ER0fhLyJIpoJJMj6PMy4h69sTn+AfEQ33bcU9gazlLQYK80L
X-Received: by 10.68.137.231 with SMTP id ql7mr37495647pbb.37.1379456484814;
        Tue, 17 Sep 2013 15:21:24 -0700 (PDT)
Received: from IBMLT4 (ppp14-2-54-108.lns21.adl2.internode.on.net. [14.2.54.108])
        by mx.google.com with ESMTPSA id os4sm40662536pbb.25.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 15:21:24 -0700 (PDT)
In-Reply-To: <CACsJy8CRoZYWExHMjwG3ZOv=eJ9irq_mM_bM78ss_DssSq7szw@mail.gmail.com>
X-Mailer: GoldMine [9.2.1.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234939>

Hi Duy,

Thanks again for taking a look at these two reports.

>>  And it does work for me with CRLF endings (again tested on Linux).

Yes, will do.

I will try, myself, on Linux, as well.  It seems quite conceivable its the
sort of thing that only happens under Windows.

Regards,

Martin
