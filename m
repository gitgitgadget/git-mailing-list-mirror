From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 21:14:16 -0400
Message-ID: <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
	 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
	 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
	 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 02:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSjyW-0002VP-Vr
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 02:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbXCRBOT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 21:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961AbXCRBOT
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 21:14:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:30489 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbXCRBOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 21:14:18 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1011483uga
        for <git@vger.kernel.org>; Sat, 17 Mar 2007 18:14:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ies6dYUazQOI0f7FxKF9ZcFaM1iBwCx+WGgv6PBzhdAcoIQa2UsfhduAj1AzZwG0g2VWKAIEmj8/4ATj65K6MSZ6IS3+UK+hKk46jmUgoS7JtRRXDVMyl5CdFh1O1ExTC02WBCsYsnhBxdK8J+H91ZMLpVzccZ/+9ubJ99m2ajg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pRXH/cfTI3Z3+oG0Lj1InA9TRXZZa0YkHkXsxx2bgzmVOaBCFAmQgm4Xj0aq7axPRRIt3HJzKJqaXtbZDyshSy8tjAhXw6XWAegHaFTGq/YZxpsls1fl4zy6KWz4dsMr56CcgvNslzhJHmM1DBGH7PqG9zDL1Ui4CXGJg6Ee8eU=
Received: by 10.64.210.3 with SMTP id i3mr5972853qbg.1174180456656;
        Sat, 17 Mar 2007 18:14:16 -0700 (PDT)
Received: by 10.115.109.10 with HTTP; Sat, 17 Mar 2007 18:14:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42463>

>         samples  %        app name                 symbol name
>         41527    15.6550  git                      strlen

Almost 16% in strlen?  Ugh!

That's a lot of strings, or perhaps very long strings.  Or a profiling bug.

M.
