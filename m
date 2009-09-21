From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Mon, 21 Sep 2009 11:58:45 -0500
Message-ID: <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil>
References: <20090921160551.GD8173@gryning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: c@gryning.com
X-From: git-owner@vger.kernel.org Mon Sep 21 18:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpmEX-0005hB-30
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 18:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbZIUQ7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 12:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbZIUQ7M
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 12:59:12 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43696 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbZIUQ7L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 12:59:11 -0400
Received: by mail.nrlssc.navy.mil id n8LGwkG4010045; Mon, 21 Sep 2009 11:58:47 -0500
In-Reply-To: <20090921160551.GD8173@gryning.com>
X-OriginalArrivalTime: 21 Sep 2009 16:58:46.0218 (UTC) FILETIME=[C85C2AA0:01CA3ADC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128897>

Craig Taylor wrote:
> Hi all
> 
> I'm compiling/installing git in a Solaris environment without root.
> Using 'make DESTDIR=<some path> install' to stage an install to an
> alternate location.
> The perl module component of 'make DESTDIR=<some path> install' installs
> into the system perl lib path without prepending the forced install
> destination or my '--prefix'.
> This seems counter intuitive and I would consider a bug.

Try 'make prefix=<some path>'.

btw, this is in the first paragraph of the INSTALL document.

-brandon
