From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git.el: Support for incremental status updates.
Date: Tue, 31 Jul 2007 01:22:26 +0200
Message-ID: <20070730232226.GA2413@diana.vm.bytemark.co.uk>
References: <87sl7ekt40.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 01:22:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFeZf-0001fi-2T
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 01:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760088AbXG3XWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Jul 2007 19:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757686AbXG3XWs
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 19:22:48 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4951 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758841AbXG3XWr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 19:22:47 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IFeZG-0000e4-00; Tue, 31 Jul 2007 00:22:26 +0100
Content-Disposition: inline
In-Reply-To: <87sl7ekt40.fsf@wine.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54290>

On 2007-07-24 12:12:47 +0200, Alexandre Julliard wrote:

> +    (if node (ewoc-set-data node info) (ewoc-enter-last status info)=
)))

My emacs doesn't like this. When i do "a" or "U" (and quite possibly
others that I haven't tried yet) I get

  git-insert-fileinfo: Symbol's function definition is void: ewoc-set-d=
ata

The command appears to have been aborted, but if I press "g" to
refresh the display, I see that it has in fact been carried out. So
there is a workaround, at least.

This is GNU Emacs 21.4.1 on Ubuntu 7.04.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
