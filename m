From: John Goerzen <jgoerzen@complete.org>
Subject: Re: git-svn breaks lots with rewriteRoot
Date: Sat, 8 Mar 2008 14:09:29 -0600
Message-ID: <slrnft5sjp.if8.jgoerzen@katherina.lan.complete.org>
References: <slrnft55gq.1so.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 22:09:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY6Hr-0007gq-68
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 22:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbYCHVIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 16:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbYCHVIV
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 16:08:21 -0500
Received: from main.gmane.org ([80.91.229.2]:36602 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbYCHVIV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 16:08:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JY6HB-0006fy-HN
	for git@vger.kernel.org; Sat, 08 Mar 2008 21:08:17 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 21:08:17 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 21:08:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76587>

On 2008-03-08, John Goerzen <jgoerzen@complete.org> wrote:
> believe both are related to this rewriteRoot.  When I run either of
> these, I see:
>
> Unable to determine upstream SVN information from working tree history

For future reference, I found the problem and have sent in a patch to
fix it here:

http://article.gmane.org/gmane.comp.version-control.git/76576

