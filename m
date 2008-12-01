From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
Date: Mon, 01 Dec 2008 16:40:26 +0100
Organization: At home
Message-ID: <gh10h8$usu$1@ger.gmane.org>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com> <1228140775-29212-2-git-send-email-gitster@pobox.com> <1228140775-29212-3-git-send-email-gitster@pobox.com> <1228140775-29212-4-git-send-email-gitster@pobox.com> <1228140775-29212-5-git-send-email-gitster@pobox.com> <1228140775-29212-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 16:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7AuH-0007O4-Ov
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 16:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbYLAPkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 10:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYLAPkh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 10:40:37 -0500
Received: from main.gmane.org ([80.91.229.2]:47068 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbYLAPkg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 10:40:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L7Asz-00028p-2r
	for git@vger.kernel.org; Mon, 01 Dec 2008 15:40:33 +0000
Received: from abwt156.neoplus.adsl.tpnet.pl ([83.8.243.156])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 15:40:33 +0000
Received: from jnareb by abwt156.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 15:40:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwt156.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102052>

Junio C Hamano wrote:

> This implements the server side of protocol extension to show which branch
> the HEAD points at.  The information is sent after the terminating NUL
> that comes after the server capabilities list, to cause older clients to
> ignore it, while allowing newer clients to make use of that information

By the way, is negotiating protocol extensions, and supported protocol
extensions documented somewhere in Documentation/technical/ ?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
