From: Constantine Gorbunov <konstunn@ngs.ru>
Subject: Re:
Date: Thu, 6 Feb 2014 19:56:12 +0000 (UTC)
Message-ID: <loom.20140206T205117-635@post.gmane.org>
References: <web-57771132@mx45.intranet.ru> <52F38C1D.709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 07 04:40:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBcIX-0002HK-7f
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 04:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbaBGDkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 22:40:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:46134 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbaBGDkG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 22:40:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WBcIN-00027y-JT
	for git@vger.kernel.org; Fri, 07 Feb 2014 04:40:03 +0100
Received: from l37-193-43-33.novotelecom.ru ([37.193.43.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 04:40:03 +0100
Received: from konstunn by l37-193-43-33.novotelecom.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 04:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 37.193.43.33 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/32.0.1700.107 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241761>

Johannes Sixt <j.sixt <at> viscovery.net> writes:

> 
> Am 2/6/2014 12:54, schrieb konstunn <at> ngs.ru:
> > However I typed the checkout directory in file
> > ..git/info/sparse-checkout by using different formats with
> > and without the leading and the trailing slashes, with and
> > without asterisk after trailing slash, having tried all
> > the possible combinations, but, all the same,
> > nevertheless, the error occured.
> 
> Make sure that you do not use CRLF line terminators in the sparse-checkout
> file.
> 

This is it. Right you are. I've just tried to edit "manually" with notepad 
.git\info\sparse-checkout and found out that there really was a CRLF line 
terminator. After I removed it I managed to succeed in my sparse checkout.
