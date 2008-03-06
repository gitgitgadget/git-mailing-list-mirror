From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Thu, 6 Mar 2008 22:45:43 +0100
Message-ID: <8aa486160803061345k690af0dcv14fe5d62b310ad6f@mail.gmail.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
	 <20080305204414.GB4877@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 22:46:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXNv1-00033i-0r
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 22:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764028AbYCFVpt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 16:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbYCFVpt
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 16:45:49 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:11787 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763847AbYCFVpr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 16:45:47 -0500
Received: by ti-out-0910.google.com with SMTP id 28so102577tif.23
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 13:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jbRg7Y+uFf1GQ2SnoDhwHjWtlEtDo5aWiRlf77DC3XY=;
        b=SB43OyFxUAYuAsMJ29a79TSnSgSnih6FLRYLSDWsHd1cr+H/+jiviL8kBf34J/4elqxS5PmeP57J/tb51pAkGrz8z+PYBzCXXKMaieb/t4WnOPsgeF25aK30z1lLMRaGHAEvUI8RE90N9pByFm3OOP8RZzscvHe9UWSqm7z3xJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bYDGakp/1UcgkBjTkCZdPABdYWQP/HSytU0jcCZCWAItg1BN83aMn3LuYt11Bbo1JdjsSLHGOtMgwUQEHN9utk4Fb5Z5RBjkJBsNkY+fNEiYICxkGb6A6E0kFDnTvmAmlQpJfZzqJQ5Tb3EUVgH8hYwDdNv+kVp5chZW86jLLS8=
Received: by 10.150.92.11 with SMTP id p11mr179497ybb.105.1204839943968;
        Thu, 06 Mar 2008 13:45:43 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Thu, 6 Mar 2008 13:45:43 -0800 (PST)
In-Reply-To: <20080305204414.GB4877@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76426>

On Wed, Mar 5, 2008 at 9:44 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Santi B=E9jar, Wed, Mar 05, 2008 20:18:04 +0100:
>
>  > @@ -171,7 +171,7 @@ static const char au_env[] =3D "GIT_AUTHOR_NAM=
E";
>  >  static const char co_env[] =3D "GIT_COMMITTER_NAME";
>  >  static const char *env_hint =3D
>  >  "\n"
>  > -"*** Your name cannot be determined from your system services (ge=
cos).\n"
>  > +"*** Your name cannot be determined.\n"
>
>  Why not?

Is this important? Or in another way, is this useful? The important
thing is how you can fix it. But others think otherwise I'll change it
to explain the reason.

Santi
