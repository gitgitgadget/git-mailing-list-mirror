From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 0/6] refs backend preamble
Date: Sat, 27 Jun 2015 00:23:50 -0400
Message-ID: <1435379036-30894-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Jun 27 06:24:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8hfY-0005t5-RC
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 06:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbbF0EYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 00:24:23 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36435 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbbF0EYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 00:24:21 -0400
Received: by igrv9 with SMTP id v9so1317595igr.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 21:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=DMn9RZ5i3NYo/czwDMcJjkGlfT48Bkbc3LkFmGZHdI4=;
        b=X4K5iLzBhirwbXKpw/X2h3aEFlOlsutxvgQmWZrI3md++D9k9uIR+SQbwR0XbRcVNu
         zJKfnCPyG0iGwgwdEsLNC1vbxXQdXb2YYn85TB62JPpzhM0RhNDIHqJKWSZoMIGlriQ4
         h3libquUMsc1P36PJwssl8rbqqLiUVv0sABsn3fqqBJ8xCi7YbxLOLeuVior5Obue8kf
         1I2Mlcuk67Vn/L42pRAVAe+9pDVhDPIZy+AHiW5GM0kUHBIqY5sHX5OSKYD2N29J5ORw
         CCCeOqTNMjPeM6aIMtLqxHO2dOBV+jbb/vDfNKRcNq/1TYJWLWLbMqTTSJJ/uxyx0SSG
         +S4A==
X-Gm-Message-State: ALoCoQlIe/+3PlZZm4buSMlMK7rbr31rZ648kuCgPEhtFFrKOhxkEF6e3h7nN2zIOubNoJawsgob
X-Received: by 10.43.54.20 with SMTP id vs20mr6901460icb.96.1435379061177;
        Fri, 26 Jun 2015 21:24:21 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id k74sm22930720iok.30.2015.06.26.21.24.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jun 2015 21:24:20 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272844>

This version addresses Junio's comments on v3.
