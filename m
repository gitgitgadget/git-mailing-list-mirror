From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] fsck: do not crash on tag objects which do not contain an empty line
Date: Fri, 8 Jun 2007 09:32:03 +0100
Message-ID: <200706080932.05098.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0706072338260.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 10:32:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwZtS-0003uS-EG
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 10:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765762AbXFHIcR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 04:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765231AbXFHIcR
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 04:32:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:27017 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763635AbXFHIcP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 04:32:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so892294ugf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 01:32:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OjoJECF5sEzP9RNKCLOALDGD5MZu62BiyeUL+5AsFU87sxAdXsSbEWVkWtKeM3eIXqkVh10raSpFUG+G8XAbZv2+XHA+dIab9iNchyz64Fz8aRLI+38Yj4o+WfE29sQMYbQnESS76dCGyHsmi+nHKAJx6hbQcQqEsjaH7W5T4BM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QJtdQwefLp2U0WiENZScVAHqp/GndTzOvox+bvQP6Cdi1ptBjUTnUpSF5dHqojZnSI5H6OwRCZ2LaxVZEOcyiG/1P61CBTCtTVMBzakztU8mCX524mAB/GrguIPSLOgmdtSmlyyama+oRBhP19Kw99HutTgjNSL9iUb7XTYHLa4=
Received: by 10.82.175.17 with SMTP id x17mr4862768bue.1181291533284;
        Fri, 08 Jun 2007 01:32:13 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm3767892ika.2007.06.08.01.32.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2007 01:32:12 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0706072338260.4046@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49448>

On Thursday 2007 June 07, Johannes Schindelin wrote:

> +		error("tag %s does not contain any tag?", refname);

Seems a bad error message to me.  Also, why is it a question?

 git: tag does not contain a tag
 user: WTF?

Perhaps, "The annotated tag, %s, does not contain a message", or similar?

Also - is this really something that should be complained about?  I'm 
wondering why it is important that tag objects contain a message?  For 
example, tagging a release as v1.0.0 - it's important to record who tagged 
it, and when it was tagged, but I can certainly envisage there not being a 
message to go with it.  Most tags in the git repository are just a repeat of 
the tag name in the message.




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
