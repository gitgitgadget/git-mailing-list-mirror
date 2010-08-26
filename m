From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/2] log/ format-patch improvements
Date: Thu, 26 Aug 2010 23:22:38 +0530
Message-ID: <20100826175234.GB25754@kytes>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
 <20100825084416.GC3280@kytes>
 <20100825205416.GB2319@burratino>
 <20100826053439.GB9407@kytes>
 <20100826054659.GC9708@burratino>
 <7vk4ndo05p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 19:54:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OogfA-0002JO-Pt
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 19:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab0HZRyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 13:54:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40885 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab0HZRyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 13:54:45 -0400
Received: by pwi7 with SMTP id 7so816148pwi.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dBJNSLlz5f4hoNVr0xGLLzeILqAFawIE+JiCZRdaezI=;
        b=ARpy032NofrTIsuT62VP49dMbjmJM8fWqSatafE70WqnJEX+msWvPCUM/0SEEG6JBT
         gOTJSpbQNH3A316xXRJGpabj7/SixC5kPwKC4TmVROIWoE3ISfN/JWekAs9dJPnyUtk/
         oobHTNuIepSgHZvMcJ46wHtQ2Sb++MtCFio78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xJB80RUBP+MZCXrI+xSgsSZQZlVh9F0CPF1aL/hpw0ml8k+lQi8gNNMYr4BG20aL3r
         R9KcqZRy0ncBsCpsZ2KN4zJ+vtBcqXCszek8CQPD0I+t381niVRYafI/Xk5l/n4Jn2hK
         0CeI9fuYJBrqXim5X4WOK/q7cBMYZJDTE/6Lw=
Received: by 10.114.131.15 with SMTP id e15mr11551317wad.178.1282845283738;
        Thu, 26 Aug 2010 10:54:43 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n32sm4858139wag.11.2010.08.26.10.54.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 10:54:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk4ndo05p.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154550>

Hi Junio,

Junio C Hamano writes:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Ramkumar Ramachandra wrote:
> > ...
> >> Good idea. I'll write a patch. Do we also want people to be able to
> >> turn off `--no-merges`?
> >
> > I don't see a need for it.
> >
> > However, if you can think of good names for --undo-no-merges and
> > --undo-merges options to "git log", that might be a nice independent
> > change for the revision option parser.
> 
> Wait a bit.  How would you represent a merge in a patch form that can be
> read by "git apply" (and "patch") in the first place?

Oh, I'm not attempting that. I merely wanted people to be able to turn
off `--no-merges` so they can get the current functionality.

As far as represeting merge commits go, I'm still thinking about it. I
talked to Thomas about it briefly on IRC. The main issues:
1. What's the point? When there's no conflict resolution, a merge
   commit would be empty.
2. How do we uniquely specify what to merge? We can't use branch names
   or commit SHA1s, because they can change.

-- Ram
