From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/9] test-lib.sh: convert $TEST_DIRECTORY to an
 absolute path
Date: Tue, 12 Nov 2013 14:25:39 -0600
Message-ID: <52828ec367a97_3b98795e78fc@nysa.notmuch>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384235688-9655-3-git-send-email-rhansen@bbn.com>
 <5281C522.7050403@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: Richard Hansen <rhansen@bbn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 21:34:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgKfJ-0001X4-DW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 21:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695Ab3KLUeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 15:34:22 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:56681 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab3KLUeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 15:34:20 -0500
Received: by mail-oa0-f47.google.com with SMTP id i7so2290106oag.6
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 12:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=mb6gM5a+6gcHxdABvX4/HF4FQ+1Rc8wmORfea1vz9dE=;
        b=dyzRD6MJUMStOLaA6QrpndR1n+mV8Le5JPdKB5jaN/qvYjZDSEONH2o7l0SNoFqkaI
         n2WT6v84lCh9o4Uva1PyCE3BUQOJJ7qvFuidXv6NQLwG/4XaWHpKIqPWYaJ7VBYDjlk3
         DaOo2vQ149QfEHnVi8WoTiwYMEUkt8xWzuiWLQYmJXX9Qja245K1w9o8fChugcEcYWV4
         BVJ1vsxFRpU6JgL2jdkrUoHgqte+jcAwbg+SoEtTDK1rphhk0YoYV32iDMebevcq00oj
         8n5xRWhIpmXidVBjdgAur3G/STadHLi7RrVaTyS+fLWItmMRIoRa8kiqg/VgllZer1io
         aShQ==
X-Received: by 10.60.62.242 with SMTP id b18mr3290803oes.85.1384288460136;
        Tue, 12 Nov 2013 12:34:20 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm35167035obc.12.2013.11.12.12.34.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 12:34:19 -0800 (PST)
In-Reply-To: <5281C522.7050403@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237733>

Richard Hansen wrote:
> On 2013-11-12 00:54, Richard Hansen wrote:
> > If $TEST_DIRECTORY is specified in the environment, convert the value
> > to an absolute path to ensure that it remains valid even when 'cd' is
> > used.
> > 
> > Signed-off-by: Richard Hansen <rhansen@bbn.com>
> 
> Actually, credit for this and the next patch should go to Felipe.  How
> should I note that?

Normally what I would do is put myself as the author, but not s-o-b, but since
now I'm telling you you can add my s-o-b, you can do that.

I would have sent those patches myself, if Junio agreed that was the way to go,
but I didn't see that.

Cheers.

-- 
Felipe Contreras
