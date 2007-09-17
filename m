From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Blaming diffs
Date: Mon, 17 Sep 2007 07:40:00 +0200
Message-ID: <200709170740.00917.chriscool@tuxfamily.org>
References: <20070916163829.GA6679@glandium.org> <200709170659.15655.chriscool@tuxfamily.org> <20070917045704.GH3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX9EA-0005Qx-Dn
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 07:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbXIQFcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 01:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbXIQFcy
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 01:32:54 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:45018 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbXIQFcx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2007 01:32:53 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id CF8EF1AB2CB;
	Mon, 17 Sep 2007 07:32:52 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B48BB1AB2C2;
	Mon, 17 Sep 2007 07:32:52 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20070917045704.GH3099@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58388>

Le lundi 17 septembre 2007, Shawn O. Pearce a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> wrote:
> > I don't know if that's what you are looking for but perhaps you cou=
ld
> > use "git bisect run". You just need to pass it a script that return=
s 1
> > when it finds the changes and 0 otherwise. (See git-bisect man page=
=2E)
>
> That's very inefficient to search for something...

Perhaps but you can search using whatever script or command you want/kn=
ow.=20
You are not limited by those implemented in git.

You can also make it more efficient with "git bisect {start,good,bad}".

Regards,
Christian.
