From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] add option to import series directly from a tar archive
Date: Fri, 12 Sep 2008 15:08:34 +0200
Message-ID: <20080912130834.GB31240@diana.vm.bytemark.co.uk>
References: <48C34EC7.9040102@gmail.com> <20080908180317.GA6123@diana.vm.bytemark.co.uk> <48C56AD9.6040007@gmail.com> <2008-09-12-14-21-13+trackit+sam@rfc1149.net> <20080912130703.GA31240@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <clark.williams@gmail.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 14:47:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke83g-0006eP-So
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 14:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbYILMqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 08:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbYILMqZ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 08:46:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4863 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbYILMqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 08:46:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ke8O2-0008AZ-00; Fri, 12 Sep 2008 14:08:34 +0100
Content-Disposition: inline
In-Reply-To: <20080912130703.GA31240@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95720>

On 2008-09-12 15:07:03 +0200, Karl Hasselstr=F6m wrote:

> On 2008-09-12 14:21:13 +0200, Samuel Tardieu wrote:
>
> >   - to be able to find where the patch should be applied; I
> >     sometimes receive patches for GCC directory "gcc/ada/", diffed
> >     from there, and if StGit could see that the patch only makes
> >     sense there and not at the top-level it would be great as well
>
> I don't believe git-apply can do this (please correct me if I'm
> wrong)

It does have a --directory flag, but that requires the user to specify
the path manually.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
