From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: git config problem with strange config files
Date: Tue, 1 Jan 2008 15:25:48 +0100
Message-ID: <200801011525.48148.kumbayo84@arcor.de>
References: <200712311847.41499.kumbayo84@arcor.de> <20080101061734.GA15453@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 01 15:25:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9i3y-0007Qf-6Y
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 15:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbYAAOZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2008 09:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbYAAOZU
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 09:25:20 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:45886 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753482AbYAAOZT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jan 2008 09:25:19 -0500
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 6F97917F938;
	Tue,  1 Jan 2008 15:25:18 +0100 (CET)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 5E511510040;
	Tue,  1 Jan 2008 15:25:18 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 23500114E4;
	Tue,  1 Jan 2008 15:25:18 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080101061734.GA15453@coredump.intra.peff.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.2/5327/Tue Jan  1 04:29:19 2008 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69437>

On Dienstag 01 Januar 2008, Jeff King wrote:
> On Mon, Dec 31, 2007 at 06:47:41PM +0100, Peter Oberndorfer wrote:
> 
> > In case of a strange .git/config file "git config key value" can
> > create a bogus config entry, where one old value is wrong and the new
> > value resides in the wrong section until the config file is fixed up
> > by hand
> 
> This patch fixes the test case you gave.
> 
> Junio, even though such a config file should be rare, I think this is
> v1.5.4 material. But there is one tricky thing which I will point out in
> a followup mail.
> 
Thank you for the patch

I would also guess this is relative rare, but IIRC somebody posted a patch to 
handle a bogus config with a better message,
and the breakage example in the mail looked similar to mine.

How i came up with this bogus config is relative simple.
I wanted to add a new remote so i copied the already existing remote and 
branch sections down to the last line and somehow also added a trailing tab.

Then i did a stg init which uses git repo-config to add its
stackformatversion = 2 setting

Greetings Peter
