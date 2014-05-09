From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 09 May 2014 02:11:12 -0500
Message-ID: <536c7f9089b77_182dd0d31084@nysa.notmuch>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
 <20140509055024.GB30674@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>
To: Eric Wong <normalperson@yhbt.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 09:11:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wiexm-0005DF-Dj
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 09:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbaEIHLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 03:11:18 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:42125 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbaEIHLR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 03:11:17 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so4337624obc.34
        for <git@vger.kernel.org>; Fri, 09 May 2014 00:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=2Bav9H98nrIAKSDHWJPxGb79xCuAxtglQWS5vrnUW4Q=;
        b=NtxZ+uVTPdklMNRuU8qxQ/xlLpZG4EBRjtbMtE56vAq8NheyxRFtTS9FtaqpWPS8BB
         fL+ZQaC9eV+iEHzbxEpoaa75Rl6hOS3WAHyY6M//j5a+/vAnzSlcIGs0UcrL5Ijsqo0K
         +SdzUsEcGJWZ0lvBrGZZUP5W2BFTSIoiC7aXaHHf8rwPQrTjKv/UekSEsOlDGxpC+UYF
         1t5YM0GPakyGOE9tbXNtg6IDFOk7M0td008Z++Ry40L4OHWBB856Klom3vz/SodvFg2p
         4g/Smr564n+JunAQlr69FOSLR2KfhQltc4IB8yO3WFEGSwDCv3suicmfVwCrgWDvyaPw
         48Dg==
X-Received: by 10.60.39.131 with SMTP id p3mr10981317oek.44.1399619477158;
        Fri, 09 May 2014 00:11:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm13344011oeb.10.2014.05.09.00.11.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 00:11:15 -0700 (PDT)
In-Reply-To: <20140509055024.GB30674@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248520>

Eric Wong wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
> > No updates since 2010, and no tests.
> 
> Who benefits from this removal?  Is this causing a maintenance
> burden for Junio?

It is cruft that nobody uses and we are not even testing.

> > Plus, foreign SCM tools should live out-of-tree anyway.
> 
> Even if so, there ought to be a transitionary period in case there are
> any users.  We would need to warn potential users of its impending
> removal in the documentation and at runtime.

All right, so you are OK with adding deprecation warnings whenever the
tool is run, and a note in the documentation?

For how many releases?

-- 
Felipe Contreras
