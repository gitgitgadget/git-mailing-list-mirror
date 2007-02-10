From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/2] run_diff_{files,index}(): update calling convention.
Date: Sat, 10 Feb 2007 16:51:24 +0100
Message-ID: <e5bfff550702100751v33e655fw6358234c23170d51@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <7vejoyq330.fsf@assigned-by-dhcp.cox.net>
	 <7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
	 <e5bfff550702100002y3929c50mfb99b8da44c9c82b@mail.gmail.com>
	 <7vps8imnis.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550702100029h65d1fd3fke5496da0664642ee@mail.gmail.com>
	 <e5bfff550702100046m1c0b1931t11ed0cf95853cda9@mail.gmail.com>
	 <7vhctumh1m.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550702100325v5ce9ba1fx4b9b7adcc5040948@mail.gmail.com>
	 <7vd54im4f2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 16:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFuVd-0007Sy-7s
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 16:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbXBJPv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 10:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbXBJPv0
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 10:51:26 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:26766 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614AbXBJPvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 10:51:25 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1108994nze
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 07:51:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p5bQ9P4kGION8JM4Y0gnsvC/oLwm5WvEMn4X85XVIyu5tlnK3ZKEc+Qzp6/OjK1nXalMDlR+nkipto2GnEPxi1pr+/rEeiEYVdDwwtzlUI97lPXeb5+toY2S0U6mnp7orjtEwoUVgUeHb/aweA3a3Bv8JcpFhnHsOrFyjjmHXn8=
Received: by 10.114.197.1 with SMTP id u1mr5400114waf.1171122684291;
        Sat, 10 Feb 2007 07:51:24 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 07:51:24 -0800 (PST)
In-Reply-To: <7vd54im4f2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39231>

On 2/10/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > So in this case your patch that introduce '--refresh' option in 'git
> > runstatus' is not just a shortcut for 'git update-index' + 'git
> > runstatus' but adds some real value.
> >
> > One more reason for asking you to add it before 1.5 release ;-)
>
> The thing is, it touches central part of the system by changing
> the calling convention of two rather important functions.  You
> might have already fully tested that there is no regression for
> git-runstatus, but it affects other callers as well.  I tried to
> be careful when I did the conversion but I am not 100% sure
> there is no "unintended side effects".
>

I understand this.
