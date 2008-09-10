From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert, and more about porcelain-level metadata
Date: Wed, 10 Sep 2008 15:14:24 +0200
Message-ID: <20080910131424.GA7397@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080909230525.GC10360@machine.or.cz> <48C794D6.20001@gnu.org> <20080910104424.GH10360@machine.or.cz> <20080910114940.GA14127@cuci.nl> <20080910123026.GJ10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 10 15:18:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdPXf-00035b-AY
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 15:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbYIJNO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 09:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbYIJNO0
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 09:14:26 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:54807 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbYIJNO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 09:14:26 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id E25445465; Wed, 10 Sep 2008 15:14:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080910123026.GJ10360@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95516>

Petr Baudis wrote:
>On Wed, Sep 10, 2008 at 01:49:40PM +0200, Stephen R. van den Berg wrote:
>> Maybe we have a misunderstanding about what "follow a link" means and
>> when it is done.

>Oh, I'm sorry. By

>	- During fetch/push/pull the full commit including the origin fields is
>	  transmitted, however, the objects the origin links are referring to
>	  are not (unless they are being transmitted because of other reasons).

>I have understood that you fetch the origin target but not commits
>referred from it, but instead you meant that you do not follow the
>origin link at all.

Indeed.
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
