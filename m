From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Thu, 13 Nov 2008 12:28:44 +0000
Message-ID: <20081113122844.GA26842@hashpling.org>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org> <1224583999-26279-2-git-send-email-charles@hashpling.org> <48FDC1CA.2080800@op5.se> <20081021122655.GA29294@hashpling.org> <20081022211720.GA23146@hashpling.org> <7vr668tdvy.fsf@gitster.siamese.dyndns.org> <20081023064455.GA10675@hashpling.org> <49024CF1.5040406@gmail.com> <20081024225539.GA6119@hashpling.org> <4902F0C2.2070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	"Theodore Ts'o" <tytso@mit.edu>
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0bKs-0003zm-Fw
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 13:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752070AbYKMM2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 07:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbYKMM2y
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 07:28:54 -0500
Received: from pih-relay04.plus.net ([212.159.14.17]:46564 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYKMM2x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 07:28:53 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1L0bJX-000456-Ag; Thu, 13 Nov 2008 12:28:47 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mADCSk1Z027322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 12:28:46 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id mADCSilE027321;
	Thu, 13 Nov 2008 12:28:44 GMT
Content-Disposition: inline
In-Reply-To: <4902F0C2.2070709@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 7c24d02073db92674675c1ef1da81f0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100868>

On Sat, Oct 25, 2008 at 11:11:14AM +0100, William Pursell wrote:
>
> My thinking is that when using an interactive tool
> like vimdiff, the user is probably not going to
> care as much about being prompted, or may prefer
> to have the prompt in that situation.  However,
> if they've written a script to do the merge
> non-interactively, then the prompt is undesirable.
>
> So a person might want to be prompted with
> git mergetool -t vimdiff, and prefer no prompt
> with git mergetool -t my-script.  Being able
> to configure the behavior on a per-tool
> basis would allow that.

I can see your point, although personally I feel that if you've gone
to the trouble of writing a special script, the extra typing of an
extra long option (if you prefer prompting normally) is not that big
compared with the hassle of maintaining per-tool config settings if
you like to regularly swap between merge tools.

Both scenarios are probably not too common so I wouldn't object
strongly to either. (But per tool configs is more dev work!)

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
