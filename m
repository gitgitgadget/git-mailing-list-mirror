From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Mon, 25 Aug 2008 12:49:00 +0100
Message-ID: <1219664940.9583.42.camel@pmac.infradead.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, users@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 13:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXaaK-0003gG-Ur
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 13:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbYHYLtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 07:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYHYLtH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 07:49:07 -0400
Received: from casper.infradead.org ([85.118.1.10]:41225 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbYHYLtF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 07:49:05 -0400
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by casper.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KXaYF-0005fo-JA; Mon, 25 Aug 2008 11:48:03 +0000
In-Reply-To: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93612>

On Sat, 2008-08-23 at 20:33 -0700, Junio C Hamano wrote:
> 
> There is one alternative, and one augmentation:
> 
>  (A) We do not do anything.
> 
>  (B) In addition to the main transition plan, outside git, prepare an
>      optional "git-old-style" package that installs many "git-foo"
>      wrappers in $PATH (i.e. /usr/bin).  Each of them exec "git foo".
>      People who like the dashed form can keep typing "git-foo", even
>      though that will cost them two exec()s.

  (C) Just don't do it. Leave the git-foo commands as they were. They
      weren't actually hurting anyone, and you don't actually _gain_
      anything by removing them. For those occasional nutters who
      _really_ care about the size of /usr/bin, give them the _option_
      of a 'make install' without installing the aliases.

(Oh look, my /usr/bin has 3806 files in it. And except when I
accidentally point the $%#@&! GNOME file dialog box at it, I don't
_care_.)

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
