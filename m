From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "pop" to the lib infrastructure
Date: Wed, 1 Apr 2009 14:05:15 +0200
Message-ID: <20090401120515.GA30918@diana.vm.bytemark.co.uk>
References: <20090331113027.2524.60993.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 14:07:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LozDZ-00008x-3R
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422AbZDAMFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2009 08:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756841AbZDAMFU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:05:20 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:56344 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbZDAMFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:05:20 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LozBz-0000Np-00; Wed, 01 Apr 2009 13:05:15 +0100
Content-Disposition: inline
In-Reply-To: <20090331113027.2524.60993.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115375>

On 2009-03-31 12:30:27 +0100, Catalin Marinas wrote:

> @@ -47,7 +47,7 @@ test_expect_success 'Try to reset with --hard' '
>      stg reset --hard master.stgit^~1 &&
>      stg status a > actual.txt &&
>      test_cmp expected.txt actual.txt &&
> -    test "$(echo $(stg series))" =3D "> p1 - p3 - p2"
> +    test "$(echo $(stg series))" =3D "> p1 - p2 - p3"
>  '

Hmm, why this change in behavior? Something that should be noted in
the commit message?

> @@ -47,7 +47,7 @@ test_expect_success 'Try to undo with --hard' '
>      stg undo --hard &&
>      stg status a > actual.txt &&
>      test_cmp expected.txt actual.txt &&
> -    test "$(echo $(stg series))" =3D "> p1 - p3 - p2"
> +    test "$(echo $(stg series))" =3D "> p1 - p2 - p3"
>  '

And I guess this is the same.

Otherwise, this looks good.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
