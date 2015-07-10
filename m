From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v8 0/7] ref backend preamble
Date: Fri, 10 Jul 2015 13:51:13 -0400
Organization: Twitter
Message-ID: <1436550673.4542.66.camel@twopensource.com>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
	 <8C71190FFE324B1599E89376429C8F84@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, j6t@kdbg.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 19:51:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDcSQ-0006G0-TH
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 19:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbbGJRvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 13:51:23 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:32944 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbbGJRvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 13:51:16 -0400
Received: by qgef3 with SMTP id f3so82820602qge.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 10:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=ATCvdfvrsOsn71vMLPcCjIDG0x/ENVh6+I0slP+WT0I=;
        b=hfhLs09yhAv247tuGc9/MTjA5mO6PFcIWTY2nYUFXhRGiNy03shiX7ehrQDS5SxoA4
         NuF5oqRoAMnyTF8MIbvzdPA8rb7QUoOz0MAIXoKMW/OUNQqli5jy3CnyvxuIelb4rN0J
         fpNhlEx/4vORLh/lGb5f8oIgCyQcp93pJ/HAINgsFkTwEvKoAsma4xiX94qyNwSxAjky
         EcrmeQIvgd3MpWhiJqwGsQAp+BUMeiJdDyCoBmXVhXp3bBiHXuA3kp3gbO7ykU1H/9AP
         IF9J1ROy2Lz1bFtFpBEZjUpGQC0SdYGDqUT5v/6QPR4Ts5B/Js+Q/rhIkkmITETyyFTL
         2+wQ==
X-Gm-Message-State: ALoCoQkcYJd1T0kP8glNlowbX6RUayx/d1vJAgQeW23mfhvC+fs7jIDxjdi2SYaxcMM/m3V5P3FG
X-Received: by 10.140.97.230 with SMTP id m93mr34959193qge.32.1436550676091;
        Fri, 10 Jul 2015 10:51:16 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p26sm5815314qkp.11.2015.07.10.10.51.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2015 10:51:15 -0700 (PDT)
In-Reply-To: <8C71190FFE324B1599E89376429C8F84@PhilipOakley>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273828>

On Fri, 2015-07-10 at 15:34 +0100, Philip Oakley wrote:
> From: "David Turner" <dturner@twopensource.com>
> > The current state of the discussion on alternate ref backends is that
> > we're going to continue to store pseudorefs (e.g. CHERRY_PICK_HEAD) as
> 
> Assuming this is accepted, should the definition of pseudorefs be 
> included in the gitglossary?
>
> Once ref backends become common, the distinction will needed in the 
> docs.

This term is only in this message (that is, I don't think I used it in
any commit messages yet).  The code uses it in at least one place
already.  But yes, I think if we decided to go with the pseudoref
concept, we should document it.
