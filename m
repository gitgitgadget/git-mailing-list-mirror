From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: t5801-remote-helpers.sh fails
Date: Sat, 10 Nov 2012 20:15:00 +0100
Message-ID: <CAMP44s0HtMRaQ91z95cZS73W7tnqYwyKV_2guWJ6u6UP4p5JNw@mail.gmail.com>
References: <509E5B27.5080808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:15:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGWS-0005Tj-4E
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab2KJTPC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 14:15:02 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58353 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2KJTPB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 14:15:01 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5105393oag.19
        for <git@vger.kernel.org>; Sat, 10 Nov 2012 11:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GvYIhI7afmiHA7OWb82Di5b8Ua2qOf+MfsKxr9pW+JQ=;
        b=Lx1v2Szsa/are6RnIs2FUe10vevf0kQUwOzthW1dlRsslNxKERxYfDJ+OYYWkELdDQ
         8L4qhkoUmy4ydzSZH5tJp2YCaU3WnxOphmPY5HEXOxHChMKjdxrzP/h4bpP7trKhOG2U
         KKzArtYlMJT8Etk7hZmnyrI2F8Rkypof+H4f60PKm1vi9DLF2AkpxtScBIPcRHiSwN2t
         ouu0pWP/kwsH6B2BHv2iGNLdhOW0SHRm0Q7lh18NGSRdhFzSFiYxWfEenWNoLNzIgo4c
         8aKZIQlv05qRZ/iLIHfrxUMDNVTECYA7OmNHXGxG2AQ3+g8PfQddibbz9tZ/DZs+M107
         shFw==
Received: by 10.60.12.225 with SMTP id b1mr11069477oec.96.1352574901009; Sat,
 10 Nov 2012 11:15:01 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sat, 10 Nov 2012 11:15:00 -0800 (PST)
In-Reply-To: <509E5B27.5080808@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209295>

Hi,

On Sat, Nov 10, 2012 at 2:48 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:

> on peff/pu t5801 fails, the error is in git-remote-testgit, please se=
e below.
>
> That's on my Mac OS X box.
>
> I haven't digged further into the test case, but it looks as if
> "[-+]A  make NAMEs associative arrays"
> is not supported on this version of bash.
> /Torsten
>
>
> /Users/tb/projects/git/git.peff/git-remote-testgit: line 64: declare:=
 -A: invalid option
> declare: usage: declare [-afFirtx] [-p] [name[=3Dvalue] ...]
> /Users/tb/projects/git/git.peff/git-remote-testgit: line 66: refs/hea=
ds/master: division by 0 (error token is "/master")
> error: fast-export died of signal 13
> fatal: Error while running fast-export

What is your bash --version?

--=20
=46elipe Contreras
