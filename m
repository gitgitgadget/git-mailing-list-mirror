From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit] stg import documentation incorrect.
Date: Mon, 4 Aug 2008 14:48:24 +0200
Message-ID: <20080804124823.GA12232@diana.vm.bytemark.co.uk>
References: <48907221.5030608@docte.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin.marinas@gmail.com
To: Jurko Gospodneti? <jurko.gospodnetic@docte.hr>
X-From: git-owner@vger.kernel.org Mon Aug 04 14:27:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPz9h-0006Rz-Mb
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 14:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbYHDM0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 08:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbYHDM0Q
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 08:26:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4891 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbYHDM0P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 08:26:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KPzU8-0003EX-00; Mon, 04 Aug 2008 13:48:24 +0100
Content-Disposition: inline
In-Reply-To: <48907221.5030608@docte.hr>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91345>

On 2008-07-30 15:52:33 +0200, Jurko Gospodneti? wrote:

> StGIT 'stg import' documentation at
> http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT_Tutorial states that
> this command is equivalent to:
>
> > "stg new" followed by "patch -i <file>", then "stg refresh -e"
>
> However, 'stg refresh' does not accept the -e option (which most
> likely has something to do with calling an external editor to edit
> the a log message).

That's right: stg refresh lost the -e option in the 0.14 release.
It'll be added back for the 0.15 release.

Until then, do stg refresh && stg edit.

> Hope this helps.

Yes, the tutorial is in sore need of a fresh coat of paint.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
