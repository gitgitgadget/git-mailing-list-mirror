From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/3] Add -n/--no-prompt option to mergetool
Date: Tue, 21 Oct 2008 13:26:55 +0100
Message-ID: <20081021122655.GA29294@hashpling.org>
References: <1224583999-26279-1-git-send-email-charles@hashpling.org> <1224583999-26279-2-git-send-email-charles@hashpling.org> <48FDC1CA.2080800@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	William Pursell <bill.pursell@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Theodore Ts'o" <tytso@mit.edu>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 21 14:28:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsGLm-0004ym-4c
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 14:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbYJUM1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 08:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbYJUM1I
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 08:27:08 -0400
Received: from pih-relay05.plus.net ([212.159.14.18]:40224 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbYJUM1H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 08:27:07 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1KsGK8-0001js-N8; Tue, 21 Oct 2008 13:26:56 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m9LCQtev029763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Oct 2008 13:26:55 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m9LCQtTK029762;
	Tue, 21 Oct 2008 13:26:55 +0100
Content-Disposition: inline
In-Reply-To: <48FDC1CA.2080800@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 980a42bf6b32592a7376d485c144c175
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98784>

On Tue, Oct 21, 2008 at 01:49:30PM +0200, Andreas Ericsson wrote:
>
> There is discussion already about "-n should be for dry-run!" and git's
> inconsistencies in such matters. Wouldn't -y ("assume yes on prompt")
> be better?
>

I must have missed this discussion. I've just had a very quick look at
a handful of basic modifying git commands (merge, pull, commit,
checkout, reset, revert) and only found 'add' that used -n as
--dry-run.

That said, I've no real objections to -y if that makes for a better
consensus.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
