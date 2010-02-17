From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Wed, 17 Feb 2010 23:43:30 +0100
Message-ID: <20100217224330.GB8029@book.hvoigt.net>
References: <20100215225001.GA944@book.hvoigt.net> <7vwryet2cw.fsf@alter.siamese.dyndns.org> <7vocjpnc5v.fsf@alter.siamese.dyndns.org> <7vljetlx8r.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1002160914140.20986@pacific.mpi-cbg.de> <7viq9wzq8g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 23:43:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhscN-0005Jt-SF
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 23:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab0BQWne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 17:43:34 -0500
Received: from darksea.de ([83.133.111.250]:46091 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754193Ab0BQWnd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 17:43:33 -0500
Received: (qmail 22849 invoked from network); 17 Feb 2010 23:43:30 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 17 Feb 2010 23:43:30 +0100
Content-Disposition: inline
In-Reply-To: <7viq9wzq8g.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140267>

On Tue, Feb 16, 2010 at 03:59:43PM -0800, Junio C Hamano wrote:
> -- >8 --
> Subject: Fix use of mutex in threaded grep
> 
> The program can decide at runtime not to use threading even if the support
> is compiled in.  In such a case, mutexes are not necessary and left
> uninitialized.  But the code incorrectly tried to take and release the
> read_sha1_mutex unconditionally.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Acked-by: Fredrik Kuivinen <frekui@gmail.com>

Just to be sure I just tested this one as well. If you like you can add
a:

Tested-by: Heiko Voigt <hvoigt@hvoigt.net>

cheers Heiko
