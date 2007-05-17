From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Allow the ident attribute to include a length specifier
Date: Thu, 17 May 2007 14:53:29 +0100
Message-ID: <200705171453.32093.andyparkins@gmail.com>
References: <200705141405.29550.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 15:53:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HogQW-0003ti-VW
	for gcvg-git@gmane.org; Thu, 17 May 2007 15:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbXEQNxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 09:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755572AbXEQNxv
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 09:53:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:25313 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510AbXEQNxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 09:53:50 -0400
Received: by ug-out-1314.google.com with SMTP id 44so335509uga
        for <git@vger.kernel.org>; Thu, 17 May 2007 06:53:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dpVi55vSWK0ONnhKLiVVced4PV0UKzkPvazrGgGtXMgqAMyvvNihxBYQEKiul6zyDmX3oH19C6TlwTbiNlgvDev+owS+fpYWes25FMfpiYO6zC0JPqbo1ClPDuLZbAiSVp5EOd1fMHJWl/unaGQvCkKBwtksfCnYlBtxgXg60Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=agXI8h/8vf6NiW50exoWG69vPRB678d7DR6hJkdHYsoX6S0IAj0p3HRxG1VVl40Yrak7+f1mb7LXCGLhidGrY/x0EQOXGeZdI8LBsA0UI99PVCn6AD73BtBN34m7oZuGj9oiWznMKhgo4url/HQJhVpcigEBHM8NfaC0KS1PCD4=
Received: by 10.82.113.6 with SMTP id l6mr707218buc.1179410029265;
        Thu, 17 May 2007 06:53:49 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm983740ika.2007.05.17.06.53.42;
        Thu, 17 May 2007 06:53:46 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200705141405.29550.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47523>

On Monday 2007 May 14, Andy Parkins wrote:
> When the ident attribute is found for a path, then git replaces $ident$
> with:
>
>   $ident: df2a1fd3ebce86876721bd7e12ce02ac89c885db $
>
> With this patch, you can put the following in your attribute file:
>
>   somepath ident=10
>
> And get expansions like this:
>
>   $ident: df2a1fd3eb $
>
> There is no change to existing behaviour.  With no parameter, the
> expansion is all 40 hex digits.

Were there any thoughts on this patch?  I think it might have got drowned in 
the noise I made about $ident$ -> $Id$.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
