From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 0/3]
Date: Thu, 14 May 2015 16:17:16 -0400
Message-ID: <1431634639-4942-1-git-send-email-dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 22:17:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YszZZ-0007QN-7z
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbbENURc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:17:32 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36022 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964934AbbENURc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:17:32 -0400
Received: by qgg76 with SMTP id 76so17229366qgg.3
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Y1TBuOg9uP2kWCD6eDpYeCVciG76F4sw8Sq9POPF6rc=;
        b=mYWcCZ5PNlSezlscuNNGFC2sGS2TpuEQVu0Yr1pYT0FMVtaYWxDGF5gKZFQfQQSo14
         VXUSyiBo22Nkli4vf5ktV9K+bIU3olYU7nNPPXLJyfqgeVifhzfJ8xq6WgKC2a8lELzH
         IhLS9wqWJvUMbqAcJVJn29pr2RtinnYxkb+8q8PcR9XqlqEcr1QRr1ZdwSKBf+BVYs/o
         zrA9q+uwf8FFe19/JjLLR76AWXzpe5XvgboT3SqcRwMfscRQO5EhJYrDd54je5Oi84qo
         1Y3UxNvJ779Aya1qEu40ujvPTBQaAw3t/DW4B50zGlvk/b+hY4ZRExO5wPk2q5+zlBpl
         KpqQ==
X-Gm-Message-State: ALoCoQl/Biu23e8GDoURjKWPlXQfvqzgG0nXGfsLLxWN1NyS9QL9Cawhlw+8YIFFsHv6DAmBhxhL
X-Received: by 10.55.40.91 with SMTP id o88mr12975067qkh.65.1431634651389;
        Thu, 14 May 2015 13:17:31 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id i91sm47777qgd.46.2015.05.14.13.17.30
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 13:17:30 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269080>

Change text explaining that --follow-symlinks only works with
--batch{-check,}; now it is presented as a missing feature rather than
a necessary evil.
