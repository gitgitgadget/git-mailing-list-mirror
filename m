From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] user-manual: fix clone and fetch typos
Date: Tue, 8 May 2007 12:12:37 +0200
Message-ID: <20070508101237.GA27119@diana.vm.bytemark.co.uk>
References: <-1060540797535999820@unknownmsgid> <8aa486160705070027g2cb6797fy5acbe338e30429ff@mail.gmail.com> <20070508030732.GB9471@fieldses.org> <20070508033426.GD9471@fieldses.org> <20070508034129.GE9471@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue May 08 12:13:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlMgo-0008Gq-96
	for gcvg-git@gmane.org; Tue, 08 May 2007 12:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966316AbXEHKM5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 06:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966377AbXEHKM5
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 06:12:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2861 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966316AbXEHKM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 06:12:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HlMgQ-0007C0-00; Tue, 08 May 2007 11:12:38 +0100
Content-Disposition: inline
In-Reply-To: <20070508034129.GE9471@fieldses.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46560>

On 2007-05-07 23:41:29 -0400, J. Bruce Fields wrote:

> Hm.  I still see
>
>       Content-Type:   text/plain; charset=3Diso-8859-1
>
> in the headers

But this time, it looks good to me. This is probably because the
headers say the body is QP-encoded latin1:

  Content-Type:   text/plain; charset=3Diso-8859-1
  Content-Transfer-Encoding: QUOTED-PRINTABLE

and the body actually _is_ QP-encoded latin1:

  More typo fixes from Santi B=3DE9jar

Note how the "=E9" is encoded with only one byte this time, like it's
supposed to in latin1.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
