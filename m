From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Mon, 15 Oct 2007 22:33:47 +0200
Message-ID: <0C82FD96-2CF9-4E66-91EB-DBC2CFF003E8@adacore.com>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org> <471302D2.6010405@trolltech.com> <ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com> <200710150902.52653.johan@herland.net> <7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com> <ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"David Kastrup" <dak@gnu.org>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	=?ISO-8859-1?Q? "Ren=E9_Scharfe" ?= <rene.scharfe@lsrfire.ath.cx>,
	"Junio Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 23:29:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhX2A-0000Zo-32
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 22:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXJOU67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 16:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbXJOU66
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 16:58:58 -0400
Received: from rock.gnat.com ([205.232.38.15]:54030 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbXJOU65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 16:58:57 -0400
X-Greylist: delayed 1504 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2007 16:58:57 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id B32881E7854;
	Mon, 15 Oct 2007 16:33:52 -0400 (EDT)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xg7jq7kgwlaM; Mon, 15 Oct 2007 16:33:52 -0400 (EDT)
Received: from [????N???p???b??$IPv6:::1] (nile.gnat.com [205.232.38.5])
	by rock.gnat.com (Postfix) with ESMTP id 18E7B1E7840;
	Mon, 15 Oct 2007 16:33:49 -0400 (EDT)
In-Reply-To: <ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61040>

On Oct 15, 2007, at 13:53, David Symonds wrote:
> That's also why I suggested "skip"; you might not be able to test a
> particular commit, but you might also not *want* to test a particular
> commit for some reason.

Skip seems a great choice: it directly expresses the wish to
not consider a certain commit. The reason is unimportant.
