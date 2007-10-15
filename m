From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 5/7] Bisect: factorise some logging into "bisect_write".
Date: Mon, 15 Oct 2007 05:35:51 +0200
Message-ID: <200710150535.51613.chriscool@tuxfamily.org>
References: <20071014142948.9f08b8ed.chriscool@tuxfamily.org> <Pine.LNX.4.64.0710141706440.25221@racer.site> <8c5c35580710141540j6f93a08j2179c5c394bfacd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Lars Hjemli" <lh@elementstorage.no>
X-From: git-owner@vger.kernel.org Mon Oct 15 05:29:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhGdb-0002kD-PF
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 05:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbXJOD2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 23:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbXJOD2t
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 23:28:49 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:49726 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbXJOD2t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2007 23:28:49 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6D4871AB2AA;
	Mon, 15 Oct 2007 05:28:47 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 524D41AB2A8;
	Mon, 15 Oct 2007 05:28:47 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <8c5c35580710141540j6f93a08j2179c5c394bfacd5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60936>

Le lundi 15 octobre 2007, Lars Hjemli a =C3=A9crit :
> On 10/14/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > Isn't a nolog=3D"$3" missing from bisect_write()?

Yes, you are right. I forgot this line when reorganizing patches before=
=20
submitting. Thanks.

> Good catch, I've amended the commit and replaced q/cc/bisect-dunno
> with this series.

Thanks,
Christian.
