From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Try the built-in version string before git-describe
Date: Wed, 21 May 2008 15:38:18 +0100
Message-ID: <b0943d9e0805210738v40b25d54j65e70b3ef2745987@mail.gmail.com>
References: <20080520210249.GA19465@diana.vm.bytemark.co.uk>
	 <20080520213844.13410.32757.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 21 16:48:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JypTJ-0002ir-Ou
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 16:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935773AbYEUOiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 May 2008 10:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935757AbYEUOiY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 10:38:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:4846 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935739AbYEUOiX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 May 2008 10:38:23 -0400
Received: by ug-out-1314.google.com with SMTP id h2so164328ugf.16
        for <git@vger.kernel.org>; Wed, 21 May 2008 07:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=gVLzkUaNB1+MX492Esc823hYpXUe/mBmeNEjC+FA6o4=;
        b=bJdl6ufSVRoe7SdPVTjITdufUFtpzcNg2t3VJNkdkRoq16w/6Blk8oGy0lXszgX0/dAinNAnne8l2nRXIRTA0OSH5Iu8iJE5Ye5EhCPPYqpr9sHcCOdeLL1iQNnu+lx5nU9wD2e1FlH5njHJv9uvz0UrH/G1ncIxrHeZRUO40Y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IhlYAClKHSXlcto9R319W2CCr7P2k2XCdzI+RZM/xzfJ0nNCKrXKofkqipE9G3nqwL+9nCmwxqvM1qZZDyBLniDDB2wYYcpZN5dyFSKjExX89Qz42PLkJlQzy/TmYOPDuFDhWexmYuVrPAQMeA55z+egeUEpCwVb0MKp9dXsWTI=
Received: by 10.66.234.13 with SMTP id g13mr1164149ugh.5.1211380698156;
        Wed, 21 May 2008 07:38:18 -0700 (PDT)
Received: by 10.66.242.4 with HTTP; Wed, 21 May 2008 07:38:18 -0700 (PDT)
In-Reply-To: <20080520213844.13410.32757.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82546>

On 20/05/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Try to get the built-in version string first, and fall back to git
>  describe if there is no built-in string, instead of the other way
>  around. This makes computing the version string much cheaper in the
>  common case (whenever StGit is not run directly from a git-controlle=
d
>  tree).
>
>  In order for this to work when StGit _is_ run directly from a
>  git-controlled tree, setup.py has to delete the builtin version file
>  once the installation process is over. (Otherwise, the StGit version
>  in a git-controlled tree would be frozen at whatever value it happen=
ed
>  to have when setup.py was last run.)

OK, I thought it was only the ordering change. With this change to
setup.py, I'm OK with the patch. I'll merge your tree tonight.

--=20
Catalin
