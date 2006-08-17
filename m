From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH 4/7] gitweb: Expand href() function to use key as param name for no mapping
Date: Thu, 17 Aug 2006 12:08:06 +0200
Message-ID: <8fe92b430608170308n42942798xf50f814052bee1c4@mail.gmail.com>
References: <11558064883957-git-send-email-jnareb@gmail.com>
	 <11558064893139-git-send-email-jnareb@gmail.com>
	 <7v8xlnsmyl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 12:08:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDenN-0008W4-RR
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 12:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWHQKIJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 06:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHQKII
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 06:08:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:46221 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932414AbWHQKIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 06:08:07 -0400
Received: by nf-out-0910.google.com with SMTP id o25so926401nfa
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 03:08:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S6/rZgCnSKW4NuDepie+WIKPeuLU3BZ5lx8OKsGtdWweztA44ywTTrUTMYCfB1rXIwTb0taGOPg7hDiq0ceMIvz/Y0VWCu6zTseIEFjCTSvL8elGAUfKxHWHmKoGfY3gl7mowD89HWMxbsRcyb/cKwH5o8OtbPw18rIXGRxqNAs=
Received: by 10.48.210.20 with SMTP id i20mr2018454nfg;
        Thu, 17 Aug 2006 03:08:06 -0700 (PDT)
Received: by 10.78.128.20 with HTTP; Thu, 17 Aug 2006 03:08:06 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xlnsmyl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25580>

On 8/17/06, Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
> > Expand href() function to use key name of params hash as a query param
> > name, if there is no mapping for given key name.
> >
> > It is now safer to use href(); no errors, but links might not work
> > correctly if caller didn't provide correct arguments.
> >
> > Future proofing.
>
> I think that is not a "future proofing" but is "sweeping mess
> under the rug" ;-).
At least leave 'if (exists $mapping{$_})' even if you remove the 'else' part.

[...]
> Obviously unrelated and probably unplanned revert of [2/7] in
> the series, so will not apply.
Ooops, sorry, I haven't noticed this... Very unplanned.

-- 
Jakub Narebski
