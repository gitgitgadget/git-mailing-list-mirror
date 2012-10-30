From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Mon, 29 Oct 2012 21:46:09 -0700
Message-ID: <20121030044609.GA10873@elie.Belkin>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 05:46:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3ig-0008UY-KF
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab2J3EqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:46:17 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:61613 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2J3EqR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:46:17 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2774544dak.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GCBjEs8VW1ox++f+xILz4rkJ8dFysozP7K66BuFr2cQ=;
        b=oEgKPD6cVBROBhaKGen6MaNwXSJBjBKpa4j5ObvE546GdxU4fSnguw8dcqhLRbb9Va
         udvRDS7P+hVk5Qk2gO65AMBsM/LOJ6rA1ByrAjy1gxw7osvE04zawfYyKrobP5n3aZzB
         NOMgCCUa89TWtlcCKZ5wmUdHb+LM3w6C4ba9IjWSKD7JMpsO5D1Iv7uRigYC7w6G8NMv
         4HhO2+XwhZeY0UwOrdFa6zsQYSsJLc2mzhynQEh1q44rEfIacD1DPM6TS0mzWpS8TFkE
         UcvFR1TTiNRm0goLSipr7AHuFGayxh4mne6lTS4GQ9WMGCOYzeNcBkW0BwGqM/GEf2cv
         xggg==
Received: by 10.68.226.67 with SMTP id rq3mr4442616pbc.121.1351572376782;
        Mon, 29 Oct 2012 21:46:16 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id g10sm7098133pav.9.2012.10.29.21.46.15
        (version=SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:46:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208679>

Hi,

Felipe Contreras wrote:

> No reason to use the full path in case this is used externally.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

"No reason not to" is not a reason to do anything.  What symptoms does
this prevent?  Could you describe the benefit of this patch in a
paragraph starting "Now you can ..."?

Thanks,
Jonathan
