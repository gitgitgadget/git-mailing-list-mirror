From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] test-bzr: portable shell and utf-8 strings for Mac OS
Date: Fri, 12 Apr 2013 16:27:32 -0500
Message-ID: <CAMP44s1UqCNKHFMcN0pJo_tJ1UeHDET7vxFJhqj8X=YibgDt0Q@mail.gmail.com>
References: <201304122318.20780.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: christophe@kn.gl, git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 12 23:27:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQlVT-0003rs-3l
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 23:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031Ab3DLV1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Apr 2013 17:27:34 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:36880 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab3DLV1e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Apr 2013 17:27:34 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so2847675lab.41
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=s+ulEPD/iZuP9V5eVzNqwC5rHapEHHqwAlMW1fFWlnc=;
        b=QhVe8iuRXVkkRp6enIQGUi7YEVdjUbbTy6wj5tcIHMtLLKkpW+UJK//0zVQy91mXBT
         0er4fA1sfRAzWStYvvvvfoQ29JkHLgL2MjBbp1RvNik+CEkyyXj1Ge8PveT6uixLwYVM
         mlORbT8Fyw5gNQwVfbSxnkrHjFbtqf28MAfIsemnyKarr5ofFTDxGfExBpVBNW0Boa4u
         x5p84NUPYoc0HKeQOehNsylPzzw69nHHfZI0kVqXt6ab3l3XI5eW48o06pE6y/RSHH5J
         Ad+tvIjr1iXc4dNbPlY30NScXb+8SvXbpz9hrwf869A8J5YpTSNb/4ChjO5FubijYgBt
         RNmA==
X-Received: by 10.112.133.198 with SMTP id pe6mr6081057lbb.103.1365802052451;
 Fri, 12 Apr 2013 14:27:32 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 12 Apr 2013 14:27:32 -0700 (PDT)
In-Reply-To: <201304122318.20780.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221029>

On Fri, Apr 12, 2013 at 4:18 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> Make the shell script more portable:
> - Split export X=3DY into 2 lines
> - Use printf instead of echo -e
>
> Use UTF-8 code points which are not decomposed by the filesystem:
>  Code points like "=C3=A1" will be decomposed by Mac OS X.
>  bzr is unable to find the file "=C3=A1" on disk.
>  Use code points from unicode which can not be decomposed.
>  In other words, the precompsed form use the same bytes as decomposed=
=2E

Looks good to me.

--=20
=46elipe Contreras
