From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fwd: permission to re-license strbuf subsystem as LGPL
Date: Fri, 23 Sep 2011 17:16:11 -0500
Message-ID: <20110923221611.GA2548@elie>
References: <CA+sFfMeRDQiqGhO9Y=k3tEnzdXjMx59huFE_fx6Y14cJxj1J=Q@mail.gmail.com>
 <CA+sFfMcmsKkKM7C0g4vKmjmCCNqRHuvz-hwEHAm=+stqnOPpAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 00:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7E2h-0003o9-Lj
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 00:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab1IWWQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 18:16:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55228 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab1IWWQT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 18:16:19 -0400
Received: by gyg10 with SMTP id 10so2885072gyg.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hnVurzxhJhmhWeP1B2MA+O2qYjbyh87OH5abwEXveME=;
        b=jizzT4RXoiw0V5IE/ZZYiWHv1RWTgsq+sj4VAgwm7w2HK5JyOZUYt55QWOTcKaDTv3
         CNsNjGjDSnectcyhptAq8NoA+7h0HuwBmezQFdQcjDY880YIvpIebm4JoARYCxaZCwR6
         Lbpv+OYONsNnh4J6p4xMu87KTCf/BzW4e2DLQ=
Received: by 10.236.115.70 with SMTP id d46mr25225071yhh.83.1316816178474;
        Fri, 23 Sep 2011 15:16:18 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id g66sm18272012yhh.12.2011.09.23.15.16.17
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 15:16:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+sFfMcmsKkKM7C0g4vKmjmCCNqRHuvz-hwEHAm=+stqnOPpAw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182007>

Brandon Casey wrote:

> Jonathan Nieder suggested using a more permissive license than LGPL.
> BSD seems to have the most support.  If the remaining contributors
> agree, then I'm fine with licensing under BSD.

A few words of clarification.  My opinion shouldn't matter much here
--- I am more of a bystander and user than a contributor to strbuf. :)

The main reason I suggested a permissive license is that the strbuf
lib contains some inline functions and I do not want it to be
complicated to use them.  To comply with the LGPL, in addition to
releasing any changes made to the library, distributors usually do one
of a few things:

 a. offer the source code for your work that uses the library in
    addition to any binaries,

 b. use dynamic linking, or

 c. provide object files for your work that uses the library, so it
    can be re-linked against a modified version of the library.

(b) and (c) don't handle inline functions.  Luckily, there is a way out:

 d. only use the inline functions from within a subset of your work
    for which you are willing to provide source.  Dynamically link to
    it or provide object files to allow re-linking.

With that in mind, I have nothing against the use of the LGPL here
(and one of the two main authors of the strbuf lib explained a good
reason to prefer it over the BSD license).  The inline functions in
the strbuf lib are pretty small, so the above was probably not too
important in the first place.

Thanks, and sorry for the unnecessary noise.

Regards,
Jonathan
