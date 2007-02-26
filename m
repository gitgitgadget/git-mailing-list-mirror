From: walt <wa1ter@myrealbox.com>
Subject: Re: Problems installing as root
Date: Sun, 25 Feb 2007 17:32:03 -0800
Organization: none
Message-ID: <ertdaq$mkf$1@sea.gmane.org>
References: <erpljl$ln9$1@sea.gmane.org> <7vejoewyag.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 02:34:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLUky-0003zG-Ne
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 02:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933742AbXBZBeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 20:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933743AbXBZBeW
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 20:34:22 -0500
Received: from main.gmane.org ([80.91.229.2]:42241 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933742AbXBZBeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 20:34:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HLUkL-0001sd-Nx
	for git@vger.kernel.org; Mon, 26 Feb 2007 02:33:46 +0100
Received: from adsl-69-234-193-0.dsl.irvnca.pacbell.net ([69.234.193.0])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 02:33:45 +0100
Received: from wa1ter by adsl-69-234-193-0.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 02:33:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-193-0.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1 (X11/20070225)
In-Reply-To: <7vejoewyag.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40602>

Junio C Hamano wrote:
> walt <wa1ter@myrealbox.com> writes:

>> 'make install' as root leaves dozens of files owned by root
>> in my personal source directory...

> Does 'make all' followed by 'make install' do the same?  If so
> these are indeed very bad.
> 
> If you run 'make all', and then if you run, without changing
> anything to cause rebuilding, run 'make install', the build
> procedure should not create _any_ new file.  Otherwise the build
> procedure is broken and needs to be fixed.

'make all' does exactly the same thing.  (The Makefile says that
'make all' is the default target, so it should behave the same,
no?)

Thanks.
