From: Marc Liyanage <marc@entropy.ch>
Subject: Re: Unable to checkout a particular SVN revision
Date: Sat, 28 Nov 2009 22:41:36 -0800
Message-ID: <C190685B-C096-46A3-B03C-3219C481107C@entropy.ch>
References: <718EEBA2-FA4B-402D-B2FC-A8F14D79F6FF@entropy.ch> <4B113BAD.8090604@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Nov 29 07:41:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEdTh-0006yo-Ay
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 07:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbZK2Glg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 01:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZK2Glg
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 01:41:36 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:40642 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbZK2Glf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Nov 2009 01:41:35 -0500
Received: by yxe26 with SMTP id 26so2262394yxe.4
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 22:41:42 -0800 (PST)
Received: by 10.151.1.3 with SMTP id d3mr4648399ybi.305.1259476901415;
        Sat, 28 Nov 2009 22:41:41 -0800 (PST)
Received: from ?192.168.7.124? ([69.12.229.253])
        by mx.google.com with ESMTPS id 23sm1203421ywh.18.2009.11.28.22.41.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 22:41:40 -0800 (PST)
In-Reply-To: <4B113BAD.8090604@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133995>


Thanks for the explanation so far.

On 28.11.2009, at 07:03, Michael J Gruber wrote:

> No. Because "this" is different in the two cases above: "git svn clone"
> clones the history of an svn repo, and the command above clearly gives
> you the history of that branch in the specified revision range
> (consisting of 1 revision). It is empty.

I still don't quite understand why it couldn't do the same thing as the SVN checkout. That does exactly what I expect, it reflects the state of that part of the repository at the time of that revision. Would this be possible, but it's simply not (yet) implemented?

The problem I'm dealing with are svn:externals definitions that are pegged to such revisions. SVN checks them out fine, but git svn doesn't, so I have to hunt down the appropriate revision manually.




______________________________
Marc Liyanage
www.entropy.ch

skype mliyanage
iChat liyanage@mac.com
