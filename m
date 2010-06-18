From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GSoC update] Splitting gitweb & developing write functionalities
Date: Fri, 18 Jun 2010 13:33:37 -0700 (PDT)
Message-ID: <m3wrtwnktb.fsf@localhost.localdomain>
References: <AANLkTikapZa0N7xroxhdlmm7LUvlNp-7GZy7XeG-zprC@mail.gmail.com>
	<20100615201720.GI3109@machine.or.cz>
	<AANLkTinfJOOT8NJ942bB_Sil4sGNthpk9hxvA60Y_iGB@mail.gmail.com>
	<20100615205755.GJ3109@machine.or.cz>
	<AANLkTimJqFzuWI7EMnUuH9ap69KgL_op_yndWSfyg8hX@mail.gmail.com>
	<20100616073017.GK3109@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jun 18 22:33:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPiG3-0003qV-Vs
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 22:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022Ab0FRUdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 16:33:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61277 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab0FRUdl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 16:33:41 -0400
Received: by fxm10 with SMTP id 10so808555fxm.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=u2F6oDvhpwH5OHxTtZ/mVMgPale+A5Lexpmu/S3NS6c=;
        b=swqS6WK9g66lCXZLnrsaqzlGZiGFion3vLColrve9oQitCzGbxIpSyOBV+OMqjq4r2
         sA56IDM8BXSoez7GNtOzYeAPKE3J/mQlswrvAOdxnsRZtAFgsBUC4sL2zmHukx+QAjqO
         45Rv/AV19YTujrUdS4Qzdxo4hh2JCzk9ai6kY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=J5AHCPwd8vXCIGbgDVSejN2mPthPHMNTyyirmbCknGlrCtDUAcN18lnWa9Ek6LHk9a
         8yrUx+sAG1XueN+MMreCPX4qZ5bOBRSJia7dVoyucYTX9X2OhlwUz52JvCNaVGLnGFam
         rspjUcivSeTu7BO6F4RmSlyXDTuFGxFgx4V4I=
Received: by 10.223.21.17 with SMTP id h17mr1306108fab.45.1276893219625;
        Fri, 18 Jun 2010 13:33:39 -0700 (PDT)
Received: from localhost.localdomain (abvg243.neoplus.adsl.tpnet.pl [83.8.204.243])
        by mx.google.com with ESMTPS id z12sm18106322fah.33.2010.06.18.13.33.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 13:33:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5IKX44w030888;
	Fri, 18 Jun 2010 22:33:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o5IKWXP7030875;
	Fri, 18 Jun 2010 22:32:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100616073017.GK3109@machine.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149360>

Petr Baudis <pasky@suse.cz> writes:
> On Wed, Jun 16, 2010 at 02:43:57AM +0530, Pavan Kumar Sunkara wrote:

> > Yes but after a long thought, I decided that the name to be changed to
> > View because this module contains all the subroutines regarding the
> > gitweb viewing functions.
> 
> But then you will need to continue the discussion in the respective
> therad and present counter-arguments to our (my?) arguments, or you will
> get NAKs.
> 
> (It's not like this is a totally crucial issue, but I'm now rather
> annoyed as what's the point of discussing stuff if it can be all
> discarded at a whim?)

On the other hand gitweb output is not limited to HTML only: it
includes text/plain ("raw" blob aka 'blob_plain' for text files,
'patches' / 'patch', 'projects_index'), feed formats: OPML, RSS, Atom,
and binary output ("raw" blob for binary files like images,
'snapshot').

But I don't know if Gitweb::View includes subroutines related to all
those things.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
