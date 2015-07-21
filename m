From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 0/7] refs backend preamble
Date: Tue, 21 Jul 2015 11:44:57 -0400
Message-ID: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 17:45:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHZjO-0003uu-Ny
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 17:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933104AbbGUPpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 11:45:14 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35340 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755654AbbGUPpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 11:45:11 -0400
Received: by qgii95 with SMTP id i95so58553057qgi.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 08:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ZOtmtS/IgeivDpVB/Ae0taLcaE0OeMMJ+ydxuVAsj8Y=;
        b=JrE2Tsyb2aM7EGSEVKBh7m+4HZ79k6pHNdQj11qTCzMMP9axIheHIt6hTsQRBw1jpa
         MihconFBn/3LkPCl8YmgbMvD5uXCqX1TrhXwcwJbxIQ0uLcnHXAS8N1B3vUjbRHB9vOC
         Te5AlabiYrAvtvoPIHFbx10OWHCboQpFBPlEQ7QbH+jXZcOZiSqrCCRGEO7KOhvrJtOO
         zQoNm6kYBPnPvJ3XywuaUKm41hGaaeO/hgWREOwFdITqM6Uq6T6nTBfkLPZ0pMjGG1R1
         8KrJa2Q9MX054nnCOUjI3J9QggFO38Tm23XZN7tXmHsi330Gp4J67Q/8ihZw8AA8pkkf
         czsQ==
X-Gm-Message-State: ALoCoQm0VI8ZNomhqYmkoCvGBeRJwYiXY96RxLXJ9szrXMfO1pjbXuXNFE2tgU1PtQGEbwoGDG9b
X-Received: by 10.140.100.247 with SMTP id s110mr19515260qge.36.1437493510263;
        Tue, 21 Jul 2015 08:45:10 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g33sm12941288qgg.4.2015.07.21.08.45.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 08:45:09 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.586.g889ef79-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274380>

This reroll addresses Michael Haggerty's comments:

- Error messages are now in the form error: reason
- We no longer unnecessarily set errno in write_ref_to_lockfile
- Corrected a spelling error in the new docs and another in the tests
- Corrected some copypasta in a test.
