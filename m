From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH v2] Replace hard-coded path with one from <paths.h>
Date: Tue, 13 Apr 2010 10:06:04 +0100
Message-ID: <20100413090604.GB770@arachsys.com>
References: <7vk4sm7vao.fsf@alter.siamese.dyndns.org>
 <20100404222801.GB31315@arachsys.com>
 <20100406163525.GF15306@arachsys.com>
 <20100406163643.GG15306@arachsys.com>
 <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
 <20100408105850.GD2146@arachsys.com>
 <m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
 <20100408115706.GE2077@arachsys.com>
 <z2o40aa078e1004080508z17c5e71by371bbe6e1cdb8c50@mail.gmail.com>
 <20100409054536.GB2151@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 13 11:06:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1c4W-0000Pf-EJ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 11:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab0DMJGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 05:06:10 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:40279 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0DMJGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 05:06:09 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1O1c4L-0000Kv-HZ; Tue, 13 Apr 2010 10:06:06 +0100
Content-Disposition: inline
In-Reply-To: <20100409054536.GB2151@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144798>

Chris Webb <chris@arachsys.com> writes:

> Erik Faye-Lund <kusmabite@googlemail.com> writes:
> 
> > Are you sure that all non-Windows platforms have paths.h? It seems
> > that at least some Open Solaris versions[1] are missing it as well.
> > Perhaps this should be guarded by a HAVE_PATHS_H define instead?
> 
> Yes, you're probably right. I'll just set HAVE_PATHS_H for the platforms I'm
> sure (or can check) have it for now.

Sorry for the slow follow up. Replacement patch in follow-up that tries this
only on Linux, *BSD and GNU where it's known to work. Should be completely
safe now!

Best wishes,

Chris.
