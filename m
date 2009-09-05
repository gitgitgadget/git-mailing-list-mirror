From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git+http:// proof-of-concept (not using CONNECT)
Date: Sat, 5 Sep 2009 01:23:13 -0700
Message-ID: <20090905082313.GA26131@dcvr.yhbt.net>
References: <20090702085440.GC11119@dcvr.yhbt.net> <85647ef50907020252u41e36187jaacacad3d8a10f75@mail.gmail.com> <20090703202839.GB12072@dcvr.yhbt.net> <alpine.LSU.2.00.0907071712580.30197@hermes-2.csi.cam.ac.uk> <20090707205003.GA31195@dcvr.yhbt.net> <ed88cb980908260734x78382052t30d4cdcf07451134@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Finch <dot@dotat.at>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Douglas Campos <douglas@theros.info>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:23:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjqYM-0004bp-DA
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757090AbZIEIXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbZIEIXM
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:23:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43616 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666AbZIEIXL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:23:11 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 2C0A71F78F;
	Sat,  5 Sep 2009 08:23:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <ed88cb980908260734x78382052t30d4cdcf07451134@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127794>

Douglas Campos <douglas@theros.info> wrote:
> Any news about this approach? I've heard some noise about a CGI
> implementation....

Hi Douglass,

I've been busy with other things.  This approach is probably
too limited to get around HTTP-aware proxies to be useful for
non-git:// users anyways.

It also turns out the curl patch that made it into 7.19.6 was still
unsuitable for bidirectional tunneling, looks like I'll have to port
curl over to the curl_multi_* interface to get it working properly
instead...

-- 
Eric Wong
