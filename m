From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Fri, 25 Sep 2015 05:14:35 +0200
Message-ID: <1443150875.3042.3.camel@kaarsemaker.net>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
	 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 25 05:15:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfJTQ-0008Ig-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 05:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbbIYDOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 23:14:40 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34955 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728AbbIYDOk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 23:14:40 -0400
Received: by wicge5 with SMTP id ge5so2514038wic.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 20:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=zy5ZSBtdfyITifbTM2jOtcko7Ky+curI/7xtZhpx8Gw=;
        b=V+p8mCE/QtMQ24C85YGf/wN0Qdebholm4oHiwBi+w9rhGEvsq/OBDAxdzklRe7fCQY
         A4VhfQ9u6UXIGQCS/uOpWExgdsi6yL1M4c/YF/mY3v7C/v/FH0Ge6K5NnhLyj15EGZ4C
         VNo/ayPecx1Ft9Wh7n9IkpiSQX/3IQHG0JpN7KUDphdjYEAswq25swPDJNg8wH4yzUUE
         /Lb8A2IYrZAl6tFVyIJbVrsOv/68U0mdw+elAEKdahj/ODE0UuXXZfoQN2gKjVYmrG/h
         y+h1ZL/EMhU+5X3vfbu076qIPG/QOPgGhGIVNZVRiOO/YCdXlBMxBVDuO0b29+OkkDYO
         /o9w==
X-Gm-Message-State: ALoCoQkyAMd6BCUscwkCdz7PuL4OhiXhSnvrAfE6Q7WGuuEpSuozMYlzfJjgIT84S66L7NPQBTlC
X-Received: by 10.194.143.102 with SMTP id sd6mr3638203wjb.15.1443150877599;
        Thu, 24 Sep 2015 20:14:37 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by smtp.gmail.com with ESMTPSA id fu5sm5874305wic.0.2015.09.24.20.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2015 20:14:36 -0700 (PDT)
In-Reply-To: <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278648>

On do, 2015-09-24 at 17:41 -0700, Junio C Hamano wrote:
> larsxschneider@gmail.com writes:
> 
> > My idea is that the owner of "https://github.com/git/git" enables this account
> > for Travis (it's free!). Then we would automatically get the test state for all
> > official branches.
> 
> The last time I heard about this "it's free" thing, I thought I
> heard that it wants write access to the repository.

It does not need write access to the git data, only to auxiliary GitHub
data: commit status and deployment status (where it can put "this
commit failed tests"), repository hooks (to set up build triggers),
team membership (ro) and email addresses (ro).
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
