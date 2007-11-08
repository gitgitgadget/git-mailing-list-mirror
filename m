From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 8 Nov 2007 21:44:10 +0100
Message-ID: <6EB4B3BC-7538-45CF-AEF3-3B3D23DADF0E@zib.de>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 21:44:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqEEt-0005PS-NB
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 21:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762063AbXKHUnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 15:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761451AbXKHUnt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 15:43:49 -0500
Received: from mailer.zib.de ([130.73.108.11]:61512 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761425AbXKHUnt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 15:43:49 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA8KgvNd027079;
	Thu, 8 Nov 2007 21:43:13 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA8KgqVH004070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 8 Nov 2007 21:42:53 +0100 (MET)
In-Reply-To: <7vir4d40sw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64069>


On Nov 8, 2007, at 9:08 AM, Junio C Hamano wrote:

> * sp/push-refspec (Sun Oct 28 18:46:20 2007 +0100) 5 commits
>  - push: teach push to pass --verbose option to transport layer
>  - push: use same rules as git-rev-parse to resolve refspecs
>  - add ref_abbrev_matches_full_with_rev_parse_rules() comparing
>    abbrev with full ref name
>  - rename ref_matches_abbrev() to
>    ref_abbrev_matches_full_with_fetch_rules()
>  - push: support pushing HEAD to real branch name
>
> Really need to look at this series to merge to 'next'.  Sorry.

Take your time. There is a slight chance that I'll unify
ref_abbrev_matches_full_with_rev_parse_rules() and  
ref_abbrev_matches_full_with_fetch_rules() over the weekend.

	Steffen
