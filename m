From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Tue, 28 May 2013 12:30:50 +0200
Message-ID: <20130528103050.GD2192@goldbirke>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
 <20130521224119.GF30969@goldbirke> <87a9nn31wj.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, felipe.contreras@gmail.com, gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 12:31:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhHBD-0005K5-7i
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 12:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375Ab3E1Kaz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 May 2013 06:30:55 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:49487 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab3E1Kay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 06:30:54 -0400
Received: from localhost6.localdomain6 (f051074182.adsl.alicedsl.de [78.51.74.182])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0Lo18K-1UEZBz0wFE-00fwGf; Tue, 28 May 2013 12:30:51 +0200
Content-Disposition: inline
In-Reply-To: <87a9nn31wj.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:BKv01ZaKWw3CTpmo/fjHz4MnkCZmHz/OSfKw+4hrLAT
 dhWGsrLOvxuGQPnORVWQWzV/8iodzy+MFa0i+Fz0QZdahap+Cc
 Do/DAvUq4Wxh/Z9quav5hiOyrHals32ZBLe+sxrTmBNkULMB/A
 uDBCLlDgqITgIlHd1xk38OmQpm8fgaUtmxTZtJ8sbbiqmbnoBh
 +ZmnD4E6IGgHNQpCCLkSRMlS0sbp7KrryJG+CmBbfnPcGCJKtF
 En1JXa0L8+hQ4lsxCjRUZBuHEk4tdkknb5jFyeEUZCvdhiGBC5
 d4HBfviDu/dov1P4BaFtPK2ivgNziuT4wwlP2OdHaXT+gf3JWW
 IEmkxdt05AXxPDjt+wNg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225627>

Hi,

On Wed, May 22, 2013 at 09:32:44AM +0200, Thomas Gummerer wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
> > On Tue, May 21, 2013 at 10:54:27PM +0200, Thomas Gummerer wrote:
> >> -			svn_remote[ $((${#svn_remote[@]} + 1)) ]=3D"$value"
> >> +			svn_remote[$((${#svn_remote[@]} + 1))]=3D"$value"
> >
> > I mean, did zsh really complained because of the space after the '[=
' ?!
>=20
> Yes, removing the spaces after the '[' fixes the problem.  I'm not ve=
ry
> proficient in shell scripting, so I can't tell if there is another
> cause.

Thanks.  I first suspected that this was just an independent style
cleanup, that's why I asked for clarification.


G=E1bor
