From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] user.default: New config to prevent using the default values for user.*
Date: Sat, 8 Mar 2008 01:13:18 +0100
Message-ID: <8aa486160803071613pdacc88fkabc10f52da56ad5d@mail.gmail.com>
References: <1204744684-2043-1-git-send-email-sbejar@gmail.com>
	 <20080305204414.GB4877@steel.home>
	 <8aa486160803061345k690af0dcv14fe5d62b310ad6f@mail.gmail.com>
	 <20080307164111.GB4899@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 01:14:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXmhM-000606-Cf
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 01:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYCHANW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 19:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYCHANW
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 19:13:22 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:54214 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbYCHANV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 19:13:21 -0500
Received: by wr-out-0506.google.com with SMTP id 50so389187wra.13
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 16:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AEwxx5hWNRvHgddJGXnEtou1kG5SlNyl7XHbNBRQvRE=;
        b=tfUb/P0ajWn6nQxLWo7l9bAxeUG41GtYGW89ErcHm6ZlIYWUoG3AJPKCzrzlQOIqk6hG2TyCrqVHMql7AK++o+JNH6FT4w0qF0G0Q8iSYLYfwFfXTCfV4dfOYznsn/MWiVC5phh+YAc/ytfuuZTBcwKYtx6aXU2GXWy7cP+cASM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=x5zkVWQk0H7Dsq9DpJhSLRzesEtb5fu6BSpf2rJGUxbe3C8dLP0N6FQ6hj0QPAXzDWb0j1UsMU4fcEnsFW7prwbIZaH9XzsIsBgGZ+AIGDn30eTna0YHLoe4qZMw4fF0nTuuZ5PK/nfIqjEoyFcduNDdV6vhPWF3v60pAwJsriY=
Received: by 10.151.103.11 with SMTP id f11mr879918ybm.194.1204935198715;
        Fri, 07 Mar 2008 16:13:18 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Fri, 7 Mar 2008 16:13:18 -0800 (PST)
In-Reply-To: <20080307164111.GB4899@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76533>

On Fri, Mar 7, 2008 at 5:41 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Santi B=E9jar, Thu, Mar 06, 2008 22:45:43 +0100:
>
>
> > On Wed, Mar 5, 2008 at 9:44 PM, Alex Riesen <raa.lkml@gmail.com> wr=
ote:
>  > > Santi B=E9jar, Wed, Mar 05, 2008 20:18:04 +0100:
>  > >
>  > >  > @@ -171,7 +171,7 @@ static const char au_env[] =3D "GIT_AUTHO=
R_NAME";
>  > >  >  static const char co_env[] =3D "GIT_COMMITTER_NAME";
>  > >  >  static const char *env_hint =3D
>  > >  >  "\n"
>  > >  > -"*** Your name cannot be determined from your system service=
s (gecos).\n"
>  > >  > +"*** Your name cannot be determined.\n"
>  > >
>  > >  Why not?
>  >
>  > Is this important? Or in another way, is this useful? The importan=
t
>  > thing is how you can fix it. But others think otherwise I'll chang=
e it
>  > to explain the reason.
>
>  It is precise explanation of what happened. It could be a hint to fi=
x
>  gecos field to someone. It is considered useful not to hide
>  information, even if you have no idea of how useful it is.

I'll wait for others to comment.

>  Others may
>  be smarter than you.

I don't think this is necessary.

Santi
