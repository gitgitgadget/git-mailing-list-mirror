From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Creating something like increasing revision numbers
Date: Mon, 19 Oct 2009 08:21:48 +0200
Message-ID: <4ADC057C.708@viscovery.net>
References: <20091018144158.GA9789@gandalf.dynalias.org> <alpine.LNX.2.00.0910181727130.32515@iabervon.org> <20091019004447.GC11739@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Mon Oct 19 08:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzlcz-0003wt-Pt
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 08:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbZJSGVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 02:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbZJSGVr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 02:21:47 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16080 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbZJSGVq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 02:21:46 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mzlcp-0001Qs-Nr; Mon, 19 Oct 2009 08:21:47 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 56BCD4E9; Mon, 19 Oct 2009 08:21:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091019004447.GC11739@gamma.logic.tuwien.ac.at>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130659>

Norbert Preining schrieb:
> On So, 18 Okt 2009, Daniel Barkalow wrote:
>> of the *content* is non-linear, the sequence of values stored in 
>> refs/heads/master on your central server is linear, local, and easy to 
>> enumerate.
> 
> That is exactely what I need.

You can always run 'git rev-list master | wc -l' to get a sequence number.
You can throw in --first-parent if you do not want to count commits that
entered master through a merge commit.

You can configure your reflogs such that they do not expire. Then you
count the entries in the reflog.

-- Hannes
