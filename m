From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 07:25:17 +0200
Message-ID: <87d5c4ajlu.fsf@mid.deneb.enyo.de>
References: <20060706055729.GA12512@admingilde.org>
	<87k66p8jee.fsf@mid.deneb.enyo.de>
	<Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<87fyh1ncm0.fsf@mid.deneb.enyo.de>
	<f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com>
	<20060716223607.GA6023@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 17 08:26:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2MZ5-000240-FV
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 08:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWGQG0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 02:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWGQG0j
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 02:26:39 -0400
Received: from mail.enyo.de ([212.9.189.167]:21923 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751223AbWGQG0j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 02:26:39 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1G2MYv-0004Ni-ES
	for git@vger.kernel.org; Mon, 17 Jul 2006 08:26:37 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.62)
	(envelope-from <fw@deneb.enyo.de>)
	id 1G2LbZ-0000aK-Gn
	for git@vger.kernel.org; Mon, 17 Jul 2006 07:25:17 +0200
To: git@vger.kernel.org
In-Reply-To: <20060716223607.GA6023@steel.home> (Alex Riesen's message of
	"Mon, 17 Jul 2006 00:36:07 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23966>

* Alex Riesen:

> It is not Cygwin really. It's windows. You can't rename or delete an
> open or mmapped file in that thing.

And GIT's workaround is to read the whole file into memory and close
it after that?  Uh-oh.
