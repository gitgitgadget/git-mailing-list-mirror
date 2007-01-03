From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Wed, 3 Jan 2007 01:24:33 +0100
Message-ID: <8aa486160701021624v69015fbibb81a99177dd7dfc@mail.gmail.com>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	 <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
	 <20061223051210.GA29814@segfault.peff.net>
	 <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
	 <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
	 <20070102144940.GA23932@coredump.intra.peff.net>
	 <7vps9xwd01.fsf@assigned-by-dhcp.cox.net>
	 <20070102173410.GA25325@coredump.intra.peff.net>
	 <7v1wmdure6.fsf@assigned-by-dhcp.cox.net> <enef73$467$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 01:24:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1tw1-0002JN-8R
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 01:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXACAYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 19:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbXACAYg
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 19:24:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:32617 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbXACAYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 19:24:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5048933uga
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 16:24:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FRuLZHkaDY1fwLIjaK085gZGT3P2IPWC99nzChY0ZgjogZ+VYurv4xfDyYdjg3y2gursekE42h/gSrz5qJ9z3KMSEo6xG62TWX7R1wBLfxu+TGXcBUEGlTZ+fNuARMyoPEPwX1P/d8xFr1yzvAl4adlCjvOLfn63SrbDpBMEnOM=
Received: by 10.78.122.11 with SMTP id u11mr3080113huc.1167783873630;
        Tue, 02 Jan 2007 16:24:33 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Tue, 2 Jan 2007 16:24:33 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <enef73$467$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35838>

On 1/2/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
>
> > Obviously, the local names should matter more when you are doing
> > local operations. So if you are using mergeLocal to give a
> > shorthand to "git merge" that does not explicitly say what to
> > merge, the above discussion does not apply. But if that is the
> > case, mergeLocal should also not affect the selection of
> > branches to be merged when "git pull" happens from a remote
> > either.
>
> You can always use remote = ".", and then remote and local branches
> are the same...

Currently it does not work.

Santi
