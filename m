From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Mon, 7 Jun 2010 20:29:56 +0200
Message-ID: <20100607182956.GA17343@localhost>
References: <20100605110930.GA10526@localhost>
 <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
 <20100605135811.GA14862@localhost>
 <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
 <20100606161805.GA6239@coredump.intra.peff.net>
 <20100606165554.GB10104@localhost>
 <AANLkTinTI3XaE6P_WZ_k56fgI4LNOLSalv_1GlVZNO7n@mail.gmail.com>
 <20100606173233.GA11041@localhost>
 <AANLkTilvHl-8eA6CbEDs4ty3h0h670L_enGsXunHxaPE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 20:31:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLh6T-0004NV-Rb
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 20:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab0FGSbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 14:31:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:46556 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab0FGSbI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 14:31:08 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1806812fga.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=nVf6Ze7OWbI927LOlYd9f7Rmx0/kdArDkmJ5bpwlOGY=;
        b=szOlPF4DYt5wWZITN5VXL7DyqNXN89GE1qrJL8Kc8la81zoA3xlhRk81ULFprVTEkz
         bXPnwfCqUwHWqa/4ZEyzoSkoTlGrFZwStvfzZWyV2XJksVsnq9mYWC7PEkDJ3f7i7TBP
         3UFIWWA1LUk61hDFFIsL+WcrvVrjYh9vgRqmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=m/7wQDZtivsIBKSmo1Qc6V5oBIUUmPoBGA4mpG3L+R0WcuofQ6K+u1H93VDdR9W/5E
         gNbLMwj00AmHoArTwpBquLaaHJXPLXMprgI0kPQeB0xCzxtttjF+9tFIQzlg+d1iKpcW
         /mmKEzNOKXYyYJ6glrqPdBVB92SxMwJUTmsig=
Received: by 10.87.58.6 with SMTP id l6mr23518879fgk.15.1275935466938;
        Mon, 07 Jun 2010 11:31:06 -0700 (PDT)
Received: from darc.lan (p549A5B93.dip.t-dialin.net [84.154.91.147])
        by mx.google.com with ESMTPS id p17sm6459124fka.46.2010.06.07.11.30.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 11:31:06 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OLh5A-0004d7-ES; Mon, 07 Jun 2010 20:29:56 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTilvHl-8eA6CbEDs4ty3h0h670L_enGsXunHxaPE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148614>

On Sun, Jun 06, 2010 at 02:26:08PM -0700, Jacob Helwig wrote:
>
> > And this is exactly _why_ it can be marginally useful if the
> > foretelling is correct, but all the more confusing if it's not.
> >
> 
> Other than "unexpected success", how is the DWIM behavior confusing,
> given that it says exactly what it's doing when the DWIM behavior is
> invoked?  I'm still not clear what the confusion you're referring to
> is on this one.

I am telling git to checkout a branch. Instead it creates a branch.
That is what is confusing to me. Until I found the commit that
introduced it, I was sure it must be a bug.
