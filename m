From: Martin Gregory <marting@adelaideinterim.com.au>
Subject: re[2]: sparse checkout file with windows line endings doesn't work
Date: Fri, 20 Sep 2013 12:54:45 +0930
Organization: AI
Message-ID: <SDZYUVdaTCUzXD8wPVQvMjQwMzM4MTcx@IBMLT4>
References: <20130920031705.GA15101@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Martin Gregory <marting@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Fri Sep 20 05:26:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMrMo-0001Ve-Fk
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 05:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478Ab3ITD0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 23:26:46 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:39355 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab3ITD0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 23:26:46 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so9144673pbc.30
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 20:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :mime-version:organization:content-type:content-transfer-encoding;
        bh=Pa1UCxqOcgn5c5tjzNwVlOQ32aSR6qjGjX8/yppjk1E=;
        b=Ge9FA+IV4lkqpXUEAbKmOrCrl/nwOWB8mxKYW4kXGBFwPGlopNmeIVPxYu1PeohR2z
         Ml61k9cfbIah6xd48n6fBBVhmHwfCsupbqRbbmkoFUDqtdG5Y/r8Vg7oQOYL60tmTDI5
         EJYsUEjRt6Ovw+rfqgFLvhA8DwejiJnPUPan+EfhkljMQC/9R70y0jOLgCw1Lbhvdpae
         2jP+EAXEJitpkEXGwynUSHLfKWEWLKZSd8D5vMihViNeR7Bba7/TceDoI2jJM67xOzmU
         HFDIjvkSCDnPUtOCNlVTlZDV6mBZtmfebtA0UDoWKydyNqzTU+4PkN3Chg8Hjz/OmV1a
         nvTg==
X-Gm-Message-State: ALoCoQmJaXAc+MLqRRJRyLpWMM0VI2IhklMfx5huyV9/EinME4l/pmX7kazx8jFQmkt4OZ+A4R8b
X-Received: by 10.68.169.161 with SMTP id af1mr5559062pbc.22.1379647605621;
        Thu, 19 Sep 2013 20:26:45 -0700 (PDT)
Received: from IBMLT4 (ppp121-45-31-21.lns20.adl2.internode.on.net. [121.45.31.21])
        by mx.google.com with ESMTPSA id fy4sm12656653pbb.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 20:26:45 -0700 (PDT)
In-Reply-To: <20130920031705.GA15101@sigill.intra.peff.net>
X-Mailer: GoldMine [9.2.1.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235053>

>>  On Fri, Sep 20, 2013 at 11:22:01AM +0930, Martin Gregory wrote:
>>
>>  > When something goes wrong, there appears to be no way to understand what
>>  > git thinks it's reading. I'm not sure if such a way, if it existed,
>>  would help with
>>  > trailing spaces, but if you could say
>>  >
>>  > git read-tree -muv HEAD
>>  >
>>  > and it would say
>>  >
>>  > reading '.git\info\sparse-checkout'...
>>  > rule '/CONFIGURATION ' - no matches
>>
>>  I don't think you can do that in the general case of read-tree. You may
>>  have sparse paths that exist in some commits, but not others. As you
>>  move around in history, a sparse entry that does not match might do so
>>  because it is poorly written, or it might do so because you just don't
>>  happen to have any matching paths in the commit you are moving to. The
>>  former is a problem, but warning on the latter would be useless noise.

Even if you only do it as part of a verbose option?

My thinking was that when you specify verbose, you are saying "I don't
mind a bit of noise in order to find what I'mlooking for".

Therfore, if you have a "no match" on a valid but not-in-view in the commit,
it's not a "problem", it's just part of the verbose information...

Regards,

Martin


--
Martin Gregory
Senior Consultant, Adelaide Interim
P:   +61 8 7200 5350
M:   +61 402 410 971
F:   +61 8 7200 3725
