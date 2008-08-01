From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Add Pascal/Delphi (.pas file) funcname pattern.
Date: Fri, 1 Aug 2008 16:40:49 -0400
Message-ID: <32541b130808011340j38715970k8dda59fc01ce6918@mail.gmail.com>
References: <1217619915-9331-1-git-send-email-apenwarr@gmail.com>
	 <20080801202059.GS32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:42:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1Rf-0006mU-83
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbYHAUkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbYHAUkv
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:40:51 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:6945 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbYHAUku (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 16:40:50 -0400
Received: by yw-out-2324.google.com with SMTP id 9so733079ywe.1
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=INMMFq7jU8rd2F9Xwv0YREHch1TqAF1diqQr6mLozyo=;
        b=Ff6cI82Cq54q989T9d5WZR27cbyv3xxeXF170oUdxp6JJ77fmPAFDTJY4HWl19dkwh
         1+84OwdTNviJ4Fc/a76rLhLljr4kq1ggGLRdzFOLo1j9DoN3ouPyYOcw8rr2FOJw3u6c
         gBEnIOrs0fXFaBN7T8uYwqDxAl+q4qcoKRM0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U78akXCRvHdlfy4goNy9HRIjn/NqJ159UuPHq8ZhHN8z41I0QlfKmSdYf5CYTFHm+V
         aUSMkJrtCUURLoZRMkxmzcgPI56ebEp9vCo6rVxjqh2T+RWe3wezw01ca/ivW5uPa+De
         Dw+cLOINoFM1eDN657rsRxHhXrOCOZuOKyM0I=
Received: by 10.151.150.20 with SMTP id c20mr3887359ybo.6.1217623249195;
        Fri, 01 Aug 2008 13:40:49 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Fri, 1 Aug 2008 13:40:49 -0700 (PDT)
In-Reply-To: <20080801202059.GS32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91096>

On 8/1/08, Petr Baudis <pasky@suse.cz> wrote:
> On Fri, Aug 01, 2008 at 03:45:15PM -0400, Avery Pennarun wrote:
>  > +     { "pas", "\\(^\\(procedure\\|function\\|constructor\\|"
>  > +                     "destructor\\|interface\\|implementation\\|"
>  > +                     "type|initialization|finalization\\).*$\\)"
>  > +                     "\\|\\(^.*=[ \t]*\\(class\\|record\\).*$\\)" },
>
> Wouldn't it be better to make the second pattern start on new line
>  instead of the outer \(\|\)?

I didn't even know that was possible, but suddenly I understand the
"java" pattern a lot better.  Thanks!

>  Why "type"?

Well, it's a subsection, but it's always followed by a class or record
definition anyway, so I guess it makes more sense to omit it, now that
you bring it up.

Have fun,

Avery
