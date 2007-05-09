From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on Windows
Date: Wed, 09 May 2007 14:41:59 +0200
Organization: eudaptics software gmbh
Message-ID: <4641C197.58F457CF@eudaptics.com>
References: <loom.20070509T142518-558@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 14:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HllVz-0002s7-6g
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392AbXEIMn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757292AbXEIMn2
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:43:28 -0400
Received: from main.gmane.org ([80.91.229.2]:33145 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756684AbXEIMn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:43:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HllUx-0008Ct-4f
	for git@vger.kernel.org; Wed, 09 May 2007 14:42:27 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2007 14:42:27 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2007 14:42:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46705>

Panagiotis Issaris wrote:
> I'll see if 1.5.1.4 solves this crash, and will most likely have a go at getting
> the MinGW version compiled too.

I don't think that the MinGW version can clone via http out of the box.
If you can, use native git protocol or ssh. They are much preferred over
http anyway (not only on Windows).

-- Hannes
