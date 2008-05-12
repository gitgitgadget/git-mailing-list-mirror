From: Thomas Hunger <hto@arcor.de>
Subject: Re: multiple files for the same hook
Date: Mon, 12 May 2008 21:56:30 +0000
Message-ID: <200805122156.30896.hto@arcor.de>
References: <200805122039.49779.hto@arcor.de> <20080512204445.GT27724@genesis.frugalware.org>
Reply-To: hto@arcor.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 23:58:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvg1u-00020K-Re
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 23:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbYELV5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 17:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbYELV5I
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 17:57:08 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:50576 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751197AbYELV5H (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2008 17:57:07 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 9332C17F776
	for <git@vger.kernel.org>; Mon, 12 May 2008 23:57:04 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 4EABB510831
	for <git@vger.kernel.org>; Mon, 12 May 2008 23:57:23 +0200 (CEST)
Received: from [192.168.1.101] (cpc1-cmbg11-0-0-cust771.cmbg.cable.ntl.com [86.22.75.4])
	(Authenticated sender: thuner@arcor.de)
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 4DAB135AAF4
	for <git@vger.kernel.org>; Mon, 12 May 2008 23:57:04 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080512204445.GT27724@genesis.frugalware.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92.1/7105/Mon May 12 22:14:20 2008 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81956>

Miklos, Sverre,

> why would you want so? just create a script named
> hooks/post-commit, like:

you are right, it's what we actually do, using --template to set up 
our own scripts. If nobody but us needs this it's certainly not worth 
bothering.

Thanks
Tom
