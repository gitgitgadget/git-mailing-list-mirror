From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Tue, 16 Dec 2008 03:07:33 +0100
Message-ID: <49470D65.40808@gmx.ch>
References: <4946F4D9.8050803@gmx.ch> <87zlixvtu9.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: jidanni@jidanni.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 03:08:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCPMk-0008PH-2y
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 03:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYLPCHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 21:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbYLPCHg
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 21:07:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:33527 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751643AbYLPCHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 21:07:36 -0500
Received: (qmail invoked by alias); 16 Dec 2008 02:07:34 -0000
Received: from 36-167.3-85.cust.bluewin.ch (EHLO [192.168.123.204]) [85.3.167.36]
  by mail.gmx.net (mp049) with SMTP; 16 Dec 2008 03:07:34 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/lbppD/YjlLnaHZHrr5AK35aNVFKtgBvT2WhKooR
	A9oNz3f4+kgW8r
User-Agent: Thunderbird 2.0.0.18 (X11/20081123)
In-Reply-To: <87zlixvtu9.fsf@jidanni.org>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103234>

jidanni@jidanni.org wrote:
> JH> So maybe what you really want is an ETA display during the cloning
> JH> process?  Sounds like a good idea to me.
> 
> ETA implies that git has an estimate of what is going to happen.

Aren't you implying this too from the beginning?  But reading
Jeff's reply, there seems to be a reason why there isn't an ETA
already.

However, since some repositories get cloned in the same way very
often, there could be some cache that keeps these size information
around for any subsequent identical clones.  The server could then
send a hint about the expected amount of data at the beginning.

jlh
