From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: git branch -v output ambiguous for parser
Date: Thu, 23 Jul 2015 15:44:34 +0200
Message-ID: <1437659074.25048.11.camel@kaarsemaker.net>
References: <CAByu6UVzsoK=OHkYv_zBCYf2YnBqx268TZ+_pi98N6pMt_NSgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thibault Kruse <tibokruse@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 15:44:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIGnk-0003NI-UW
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 15:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbbGWNol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 09:44:41 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33668 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbbGWNoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 09:44:39 -0400
Received: by wicmv11 with SMTP id mv11so24827973wic.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 06:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=MHMb0p/wRSFECtZDujuvSb96d6Jx3SzFk8XCJcZLzdw=;
        b=FqURxpsnsJLubsbFeC/xWXhGQonWmqzrbdPOMyh8o7xA70UZxo6/BCFGQtsxAAov8k
         cGG9uZ6gOR7nnKOgQZAUTG3LBphSCNqzI4GMrr91lpbuuUKeoXu8htL968DkDimjoJlV
         BmFr0fFnAT2X/DrmujKSWwsxgz147gEu/nZCGyBP5SoHwYJWMHauJKJT0lFVFi/gpws6
         2NtqOJFR1lqTnh6hGV/v1KvoqEmQf3gFvLg4QuvSkfj1AAdkT2jRrZP2ykg0eVIQ7+Vr
         aTTaonh0W+1dTnEzmRS31khDHNKBr1aB/vPQ53hzKVxNRncTMIOLDM+XNrSRk7+DEQkZ
         POOg==
X-Gm-Message-State: ALoCoQkm9qeiJPGhuFmeZbn7iYteTvEUCqhCL3oV/4FCd8KqYk31sgTNU52ItZoTIKu40hL1/nK6
X-Received: by 10.194.2.51 with SMTP id 19mr17234765wjr.40.1437659077033;
        Thu, 23 Jul 2015 06:44:37 -0700 (PDT)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id lq9sm7610384wjb.35.2015.07.23.06.44.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jul 2015 06:44:36 -0700 (PDT)
In-Reply-To: <CAByu6UVzsoK=OHkYv_zBCYf2YnBqx268TZ+_pi98N6pMt_NSgw@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274496>

On do, 2015-07-23 at 15:29 +0200, Thibault Kruse wrote:
> Hi,
> 
> trying to write a git wrapper, I wanted to parse the output of git branch -v

The output of git branch is not meant to be machine-parsed. Try using
git for-each-ref :)
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
