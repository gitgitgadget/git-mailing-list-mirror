From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] hg-to-git: fix parent analysis
Date: Tue, 19 Feb 2008 11:12:44 +0100
Message-ID: <20080219101244.GA3825@diana.vm.bytemark.co.uk>
References: <1203110444.5579.23.camel@galileo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRPU1-0000go-KK
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 11:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbYBSKNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2008 05:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbYBSKNI
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 05:13:08 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4323 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbYBSKNH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 05:13:07 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JRPSv-00014F-00; Tue, 19 Feb 2008 10:12:45 +0000
Content-Disposition: inline
In-Reply-To: <1203110444.5579.23.camel@galileo>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74391>

On 2008-02-15 22:20:44 +0100, Stelian Pop wrote:

> -    prnts =3D os.popen('hg log -r %d --template "{parents}"' % cset)=
=2Eread().split(' ')
> +    prnts =3D os.popen('hg log -r %d --template "{parents}"' % cset)=
=2Eread().strip().split(' ')

If it's not already too late, you could wrap this line when you're
changing it anyway. Something like this maybe:

    prnts =3D os.popen('hg log -r %d --template "{parents}"' % cset
                     ).read().strip().split(' ')

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
