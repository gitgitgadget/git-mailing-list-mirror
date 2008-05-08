From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: automatically removing missing files beneath a directory
Date: Thu, 8 May 2008 10:19:46 -0700
Message-ID: <7f9d599f0805081019r16e3b6ahd14d55b7d32c6231@mail.gmail.com>
References: <7f9d599f0805080939j3ef5e145w9bc2ac94f559b036@mail.gmail.com>
	 <20080508164456.GA29103@sigill.intra.peff.net>
	 <7f9d599f0805081012ke0b342ct55a3aac1b37b158a@mail.gmail.com>
	 <20080508171843.GA29607@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 08 19:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju9nL-0004sX-GV
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 19:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759951AbYEHRTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 13:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759810AbYEHRTs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 13:19:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:23073 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759650AbYEHRTr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 13:19:47 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1059543rvb.1
        for <git@vger.kernel.org>; Thu, 08 May 2008 10:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=FIyYjOVNNwQk5CgrlszEch6bTzCCfZW0BycfgCUaMhg=;
        b=e8jwqAGoMGjTUKskh/QuMknpwZrcn7YvIp4Pgo1sICpbYGb40XFm2D1c1xHAqGH197HlwKnCm11OFiahk6bkyPv0gNgHCgwg1HwGPz9FdQxSGghpb7kgrR8Ke9WNZBM+meHps0J1YbsRwhANfiyKIzzgtqge1tf+hbV3h+KN5VM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=u/o+m0DG+HdsOsJmykAVbHL9w2SONQAWnjAjk622P6X+grquomXnVfJzAJj+Ml1b7sNEJD0+uJhokmlvJPtgeRIhn/ug88OnKf6AWRagYTaw23FXS6KrUg+jwLCTZtttTfMIbacr1ziIbukWFf+Iu1BuoruteKJ7MK4x96DdZ+A=
Received: by 10.140.251.1 with SMTP id y1mr1643615rvh.102.1210267186454;
        Thu, 08 May 2008 10:19:46 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Thu, 8 May 2008 10:19:46 -0700 (PDT)
In-Reply-To: <20080508171843.GA29607@sigill.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: abf282b353163fdd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81542>

On Thu, May 8, 2008 at 10:18 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 08, 2008 at 10:12:56AM -0700, Geoffrey Irving wrote:
>
>> Cool.  "git add -u && git add ." does exactly what I want.
>>
>> This is only indirectly mentioned in the documentation.  If you think
>> it's reasonable to mention it more explicitly, I've attached a patch.
>
> Yeah, the term "update" is not really defined there. I actually prefer
> to mention it even earlier in the paragraph; does this make sense to
> you?
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 35e67a0..e2389e3 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -71,7 +71,9 @@ OPTIONS
>        the specified filepatterns before exiting.
>
>  -u::
> -       Update only files that git already knows about. This is similar
> +       Update only files that git already knows about, staging modified
> +       content for commit and marking deleted files for removal. This
> +       is similar
>        to what "git commit -a" does in preparation for making a commit,
>        except that the update is limited to paths specified on the
>        command line. If no paths are specified, all tracked files in the

Yep, that's better than mine.

Geoffrey
