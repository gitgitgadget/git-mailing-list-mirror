From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: Anyone running GIT on native Windows
Date: Wed, 9 May 2007 15:40:50 -0300
Message-ID: <f329bf540705091140l5aeca8f3l73a537202d7b2c09@mail.gmail.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>
	 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>
	 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>
	 <463ECEF4.625F3633@eudaptics.com>
	 <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com>
	 <463F14FF.F8DF11EB@eudaptics.com> <46415106.5040401@xs4all.nl>
	 <20070509183152.GB2982@efreet.light.src>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Marco Costalba" <mcostalba@gmail.com>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 09 20:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlr5u-0007j6-FN
	for gcvg-git@gmane.org; Wed, 09 May 2007 20:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815AbXEISkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 14:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756820AbXEISkx
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 14:40:53 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:47090 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815AbXEISkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 14:40:53 -0400
Received: by an-out-0708.google.com with SMTP id d18so72882and
        for <git@vger.kernel.org>; Wed, 09 May 2007 11:40:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=haOmpvo+su3d+UGaSENKJdJzvJy/SI0apkuMk+a+0T+sgMTUNPkM2WPjIS7hu//SdzeSluixy7W/+47aaIh3GXWyQ0aWvxwozqIV2qTRDF0/W4AqjZonjn+h3frddUzBFg03WupHPS/LeoQFmmv3RfZTrvNmSf0DNFxVilteAR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FI1MalIdcG0dyVcc0loXhZd2f407UG8URJwg9bePK353HMLN9rzBE+Td7iPpaFNI6qhovqubhYnwjesE8TmH3a74X3QJz2M2CsL0OfvbQfsSg7bZchGNV5dh0jeQ8U841vptfLGrG1gNp8MFc0kNBjCzQ9yYoWIs136zCCZsrKs=
Received: by 10.100.209.10 with SMTP id h10mr583539ang.1178736051800;
        Wed, 09 May 2007 11:40:51 -0700 (PDT)
Received: by 10.100.142.1 with HTTP; Wed, 9 May 2007 11:40:50 -0700 (PDT)
In-Reply-To: <20070509183152.GB2982@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46765>

2007/5/9, Jan Hudec <bulb@ucw.cz>:
> > > The next big thing to think about is an installer. Does anyone have a
> > > suggestion for a free installer tool? I only know about Microsoft's WiX
> > > (wix.sf.net), but it requires .NET (for the developer, not the user).
> >
> > I packaged Mingw GIT using NSIS some time ago; see
> >
> >   http://lilypond.org/git/binaries/mingw/
> >
> > Due various personal reasons, I haven't been able to update this, but I
> > will package a new version soon. Please try it to see whether there are
> > any rough edges.
>
> Would you care to share the installer scripts? Maybe you can find someone to
> help.

see

http://git.sv.gnu.org/gitweb/?p=lilypond.git;a=shortlog;h=gub

there is a mingit.make which has the targets for the MinGW git
version. Unfortunately, the last successful compile was some months
ago. It's likely to be broken due to the frantic hacking that occurred
in the last months, but it should be

 make -f mingit.make bootstrap
 make -f mingit.make mingw


-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
