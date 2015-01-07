From: Reuben Hawkins <reubenhwk@gmail.com>
Subject: v2 patches for fixes on RHEL3
Date: Wed,  7 Jan 2015 12:23:53 -0800
Message-ID: <1420662236-27593-1-git-send-email-reubenhwk@gmail.com>
References: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 21:24:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8x9f-0003GZ-H7
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbbAGUY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:24:29 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:52075 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbAGUY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:24:29 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so7010112pad.9
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=y9srtMU2Jypk80ITObo+HJeDogp23YJ/K3Rv6U5alwM=;
        b=eBbg7Ut83qAxsUsTGh7rGC10VCVh/GmV4/3+V7PjSQwMqfN9/q0H9foEXKLIvdsaey
         Dh+cB3/eXJ5C2AAHRsBROWi7FutKey9G/NoamnwSj+grkSTzb+X8x/8+IKD2mWHWLMYR
         +rX0gu93rsMA8B26/oSrCnNKiEhR0D6CIhmw1Ylqo8rMGckOV+s/MjzzJFeLeUSwGL3i
         TVGmSeCLURzziWDZAbWyS1R+eXAaoSf0hAQL2+uNPtOno1hYUVpCmfDZdZn57MU5Vrl9
         HXjajjLM8iSkUUhSN5MjK/u/uhshcjZAnE3Qbf6amb3e/Zlycu1eH1kAJTpHKvNDHrAQ
         ge8A==
X-Received: by 10.70.52.234 with SMTP id w10mr8683084pdo.50.1420662268117;
        Wed, 07 Jan 2015 12:24:28 -0800 (PST)
Received: from zoidberg.san.rr.com (cpe-76-88-40-245.san.res.rr.com. [76.88.40.245])
        by mx.google.com with ESMTPSA id j15sm2585869pdk.49.2015.01.07.12.24.27
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Jan 2015 12:24:27 -0800 (PST)
X-Mailer: git-send-email 2.2.0.68.g8f72f0c.dirty
In-Reply-To: <CAPig+cSFAzsUj2sOaCyPTu_U8_c5qkF1qQo4nzecVzY0TqmJpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262153>

These patches add a few autoconfig checks for nanosecond resolution fields in
struct stat, CLOCK_MONOTONIC, and HMAC_CTX_cleanup.  I'm fairly sure I've fixed
the concerns/doubts the first set of patched raised.

(I rarely use git-send-email so forgive me if I botch this)
