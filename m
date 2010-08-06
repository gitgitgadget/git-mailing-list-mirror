From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Decompressing a tree to a location other than the working
 directory
Date: Fri, 6 Aug 2010 13:43:45 -0500
Message-ID: <20100806184345.GB2985@burratino>
References: <AANLkTi=RjcQ_-PNUt781jhYEA-8krqXpdHRenVyR_Rc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Joshua Shrader <jshrader83@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 20:45:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhRv1-0001Fo-9P
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 20:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933330Ab0HFSpP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 14:45:15 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51265 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759375Ab0HFSpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 14:45:11 -0400
Received: by eya25 with SMTP id 25so2901129eya.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=muF5tJcLNsE4eLmHpdQbZpfsWDgol4lWFoWMWxSzITs=;
        b=Z/lBmQjUR4QUZteTPv9/ByZGpcKsYDPwfA4pQKuqjx6tD6HHtI5DDsrHmejMbi9uVD
         GUjAeLFO/kjaUUEtErA490RyOwWsHYTlY5hg6q1rCbQ39uBXGSHOAw1ZMWmZTWGZa9t7
         mBeJan0aVcb3zBCwE3xpTwPKqFz/ER6u2cRmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rl3DmmG8r4foA/Yi7uzGemuEZyny2thBo8rNemUwnF7m5Gj5COpJafCQmPo4Q1vKQq
         2emEXFXicJ5hZ6oukh6wTIi18+zt4MRI4JeLRv15hvqUFdISIE1+KYEZEx5HFoMgD/jx
         iQkirZpUeFXi6aKJR8s8n9NTBoiAwv1JDgdr8=
Received: by 10.213.20.10 with SMTP id d10mr9088447ebb.92.1281120310063;
        Fri, 06 Aug 2010 11:45:10 -0700 (PDT)
Received: from burratino ([66.99.1.133])
        by mx.google.com with ESMTPS id a48sm2789688eei.1.2010.08.06.11.45.07
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 11:45:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=RjcQ_-PNUt781jhYEA-8krqXpdHRenVyR_Rc4@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152802>

Joshua Shrader wrote:

> git checkout allows one to checkout a particular version of a certain
> path in the working directory.  Are there accessible plumbing command=
s
> that can be used to accomplish the same thing, but change the target
> directory.

I don=E2=80=99t know if it is plumbing, but "git archive" is very usefu=
l for
that.

 $ git archive HEAD^:Documentation | (cd elsewhere && tar xf -)

Hope that helps,
Jonathan
