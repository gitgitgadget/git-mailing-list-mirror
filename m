From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Wishlist: git fetch --reference
Date: Fri, 22 Aug 2014 09:01:58 +0200
Message-ID: <1408690918.5586.3.camel@seahawk>
References: <53F6B1AB.3030706@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Chu <hyc@symas.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 09:02:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKirR-0003WF-Ap
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 09:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbaHVHCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 03:02:05 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:50722 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbaHVHCD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 03:02:03 -0400
Received: by mail-lb0-f175.google.com with SMTP id 10so9234199lbg.34
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 00:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=OLX6GY5wvLaDo9AAy8urwVL9H7yrZX1hzr5Sr2JiwzE=;
        b=OJFc3vt+Do2MoCG/aRPfsju1SOG7xC2aipBfl2EcO1vDYrm9958n6OHik7qG2vYAFy
         myKd0eV1ELeXbGk7lgLhIWeyDzyDnJV0Mb+yJwLwwB9ni3kMRrv5rdy1oCnk6K2NQh+T
         Y83Hlayboc5z6tBe3yPYFQ4QGNdlvbQgi9RW+Hk7lK6KR6fk9HydSL1oXFOJKrIjsMcI
         62J2kMX7V1bTDchQTui1IelSNwwnUwHjayqM5BX1jMi6dcqDKTueiaVIRyeh4059aV5i
         mYbzy2W0zDI4lgtIqvBRQfcQDF6sZcQEvGNdWDve2S+D+Nas985eAlLBAPZ+v7vzEIwn
         Qgyw==
X-Gm-Message-State: ALoCoQms0e3/YPSOFPyO2RYRUzdSEjmD+hULcX7rWMnH5EfndYM6FGlougCq9mXe6kMY6YSTf7WU
X-Received: by 10.152.19.5 with SMTP id a5mr2968103lae.21.1408690921461;
        Fri, 22 Aug 2014 00:02:01 -0700 (PDT)
Received: from [10.155.73.62] (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id sl2sm45658769lbb.33.2014.08.22.00.01.59
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 22 Aug 2014 00:02:00 -0700 (PDT)
In-Reply-To: <53F6B1AB.3030706@symas.com>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255664>

On do, 2014-08-21 at 19:57 -0700, Howard Chu wrote:
> I maintain multiple copies of the same repo because I keep each one checked 
> out to different branch/rev levels. It would be nice if, similar to clone 
> --reference, we could also use git fetch --reference to reference a local repo 
> when doing a fetch to pull in updates.

Alternatively, you can use Duy's multiple-work-trees patches to safely
make multiple checkouts of one repository. These patches are in next.  
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
