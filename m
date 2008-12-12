From: jidanni@jidanni.org
Subject: Re: user-manual.html invalid HTML
Date: Fri, 12 Dec 2008 10:47:27 +0800
Message-ID: <87hc5ahzy8.fsf@jidanni.org>
References: <20081212023003.GD23128@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 507476@bugs.debian.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Fri Dec 12 03:49:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy5b-0005JU-Qd
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591AbYLLCrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757576AbYLLCrb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:47:31 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:56950 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757553AbYLLCra (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2008 21:47:30 -0500
Received: from jidanni1.jidanni.org (122-127-32-244.dynamic.hinet.net [122.127.32.244])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 6856F119DE0;
	Thu, 11 Dec 2008 18:47:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102881>

>>>>> "JK" == Jeff King <peff@peff.net> writes:

JK> On Fri, Dec 12, 2008 at 04:32:15AM +0800, jidanni@jidanni.org wrote:
>> Please see http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=507476
>> Which it turns out didn't get forwarded to git@vger.kernel.org after all. 

JK> The versions I build locally have:

JK> <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
JK>     "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

JK> in each HTML file, which is added by asciidoc.  Maybe the package you
JK> are looking at was built with an older version of asciidoc that doesn't
JK> do this (I don't actually know the history of this feature, but it seems
JK> to me that this is something asciidoc should be doing, not git).

JK> -Peff

OK, adding 507476@bugs.debian.org to the CCs.
