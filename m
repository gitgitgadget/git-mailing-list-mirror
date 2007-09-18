From: David Brown <git@davidb.org>
Subject: Re: State of Perforce importing.
Date: Tue, 18 Sep 2007 16:37:49 -0700
Message-ID: <20070918233749.GA19533@old.davidb.org>
References: <20070917193027.GA24282@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:37:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXmdf-0004Ch-PB
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 01:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbXIRXhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 19:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbXIRXhv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 19:37:51 -0400
Received: from mail.davidb.org ([66.93.32.219]:46077 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbXIRXhu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 19:37:50 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1IXmdZ-000566-O0
	for <git@vger.kernel.org>; Tue, 18 Sep 2007 16:37:49 -0700
Mail-Followup-To: Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070917193027.GA24282@old.davidb.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58660>

On Mon, Sep 17, 2007 at 12:30:28PM -0700, David Brown wrote:
> I'd like to track a lot of code living in a Perforce repository, so I've
> been playing with 'git-p4.py'.  Is the one in the contrib/fast-import
> directory the latest version, or is there a better place.
>
> So far, it is having a couple of problems:
>
>   - The commit comment is empty.  It doesn't seem to grab the Perforce
>     description, and the user seems to be <a@b>.
>
>   - Every revision seems to check every file out of Perforce.  This means
>     that for the directory I want, every revision is going to take about 20
>     minutes.

An additional problem:

   - git-p4 doesn't preserve the execute permission bit from Perforce.

David
