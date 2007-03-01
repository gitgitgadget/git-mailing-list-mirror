From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 10:40:33 +0000
Message-ID: <200703011040.35971.andyparkins@gmail.com>
References: <20070228151516.GC57456@codelabs.ru> <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com> <7vslcpux62.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Eygene Ryabinkin" <rea-git@codelabs.ru>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 11:40:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMiiS-0001MZ-Pf
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbXCAKkm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbXCAKkm
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:40:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:10520 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964883AbXCAKkl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:40:41 -0500
Received: by nf-out-0910.google.com with SMTP id o25so850646nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 02:40:40 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=f93/SR0B0ujRC2mNxEdAunbtG3GZUzHwtmaHfsFdMnIPqcP7N4rhHH/m/7AO076kshA2TymuXARJuEhKNe0eTAj0/pxfw6fEaw4vPy9+kKq8VKirKzCPSvNvMXBBNMuplgfjWSsmN3nbX44VoSH5Ksr8fxvsVKSfvSPkPdP3W00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X7fxxk9PjAWMH2TBBPU6Isnj4xUzsw8VghSKFlMtBFemKGoJQ6CxcUf8bl00q1q+XNzuiwSvW/GTpOJ9xuctFsaUCAOyBdKJYlOtxddMMWiCDkILXyT4flXYWo/AEEna3RYV4wiCJx4ScAIvJeQOn8XRbtk2Y4xdbhIJLIOdsDU=
Received: by 10.48.204.7 with SMTP id b7mr5402190nfg.1172745640639;
        Thu, 01 Mar 2007 02:40:40 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id l22sm8537711nfc.2007.03.01.02.40.38;
        Thu, 01 Mar 2007 02:40:38 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vslcpux62.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41078>

On Thursday 2007 March 01 09:32, Junio C Hamano wrote:

> If you make it a requirement to send even an trivially obvious

I certainly wasn't suggesting that it should be a requirement.  I just thought 
there was a certain irony.  Perhaps even a lesson to be learned - find out 
why someone has chosen (even with git in front of them and deep enough inside 
to find bugs in it), not to use git.

I think there is a usability lesson to be pulled from this situation.  Why 
didn't Eygene just say:

 $ tar zxvf git-tarball.tgz
 $ cd git
 $ git init
 $ vim http-push.c
 $ git diff

Note, that was not an attack on Eygene - I genuinely am interested to know 
where we should put the documentation that tells a new user what they need to 
know quickly.

Somehow, git has failed this person.  I was simply wondering in what way.

However, Eygene's response made it sound like a situational thing - it was 
inconvenient to actually install git.  Fair enough.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
