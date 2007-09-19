From: David Brown <git@davidb.org>
Subject: Re: State of Perforce importing.
Date: Tue, 18 Sep 2007 17:27:22 -0700
Message-ID: <20070919002722.GB22187@old.davidb.org>
References: <20070917193027.GA24282@old.davidb.org> <20070918233749.GA19533@old.davidb.org> <46F06C0C.8090201@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 02:27:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXnPc-0006v9-L9
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 02:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbXISA1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 20:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbXISA1X
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 20:27:23 -0400
Received: from mail.davidb.org ([66.93.32.219]:34752 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbXISA1X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 20:27:23 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IXnPW-0005oz-Qn; Tue, 18 Sep 2007 17:27:22 -0700
Mail-Followup-To: Sam Vilain <sam@vilain.net>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46F06C0C.8090201@vilain.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58668>

On Wed, Sep 19, 2007 at 12:23:40PM +1200, Sam Vilain wrote:
>David Brown wrote:
>> 
>> An additional problem:
>> 
>>    - git-p4 doesn't preserve the execute permission bit from Perforce.
>
>FWIW I found that bit on bit 9 of the 'file type' flag in the db, which
>is the third column in the "db.rev" table.  It's used to come up with
>the silly names like "text" vs "xtext" (difference?  well, one's
>executable of course).

It does come back in the 'kind' field when it asks the client for the file
type.  I'll look into using that information to set the execute bit in the
mode it sends off.

Dave
