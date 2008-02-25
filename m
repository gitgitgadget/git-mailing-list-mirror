From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 09:06:53 +0100
Message-ID: <20080225080653.GA20048@auto.tuwien.ac.at>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at> <20080225030404.GL8410@spearce.org> <20080225072658.GB15761@auto.tuwien.ac.at> <7vwsotmqq2.fsf@gitster.siamese.dyndns.org> <20080225075242.GD15761@auto.tuwien.ac.at> <7vmyppmpko.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYN0-00032I-DK
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYBYIGz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 03:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbYBYIGz
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:06:55 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:44076 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbYBYIGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:06:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id BD81A680B59E;
	Mon, 25 Feb 2008 09:06:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wkH81J7Ct2ui; Mon, 25 Feb 2008 09:06:53 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id A1F12680B59A; Mon, 25 Feb 2008 09:06:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vmyppmpko.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75007>

On Mon, Feb 25, 2008 at 12:02:15AM -0800, Junio C Hamano wrote:
> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
>=20
> > What about
> > #define OBJ_BAD -2
>=20
> You mean "#define OBJ_ANY -2"?

Yes.

Should it go into cache.h or should it stay in fsck.h?

mfg Martin K=F6gler
