From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Tue, 30 Oct 2012 00:01:52 -0700
Message-ID: <20121030070152.GA13324@elie.Belkin>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
 <CA+EOSB=Rr8czjVJfA+F6DmHjDUBy0QQ-wd4t-3Uwb1Ksoadr0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 08:02:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT5q2-0008AS-Un
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 08:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab2J3HCC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 03:02:02 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48507 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab2J3HCA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 03:02:00 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4019649pad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 00:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RDFsAMvdvtpUVarvWLLQI+m7AJxDIHOhlsYvOG1xkNw=;
        b=TiYgg4/t9zW1ZJKTeJPbSOWcD86tVXYNc8s+s6wXncMmcMaDeyke7G0EWtN3kW7JS0
         kWC5w5e0uVp6RKRadUpHdBvKg9Wsz3D/GNV9Horhz6r6pNKl6+/6N2FQGpdqTbCat7h2
         Wm1SkhwbU/oVEkgZyqwTNdyXs/ef6CbVOFWnuvHdH/0gl/HC3n4ZcxB0k7J3QD4gp4D1
         1g9D+DiOYYM0BBeCUUx2KbFEubHgbrKJGeyT0A952w8yGrqLNyHnP0MWbDM8S1cct9Z1
         bvSyLN80YW9JWyUXBkyWsEpjHbEGDLN/rYagjaSiIkm0CThzoo9ksAUvQDBSvGbVSNu/
         FtDg==
Received: by 10.68.203.137 with SMTP id kq9mr99555299pbc.96.1351580520207;
        Tue, 30 Oct 2012 00:02:00 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id gu5sm91583pbc.10.2012.10.30.00.01.58
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 00:01:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+EOSB=Rr8czjVJfA+F6DmHjDUBy0QQ-wd4t-3Uwb1Ksoadr0Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208683>

Elia Pinto wrote:

> The shell word splitting done in base is a bashism, iow not portable.

No, ${varname##glob} is in POSIX and we already use it here and there.
See Documentation/CodingGuidelines:

   - We use ${parameter#word} and its [#%] siblings, and their
     doubled "longest matching" form.

Thanks for looking the patch over.
Jonathan
