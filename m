From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Possible bug in Git
Date: Thu, 15 Apr 2010 20:45:55 -0400
Message-ID: <u2t32541b131004151745k5284b05egfcbbd29d69bd9d94@mail.gmail.com>
References: <4BC6EECE.6060408@gestiweb.com> <k2u32541b131004151645i78733507rc50724548036ef36@mail.gmail.com> 
	<7vr5mggt9a.fsf@alter.siamese.dyndns.org> <o2m32541b131004151706hb48a0d04yf7fa4238d423a4e3@mail.gmail.com> 
	<k2n32541b131004151713s51498b01s34c5a95c0f360901@mail.gmail.com> 
	<o2w76718491004151738zb2deaad1p3f7360a437725c4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?David_Mart=EDnez_Mart=ED?= <desarrollo@gestiweb.com>,
	git@vger.kernel.org, deavidsedice@gmail.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 02:46:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ZhN-0005oY-S5
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 02:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab0DPAqQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Apr 2010 20:46:16 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:38012 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab0DPAqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Apr 2010 20:46:15 -0400
Received: by ywh32 with SMTP id 32so1032577ywh.33
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pt0NqJbjwSRNrNHXzWUGIJomc0YpIIW1qSbuCbJUUEg=;
        b=BdLYgfld71GYy6jp5W3yjslTU8fi3nflHORXWqjK7ke3fFidQuaenijTt3xY9MYzkU
         83+SKjRRgDuXw+ZhusXZS6lwVfixg6N0gikr0snPY+efGlrIS5YfAlZZm2+viFGtYCXX
         mKYFYAj7VAoFi7iBwMOsVqBSYfCzhCH0lt4nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ij1X0Lshzx5ygYxPAsxOIpQYHZN3gVn4Wba4eSLYBvRSvPpSitw0ArcpYNOPyHJQpP
         8OSd6nFR2/605vDA+ZqK9ywl4AZb/zNEVGl6W0QqcAwqoNIpwCMi58K/jsJkjzVcrvIw
         fovw0RTgM8mDbtQTnefoaiESE+rMPmLFnMB+E=
Received: by 10.151.143.6 with HTTP; Thu, 15 Apr 2010 17:45:55 -0700 (PDT)
In-Reply-To: <o2w76718491004151738zb2deaad1p3f7360a437725c4d@mail.gmail.com>
Received: by 10.150.209.11 with SMTP id h11mr964934ybg.198.1271378775231; Thu, 
	15 Apr 2010 17:46:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145041>

On Thu, Apr 15, 2010 at 8:38 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> On Thu, Apr 15, 2010 at 8:13 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> =A0true >profile =A0 # blank the file
>> =A0git commit -a -m resolved
>> =A0git show HEAD:profile
>> =A0 # no output
>
> Well, I wouldn't expect output from show HEAD:profile. But this is od=
d::
>
> $ git diff HEAD^1 --name-status
> M =A0 =A0 =A0 profile
>
> $ git diff HEAD^2 --name-status
> M =A0 =A0 =A0 profile
>
> $ git diff-tree HEAD --name-status
> <no output>
>
> Hmfph. "git log -m -p -1" at least gives the diffs from each side.

Whoops, actually I meant "git show HEAD profile".  Totally different,
of course.  But it doesn't produce output either :)

Have fun,

Avery
