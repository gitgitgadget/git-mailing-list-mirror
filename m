From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 0/4] http cleanups
Date: Wed,  4 May 2011 18:11:32 +0800
Message-ID: <1304503896-5988-1-git-send-email-rctay89@gmail.com>
References: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dan McGee <dpmcgee@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 12:11:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHZ3c-0002kt-Dw
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 12:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159Ab1EDKLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 06:11:43 -0400
Received: from mail-px0-f170.google.com ([209.85.212.170]:56238 "EHLO
	mail-px0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab1EDKLn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 06:11:43 -0400
Received: by pxi19 with SMTP id 19so734544pxi.1
        for <git@vger.kernel.org>; Wed, 04 May 2011 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Roj2yDtTUrv9G5Y9355cvYyrDuPhjNX4lCbejWAyv1k=;
        b=Py3Y5SmMmP6gqXouNPRc56obfq+exxAx2dYzUbifRl/VJzkcmkqjf8V0wKOgoDaj+k
         gmfTjRYt2ED3e7AtnS9BsBCjtXZBsPKcwY2GFNJTm+omCbZEQN7iJ+kxigjeYlpQoWex
         rRQ2pu2vIseOTO8Wq0bX02pr1+EBxUbXSj+8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bQe94HsIaZ0x1BA5Q8HousqYHQFQGHVex8bmLx+d9BS33UVdKa6uF7eEnU7pwDAziQ
         QfRN1/nJHQsqQSZlRZD8TsGNmMlVYyYhORkHRhJuxI5uiNDzRAQS3XXtZw48NQ6mPK8p
         9bZc+kMrOtaknooPifX0AA3ljUavAaEKqTalY=
Received: by 10.68.15.134 with SMTP id x6mr1290947pbc.308.1304503902704;
        Wed, 04 May 2011 03:11:42 -0700 (PDT)
Received: from localhost.localdomain (cm134.beta238.maxonline.com.sg [116.86.238.134])
        by mx.google.com with ESMTPS id y5sm643190pbq.57.2011.05.04.03.11.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 03:11:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.585.g74f6e
In-Reply-To: <1304437649-7052-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172733>

Only patch #1 has been changed.

[1/4] t5541-http-push: add test for chunked
[2/4] http: make curl callbacks match contracts from curl header
[3/4] http-push: use const for strings in signatures
[4/4] http-push: refactor curl_easy_setup madness

-- 
1.7.3.3.585.g74f6e
