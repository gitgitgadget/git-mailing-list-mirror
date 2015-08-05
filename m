From: David Turner <dturner@twopensource.com>
Subject: Re: What's cooking in git.git
Date: Wed, 05 Aug 2015 19:14:13 -0400
Organization: Twitter
Message-ID: <1438816453.10324.0.camel@twopensource.com>
References: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 01:14:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN7t7-0004Il-3e
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 01:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbbHEXOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 19:14:16 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35971 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbbHEXOO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 19:14:14 -0400
Received: by qgeh16 with SMTP id h16so41596366qge.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 16:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=NAdYY7oUenAsaGW0VxTXzTNgleUKmPi5prjc7L2kyIo=;
        b=jnrN8QsXCSDlV4YU1tiF/DgbAasSJowlnFIeOFkjjbr3xwLjOKH6cwadvXl8TrHu8w
         cmaz1BXBaV4JlIpMhspoPvjl15peRDO3O03fcJ2uVVyXTnszhx+elrswnh40plW7Nk56
         r4sSD3izcRvukSWYHfvMB4E6aosjqWZJ3HIaqNO2dEw+vbxCxh5yJQEPOtXSVCfOYrOv
         IZnLGocEpWI7te+agkCq3Gf5waLkgJB8a5OnxNAC42yTWn5TjbPpzixSJkMtaxRYHBRi
         U9YX31aEvs0iujBzsFImv0tXfOsGQaMvkuoDChORKqm+m26WLFWcrHj6JwQK712cV0C5
         C9pQ==
X-Gm-Message-State: ALoCoQkegvts9LhhTSdxCcN/ju6+HC1sndNtRbQPz2/bH1TRmlnAHPmx79si7BFVtY6fAx+K1lFu
X-Received: by 10.140.106.137 with SMTP id e9mr15279741qgf.106.1438816454094;
        Wed, 05 Aug 2015 16:14:14 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 4sm2211526qhs.4.2015.08.05.16.14.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2015 16:14:13 -0700 (PDT)
In-Reply-To: <xmqqoail1h2c.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275408>

On Wed, 2015-08-05 at 15:55 -0700, Junio C Hamano wrote:
> * dt/untracked-subdir (2015-08-05) 2 commits
>  - DONTMERGE: Waiting for an Ack from Duy
>  - untracked-cache: fix subdirectory handling
>  (this branch uses dt/untracked-sparse.)
> 
>  This seems to break some tests.

All tests pass for me locally.  What's broken for you?
