From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] builtin-tag.c: allow arguments in $EDITOR
Date: Sat, 22 Dec 2007 15:50:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712221548540.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071219232326.GA4135@bit.office.eurotux.com>
 <20071220095706.GA9685@bit.office.eurotux.com>
 <Pine.LNX.4.64.0712201255510.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vhcidovxt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Luciano Rocha <luciano@eurotux.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 15:50:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J65gS-0003ee-Ch
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 15:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbXLVOuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 09:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbXLVOuL
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 09:50:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:50921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750884AbXLVOuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 09:50:09 -0500
Received: (qmail invoked by alias); 22 Dec 2007 14:50:08 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp021) with SMTP; 22 Dec 2007 15:50:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Wba4zfzJW8RwVjwYIfKHxuja8/ncsxnKlKbwqtq
	vaNVNE2tSpS+cA
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vhcidovxt.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69137>

Hi,

On Thu, 20 Dec 2007, Junio C Hamano wrote:

> I think something like this patch is probably more appropriate.

Looks obviously fine, especially thinking about this:

> 	GIT_EDITOR='emacs -l $HOME/my-customization.el'

Ciao,
Dscho
