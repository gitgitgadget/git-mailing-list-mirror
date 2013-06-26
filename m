From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 16:19:54 -0700
Message-ID: <87ehbolasl.fsf@linux-k42r.v.cablecom.net>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-10-git-send-email-tanoku@gmail.com>
	<87y59xlvt7.fsf@linux-k42r.v.cablecom.net>
	<CAFFjANQ_PoTT5bUrZ_0oARz=oZysJdMC1MAsHR2MCZVubfSbsw@mail.gmail.com>
	<87vc50lb4i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Vicent =?utf-8?Q?Mart=C3=AD?= <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 01:20:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urz0P-0006qH-Bj
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 01:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab3FZXUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 19:20:00 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:43065 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102Ab3FZXT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 19:19:59 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 27 Jun
 2013 01:19:52 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (204.16.157.26) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 27 Jun 2013 01:19:57 +0200
In-Reply-To: <87vc50lb4i.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Wed, 26 Jun 2013 16:12:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [204.16.157.26]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229071>

Thomas Rast <trast@inf.ethz.ch> writes:

[...]
> The next word after `L_M` (if any) must again be a RLW, for the next
> chunk.  For efficient appending to the bitstream, the EWAH stores a
> format to the last RLW in the stream.
  ^^^^^^

I have no idea what Freud did there, but "pointer" or some such is
probably a saner choice.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
