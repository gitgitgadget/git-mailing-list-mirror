From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] Fix t9200 on case insensitive file systems
Date: Sat, 27 Oct 2012 22:36:27 +0100
Message-ID: <CAP30j160xHL+N=v_=c=6gvLTYynB9oPSNuTHu_NCYz71=YNyfQ@mail.gmail.com>
References: <201210261818.25620.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bosch@adacore.com,
	brian@gernhardtsoftware.com, robin.rosenberg@dewire.com
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 23:36:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSE3c-0005Fo-P0
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 23:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759467Ab2J0Vg2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2012 17:36:28 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41304 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183Ab2J0Vg1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Oct 2012 17:36:27 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5153293iea.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 14:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QDprrJ/7jjXMdG0T/JLI3SXVOmcLMCivq9tgjdsP7Gc=;
        b=hoyW8ZuJo6sV0Sgyd748e6wzlyw39PATQ1IHzHvYeGc6uAybwJXmHcRliYDbTWxr57
         LIbCooPBpClkwD0LKCNeGeymPXS9ClK/q2I6NTKoXBC+Qm/eFcKG8f9L3alEAI1U3fFS
         UqO7ZPHufTrGq8L6zRwviiBaZDqseh2Oembf+rZYxNFPvdnCS/QQucgghN2dqN6g5xFm
         OLKxpoCDeEUQb1yBx2tPwtdvX+rAmHOCpKz0I9RQth9CzSGWYL2ALmZjhYaWBFhOWi2u
         lmvAvmFyEIX+nVFV7WCmqOE6Bs+V/x+JIVx9ccxQ92n/CBGPt0koDmXEGXUaDjrGUXY6
         lOow==
Received: by 10.50.171.4 with SMTP id aq4mr5750690igc.72.1351373787243; Sat,
 27 Oct 2012 14:36:27 -0700 (PDT)
Received: by 10.64.76.20 with HTTP; Sat, 27 Oct 2012 14:36:27 -0700 (PDT)
In-Reply-To: <201210261818.25620.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208514>

On Fri, Oct 26, 2012 at 5:18 PM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:
>  t/t9200-git-cvsexportcommit.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportco=
mmit.sh
> index b59be9a..69934b2 100755
> --- a/t/t9200-git-cvsexportcommit.sh
> +++ b/t/t9200-git-cvsexportcommit.sh
> @@ -19,7 +19,7 @@ then
>      test_done
>  fi
>
> -CVSROOT=3D$PWD/cvsroot
> +CVSROOT=3D$PWD/tmpcvsroot

=46WIW, this looks obviously correct given the code snippet from the cv=
s
version you shared the other day.

Thanks
-Ben
--=20
-----------------------------------------------------------------------=
----------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
-----------------------------------------------------------------------=
----------------------------------------------------
