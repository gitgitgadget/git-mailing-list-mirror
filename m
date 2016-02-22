From: larsxschneider@gmail.com
Subject: [PATCH v6 squash 0/2] config: add '--sources' option to print the source of a config value
Date: Mon, 22 Feb 2016 10:23:44 +0100
Message-ID: <1456133026-15355-1-git-send-email-larsxschneider@gmail.com>
References: <xmqqd1rsd0ac.fsf@gitster.mtv.corp.google.com>
Cc: gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 10:24:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXmil-0004Tv-EA
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 10:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbcBVJX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 04:23:56 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35584 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbcBVJXu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 04:23:50 -0500
Received: by mail-wm0-f43.google.com with SMTP id c200so160869737wme.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 01:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SF9WjVLE4+vlnaJjTjrS80Rtw1YcCAr46i9dd9cSsjE=;
        b=F9IO/7fEN9KnoF1JyhEHzz1eufFfhxsCtU4TDFgA3TAjirBTkxhumTNLCcBaCYvzkP
         WaOS9kJ7NDQ4SY0KI2BMLOJ6TdZ5dgGAWC6T6/BtQk16OaxhJNzpUMPNt1g8jqfCOf5U
         IMq9PZPfrtSTR227nj0/JiObDcJtA3u55t7vgtd+ri6+b9C6OXzDqvPpEWCtwXoZ7dhp
         PeNJN/6bdB14gt67gpdtIhJLh3AtUgVR67ewQq0om9B3CyJh/5rUYaVVXYaARKrlduBZ
         T/uLFTRjZhixoSpn0yYG2gQJkQCSYiEDm9aQFOxFzGNrBpnWMMh4nfNJg2XbN3Xasw7Y
         5l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SF9WjVLE4+vlnaJjTjrS80Rtw1YcCAr46i9dd9cSsjE=;
        b=QbbGvzoDr0yCsnzvmJXl+d6uN4sWWT5RSOrUZqz4Xwu0IJ0RLHQF1X38q9xcX/+0Fe
         BAcyHn+Vly+8QlgQeVjWMQs7vgF713m7+6ensz0ewzmmUj7U29tEI80MZJv1YbGUEVlF
         Inmw8qChZli/9XGUGdWFDqkbGlu1fo8ftj2Gbu3J75y/8eN8vlDrvQ0bVusXyUkTD2E+
         HLOlv8oQ8C3q9+Z0HMFoQZiCBrIU24EtTgfq4R0Wakk2eqVJseQXknQYXsYaJAZteHPi
         adK4wd+Sk+MrhaNSRXodCuQ8tyGEFHTSCC5931g1Vh6pEDSmUGGIWmpnrVbifcxlixB2
         mMxw==
X-Gm-Message-State: AG10YORFxp0FI+pl18do0N9f4Lejqwl84S2b/Ew2wko6Dj8pyGOKd53GnoTpAP3tMopE9Q==
X-Received: by 10.194.185.144 with SMTP id fc16mr26520895wjc.123.1456133028999;
        Mon, 22 Feb 2016 01:23:48 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB49D4.dip0.t-ipconnect.de. [93.219.73.212])
        by smtp.gmail.com with ESMTPSA id g126sm20054279wmf.16.2016.02.22.01.23.47
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 Feb 2016 01:23:48 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <xmqqd1rsd0ac.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286896>

From: Lars Schneider <larsxschneider@gmail.com>

Hi Junio,

please squash these two patches into the corresponding patches from my v6
to spell out end user facing messages (response to [1], sorry gmane didn't
work for me).

I am not sure about the right way an answer with a "two patch" squash on
the mailing list. Please let me know if I should reroll the topic with
the squashed patches included.

Thanks,
Lars

[1] http://www.spinics.net/lists/git/msg268424.html

Lars Schneider (2):
  fixup: config: add 'origin_type' to config_source struct
  fixup: config: add '--show-origin' option to print the origin of a
    config value

 Documentation/git-config.txt | 5 +++--
 builtin/config.c             | 2 +-
 config.c                     | 4 ++--
 t/t1300-repo-config.sh       | 8 ++++----
 4 files changed, 10 insertions(+), 9 deletions(-)

--
2.5.1
