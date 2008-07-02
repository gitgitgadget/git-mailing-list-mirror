From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 20:37:01 +0200
Message-ID: <20080702183701.GE16235@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org> <20080702174255.GB16235@cuci.nl> <20080702182510.GC29559@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 20:38:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE7DQ-0005Gx-Ho
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 20:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbYGBShF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 14:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752651AbYGBShF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 14:37:05 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:37457 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbYGBShE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 14:37:04 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B326B5465; Wed,  2 Jul 2008 20:37:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080702182510.GC29559@glandium.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87176>

Mike Hommey wrote:
>> These edits are numerous and spread over many months, so the typical 
>> history fixup-sessions involve periods where you make 30 random
>> historicaledits per hour (which need to be viewed and checked every time
>> immediately after making the change).  And say once every 4 months, you
>> run it through git filter-branch to cast everything into stone.  A
>> typical git filter-branch run takes 15 minutes on a repository this
>> size.

>I think the point was more about making a tool to do exactly what you
>want, based on the new git sequencer. Note that git filter-branch could
>also be rewritten to use the sequencer.

As far as I understood it, the new git sequencer rewrites history
proper.  That is timeconsuming by definition, and thus it is *not*
possible to make a tool based on the sequencer that supports the desired
iterative-history-rewrite workflow.
-- 
Sincerely,
           Stephen R. van den Berg.

You are confused; but this is your normal state.
