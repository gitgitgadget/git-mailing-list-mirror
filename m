From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git cvsimport fails
Date: Sun, 06 May 2007 08:41:21 +0200
Message-ID: <87lkg2v4ha.fsf@mid.deneb.enyo.de>
References: <87ejm0mtpy.fsf@mid.thomas-huehn.de>
	<87abwomtdl.fsf@mid.thomas-huehn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 08:41:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkaQz-00046A-3X
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbXEFGlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 02:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbXEFGlZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:41:25 -0400
Received: from mail.enyo.de ([212.9.189.167]:3569 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698AbXEFGlZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 02:41:25 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HkaQt-000420-21
	for git@vger.kernel.org; Sun, 06 May 2007 08:41:23 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HkaQr-0001ia-SY
	for git@vger.kernel.org; Sun, 06 May 2007 08:41:21 +0200
In-Reply-To: <87abwomtdl.fsf@mid.thomas-huehn.de> (Thomas =?iso-8859-1?Q?H?=
 =?iso-8859-1?Q?=FChn's?= message of
	"Tue, 01 May 2007 17:54:46 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46304>

* Thomas H=FChn:

> HEAD contains "ref: refs/heads/master", but refs/heads contains no
> "master", just other files.
>
> Can I find out, which hash master should point at?

After the initial checkout, it should point to "origin"; this is the
HEAD of the CVS repository.  Of course, if your main development line
resides on another branch, you should use that.
