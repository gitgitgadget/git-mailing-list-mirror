From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] Replace hard-coded path with one from <paths.h>
Date: Thu, 8 Apr 2010 11:58:51 +0100
Message-ID: <20100408105850.GD2146@arachsys.com>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com>
 <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
 <20100404222801.GB31315@arachsys.com>
 <20100406163525.GF15306@arachsys.com>
 <20100406163643.GG15306@arachsys.com>
 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 08 13:00:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzpTe-0007p4-F8
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 13:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758518Ab0DHLAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 07:00:44 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:33913 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758368Ab0DHLAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 07:00:43 -0400
Received: from [212.183.140.38] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NzpTV-0007cs-EU; Thu, 08 Apr 2010 12:00:41 +0100
Content-Disposition: inline
In-Reply-To: <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144351>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> > +#include <paths.h>
> 
> This breaks on Windows due to missing paths.h. I guess you need some
> guard to detect if the header is present or not.

Is this true of all WIN32, or just __MINGW32__ / __CYGWIN__? Presumably
/usr/local/bin:/usr/bin:/bin is the wrong default PATH on windows too, so
perhaps I should sort that at the same point---what would a canonical
default PATH be for Windows?

Cheers,

Chris.
