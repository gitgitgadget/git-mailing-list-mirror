From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 07/25] contrib: remove 'git-jump'
Date: Thu, 08 May 2014 21:12:36 -0500
Message-ID: <536c399454062_741a161d31099@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-8-git-send-email-felipe.contreras@gmail.com>
 <20140509020350.GD9787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 04:23:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiaTD-0004YG-4c
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbaEICX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:23:27 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:55342 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbaEICX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:23:26 -0400
Received: by mail-yh0-f46.google.com with SMTP id 29so3184754yhl.19
        for <git@vger.kernel.org>; Thu, 08 May 2014 19:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=GzstgfdBB9zCsW2NzNQUXWfCNoDKPtMdyUUJ7dGTxLg=;
        b=sxz3iay6+UVuJXZFsDYLqcI5zblLaX2lDUABzdmeBIYdwS2qQGLKP239u36If4aTWj
         ZlOXnHLiJ4RDqrMHUBw35K8PNlpg8BSxtFlZLMPgMAXsGLxeJLp5B1A0jTwWhkgev22W
         VjWTPRjo/U24zF/VWEMBu2YadU6LIqEvupsJZk1wf9+/73z492FU5gSdKNDCgc0vwr0J
         wR44ddg9JA349CObem2qMB0rlO6jzxrTd6D/YJXLSFlkkWEoz5jOFxWn4nh+OOrfd1/k
         94cTaSYzv4c0z6sos0xJLunPWToqxvEyowatJdcqn3CSDbqBCdIBk958EnrZ7w0wl/1W
         MOow==
X-Received: by 10.236.199.212 with SMTP id x60mr10694603yhn.90.1399602205757;
        Thu, 08 May 2014 19:23:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id k7sm4164683yhj.31.2014.05.08.19.23.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 19:23:24 -0700 (PDT)
In-Reply-To: <20140509020350.GD9787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248505>

Jeff King wrote:
> On Thu, May 08, 2014 at 07:58:18PM -0500, Felipe Contreras wrote:
> 
> > No activity, no tests.
> 
> Like diff-highlight, I don't think "no activity" is a useful indicator.
> I use this daily, and several people have commented off-list to me that
> they use it, too.

Add tests then.

It this is never meant to move to the core, then it should go
out-of-tree anyway.

-- 
Felipe Contreras
