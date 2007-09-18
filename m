From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 1/1] git-send-email: Add a --suppress-all option
Date: Tue, 18 Sep 2007 09:22:51 -0400
Message-ID: <20070918132251.GB12120@fieldses.org>
References: <11900540373215-git-send-email-felipebalbi@users.sourceforge.net> <46EF8107.1030607@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Balbi <felipebalbi@users.sourceforge.net>,
	git@vger.kernel.org, Felipe Balbi <felipe.lima@indt.org.br>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 18 15:23:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXd2c-00015k-MI
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 15:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbXIRNW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 09:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbXIRNW5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 09:22:57 -0400
Received: from mail.fieldses.org ([66.93.2.214]:60453 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616AbXIRNW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 09:22:56 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IXd2R-0003bJ-Sl; Tue, 18 Sep 2007 09:22:51 -0400
Content-Disposition: inline
In-Reply-To: <46EF8107.1030607@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58605>

On Tue, Sep 18, 2007 at 09:40:55AM +0200, Andreas Ericsson wrote:
> Felipe Balbi wrote:
>> From: Felipe Balbi <felipe.lima@indt.org.br>
>> This patch adds a --suppress-all option to avoid sending emails
>> to everybody but the ones listed by --to option.
>
> To my minds eye, --suppress-all is equivalent to --dry-run. Could you
> rename it to "--cc-nobody" or some such?
>
> On a side-note, I've never really understood why git-send-email *by 
> default*
> sends to a bazillion people. Does anybody ever use it without suppressing
> most of the CC targets?

Yes.  I never suppress the cc's.  The cc-everyone thing is standard on
the kernel mailing lists.

The one exception is if I'm just sending the series to myself as a test.

--b.
