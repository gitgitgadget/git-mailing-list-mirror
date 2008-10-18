From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT 0.14.3: extra space is added before e-mail on export after "stg edit"
Date: Sat, 18 Oct 2008 09:48:19 +0100
Message-ID: <b0943d9e0810180148k4ba5bb2bgf3c5cdb2358b9419@mail.gmail.com>
References: <200810152025.19995.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andrey Borzenkov" <arvidjaar@mail.ru>
X-From: git-owner@vger.kernel.org Sat Oct 18 10:49:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr7V7-0002dC-HR
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 10:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbYJRIsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 04:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbYJRIsU
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 04:48:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:22616 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYJRIsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 04:48:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so952004rvb.1
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DOgiEFoB5aHyN46HrekdXfdrhLpcGBTP9lYPpTFm9Wo=;
        b=QxOpGrlQZC8IXlr+VItxahiS7QoI+TJJ4/V+PTsIZQ+3BAebfHQ7BTrAVxUXaoCloY
         r/MkYIoSDOzCy/K4RY/A+Usr2WIRm/X9tSveSZ9QAmYuBJ1zgzQ1f8Pa3E7K8k7HmqJC
         Hs4CuW80zfWy+EELMfra4jgQ+dn3q049Y7vN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h67lmMM93WvqeeTCeveWE+/UiSbR8RIsO/XMr8WB1AdMJRmJyF8d5tyKlauvYg4qV6
         OzuY5NSLUOevbKkM//ENR+dsdVE/s/VRWemU1ek5EKWzApyvgXAzwBa1X8z6YsObh4Qc
         o/+DvLz92o1sekJEY/cyiot1t/MJp+JZw8alI=
Received: by 10.141.164.13 with SMTP id r13mr3157252rvo.150.1224319699093;
        Sat, 18 Oct 2008 01:48:19 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Sat, 18 Oct 2008 01:48:19 -0700 (PDT)
In-Reply-To: <200810152025.19995.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98530>

2008/10/15 Andrey Borzenkov <arvidjaar@mail.ru>:
> Funny problem. I have following export template:
>
> Subject: [PATCH] %(shortdescr)s
> From: %(authname)s %(authemail)s
>
> %(longdescr)s
> Signed-off-by: %(authname)s %(authemail)s

The default templates contain "%(authname)s <%(authemail)s>", i.e.
with the angle brackets arount authemail and I've never seen this
problem. Does it work if you change them (or use the default
templates)?

-- 
Catalin
