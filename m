From: Henk <henk_westhuis@hotmail.com>
Subject: Re: GitExtensions 1.43 crash with large repository
Date: Sun, 15 Feb 2009 07:52:53 -0800 (PST)
Message-ID: <1234713173797-2330184.post@n2.nabble.com>
References: <63BEA5E623E09F4D92233FB12A9F794302E0F326@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 16:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYjKe-00069s-I3
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 16:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbZBOPw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 10:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbZBOPw4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 10:52:56 -0500
Received: from kuber.nabble.com ([216.139.236.158]:38210 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbZBOPw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 10:52:56 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LYjIb-00066f-Pv
	for git@vger.kernel.org; Sun, 15 Feb 2009 07:52:53 -0800
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302E0F326@emailmn.mqsoftware.com>
X-Nabble-From: henk_westhuis@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110018>


Hi,

I do not monitor this list very closely, so I miss a lot if you post it
here.
A better place to report bug is on the gitextensions project on sourceforge:
http://sourceforge.net/forum/forum.php?forum_id=892327

It might be possible that the number of commits is bigger than the max that
fits in an integer. How many commits does the repository count?

If this is the case, I can fix this by replacing the int for a UInt or a
long.

Henk
-- 
View this message in context: http://n2.nabble.com/GitExtensions-1.43-crash-with-large-repository-tp2321978p2330184.html
Sent from the git mailing list archive at Nabble.com.
