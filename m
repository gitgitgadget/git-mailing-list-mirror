From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-email automatic --to detection?
Date: Mon, 25 Feb 2008 09:08:20 -0600
Message-ID: <200802250908.21182.jgoerzen@complete.org>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org> <20080225143959.GS31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 16:54:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTff2-0000Lh-TS
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 16:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbYBYPxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 10:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYBYPxw
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 10:53:52 -0500
Received: from gatekeeper.excelhustler.com ([69.44.136.67]:49155 "EHLO
	excelhustler.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753971AbYBYPxv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 10:53:51 -0500
X-Greylist: delayed 2727 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2008 10:53:51 EST
Received: from jgoerzen by wile.internal.excelhustler.com with local (Exim 4.68)
	(envelope-from <jgoerzen@complete.org>)
	id 1JTewH-0002rf-6Y; Mon, 25 Feb 2008 09:08:21 -0600
User-Agent: KMail/1.9.7
In-Reply-To: <20080225143959.GS31441@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75034>

On Mon February 25 2008 8:39:59 am Miklos Vajna wrote:
> On Sun, Feb 24, 2008 at 04:29:56PM -0600, John Goerzen 
<jgoerzen@complete.org> wrote:
> > As far as I can tell from looking at git-send-email(1),
> > git-format-patch(1), and git-config(1), git doesn't have this
> > capability.  Is that correct?
>
> i don't think so. what about git config sendemail.to?

But that must be applied locally.  It is not pulling that down from the 
remote repo before the send, which is the point of all this.


>
> - VMiklos
