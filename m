From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 0/7] refs backend preamble
Date: Mon, 29 Jun 2015 13:54:21 -0400
Message-ID: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 19:54:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dGU-0005jJ-DM
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbF2Ryj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 13:54:39 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34464 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbbF2Ryh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:54:37 -0400
Received: by qgii30 with SMTP id i30so9497519qgi.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=w4+/r45/b7etoCXI1m/B/hXzwYNOvMXtznv4Gt+w6zo=;
        b=R2ihFXjHvFDeY0rV8HuFQ34s9KDGaxM7KE6bo5WwpFYvYMjxqbv3uCccUur85RQWKU
         EPSMoIjMhTo1bsLKjdmbd25NBfyv0ToUNj0E9s6u0Tl3lTpCjHaKI199fGiiqN6nBcDc
         XL4RM2TLnsIeoDw94ZWI1eoLwpVFn7HMNARDGXn767A4XylIj9mDk6JqZWvOS750Ox4y
         BRO/GN0vAuH1R+jLDWBiF0NHMx9IEL5v042CrYqE3ronuWR86z8n1GcxRp2yyR4JDMYo
         qr8sSOo/2LpfdqVkF5rgS9fWJ5KFGScDadvN/qpwQxUIhYiyTU7nNfNhqyt5e2sl+39d
         Z39A==
X-Gm-Message-State: ALoCoQlycE4vdMZlJCJpY+5Nk1rnbMSHsxO54rcPLj5LWS9f9ytNQ6yTJ0Uc46dxtYPTMsUwEEIK
X-Received: by 10.55.40.214 with SMTP id o83mr34506470qko.106.1435600476875;
        Mon, 29 Jun 2015 10:54:36 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id w67sm11860026qgw.41.2015.06.29.10.54.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 10:54:35 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272980>

This splits v4's patch 4/6 into two patches.
