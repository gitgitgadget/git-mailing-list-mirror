From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 01:19:00 +0200
Message-ID: <20080910231900.GF22739@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl> <20080910151015.GA8869@coredump.intra.peff.net> <20080910215045.GA22739@cuci.nl> <20080910215410.GA24432@coredump.intra.peff.net> <20080910223427.GB22739@cuci.nl> <20080910225518.GA24534@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 11 01:20:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdYyp-00078W-HA
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 01:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbYIJXTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 19:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbYIJXTD
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 19:19:03 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:34244 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbYIJXTD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 19:19:03 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 05A145465; Thu, 11 Sep 2008 01:19:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080910225518.GA24534@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95569>

Jeff King wrote:
>On Thu, Sep 11, 2008 at 12:34:27AM +0200, Stephen R. van den Berg wrote:
>> - The origin information is no longer cryptographically protected (under
>>   certain circumstances this could be considered an advantage and a
>>   disadvantage at the same time).

>I haven't thought enough about it to decide whether there is a scenario
>where making such a "cherry-picked from" annotation might make use of
>that property.

Being able to subvert the authenticity of git blame by providing fake
origin information is not very appealing.
-- 
Sincerely,
           Stephen R. van den Berg.

"Am I paying for this abuse or is it extra?"
