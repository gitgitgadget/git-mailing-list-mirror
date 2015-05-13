From: dturner@twopensource.com
Subject: [PATCH v7 0/3]
Date: Tue, 12 May 2015 21:49:56 -0400
Message-ID: <1431481799-23560-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 03:50:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsLoO-0001GJ-7g
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 03:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbbEMBuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 21:50:11 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36051 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964922AbbEMBuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 21:50:10 -0400
Received: by iepk2 with SMTP id k2so17772308iep.3
        for <git@vger.kernel.org>; Tue, 12 May 2015 18:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=kR/iyfrFjgok7jwCeEi/jvlr2TsxyhSgKGKaEbnxUNw=;
        b=HOCQsFevIff3K8BtXtPHDr3Lco0jHji9PqZKwyiWjEPgSi669yxHPYW/Ba+QH6rBCH
         1/LSg89ETsdNzPR9NOUEBs+CGE5dVnB9/gPv+Sf3AXM/CRVMa7aeA03XNmpydY9+n49/
         gsYgT8JKQBNWpkwO3codrB59j9Q+2F/WjzAhQ6sp07mVHc4XcKyWuteN/mBUMzbkTOyq
         O53g8yN22zCbSlPExhYDp2zji6wH0bL8mjQyXWQOLVDb2cyyS+hVSYZ3E/Y8dmdrlqi6
         Uk0mhn4p7nu9dhcWcEioiWi2Asp09gX6Mw1hVq3+uVcS2HzbxWqPCd5kSbwCIhUF3CoV
         vLbQ==
X-Gm-Message-State: ALoCoQnpnrefFvt4OjRVNqTTX6bJGgsdE6EgQ6D8xtHNyLOte3p9PfbR+Lg22XS/DBfnKeq6cDeC
X-Received: by 10.50.4.66 with SMTP id i2mr12665033igi.40.1431481809737;
        Tue, 12 May 2015 18:50:09 -0700 (PDT)
Received: from ubuntu.twitter.corp ([8.25.196.25])
        by mx.google.com with ESMTPSA id s5sm2534656igh.6.2015.05.12.18.50.07
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 May 2015 18:50:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268913>

This version of the patch adds improved error outputs for various
weird situations that can come up during symlink resolution.  It
also improves the documentation, following suggestions by Junio Hamano.
