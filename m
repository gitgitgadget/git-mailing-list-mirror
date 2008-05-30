From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 18:04:40 +0200
Message-ID: <b77c1dce0805300904o5b4363efkc4591fc820164bf7@mail.gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805300127.10454.jnareb@gmail.com>
	 <483FABB4.1010309@gmail.com> <200805301202.25368.jnareb@gmail.com>
	 <4840166C.3030903@gmail.com> <20080530150713.GG593@machine.or.cz>
	 <48401CFF.4020702@gmail.com> <20080530153822.GH593@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lea Wiemann" <lewiemann@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"John Hawley" <warthog19@eaglescrag.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Lars Hjemli" <hjemli@gmail.com>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 30 18:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K276n-00008I-9H
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 18:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbYE3QEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 12:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756261AbYE3QEp
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 12:04:45 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:57636 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbYE3QEn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 12:04:43 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3376755wfd.4
        for <git@vger.kernel.org>; Fri, 30 May 2008 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eLHUL3Q3eFML8e93G6JNLlY4xu5bhxAx+JhYFCkeA5o=;
        b=KLRVHlVWuTOafHyYER5raV/b5ap6Ps/pWH/U405hNM5P42QhJnNHpQ/2BepvkMYdqlUzgQRIkgHE+lm/1Mx5K4fqwVRxtkimQHZtd0fpyIEyOsupVkwpriOoUL70Fw5IToNsA/IEV934eYdbItdF+zCS4Doz3DKLuW/LLEV4YoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HtU7YRJi/3lN+mU3vsT0XX93/7IToZAnl5lO4VPLzlRQEwlvH/scU4BrGEzUQ+BAzy+LDsefhgvJoFuq5G4A2Dbxgc8eGFqlPkaH6wxJ+SoobAGp2dEIx9jVUVUxr+OzEARp2QmU294/2nz2OLIKEjdsRAFN7Mie1YeEqPMA30g=
Received: by 10.142.210.4 with SMTP id i4mr499585wfg.240.1212163480273;
        Fri, 30 May 2008 09:04:40 -0700 (PDT)
Received: by 10.142.212.20 with HTTP; Fri, 30 May 2008 09:04:40 -0700 (PDT)
In-Reply-To: <20080530153822.GH593@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83313>

2008/5/30 Petr Baudis <pasky@suse.cz>:
>
> Wow, and here I was wondering if requiring at least 5.6 was not too
> liberal. ;-) I believe 5.8 is the newest possible candidate though, it
> is still too widespread; e.g. Debian-wise, many servers run on Etch and
> are going to stay there even for quite some time after Lenny gets
> released. Heck, I still have accounts on plenty of Sarge machines. ;-)
> (Sarge seems to have Perl-5.8.4.)

I think 5.8.2 is a good _minimum_ perl to support. Before that one,
Unicode support is next to null (5.6 and below) or too buggy, and
gitweb needs that.
