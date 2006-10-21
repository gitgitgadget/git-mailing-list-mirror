From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 19:51:43 +0200
Message-ID: <200610211951.43495.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <20061020225917.GA30584@coredump.intra.peff.net> <20061021174056.GA29927@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 19:52:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbL10-00074a-Ao
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 19:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993147AbWJURvn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 13:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993159AbWJURvn
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 13:51:43 -0400
Received: from hu-out-0506.google.com ([72.14.214.229]:38414 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2993147AbWJURvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 13:51:42 -0400
Received: by hu-out-0506.google.com with SMTP id 28so595022hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 10:51:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UhneO0W+yr/BzzK+PlgP4cz3aqx+aUdZg6FImu2scj1V4i+G9f2uC8ooRnAnIJGwADje0aZtmB+W8vl5JIACHRMp0dLKfjrSc/s0WN1yHQ3wD/j1JjV+F8aH33PQ9cCU4LrXuLnlT9za7Z4L9fcTnrt8iFZ0stBMBmJIiBGHDF0=
Received: by 10.67.21.11 with SMTP id y11mr4128279ugi;
        Sat, 21 Oct 2006 10:51:37 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id y7sm1425992ugc.2006.10.21.10.51.37;
        Sat, 21 Oct 2006 10:51:37 -0700 (PDT)
To: Jan Hudec <bulb@ucw.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061021174056.GA29927@artax.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29645>

Jan Hudec wrote:

> Besides I start to think that it should be actually possible to solve
> this case with the git-style approach. I have to state beforehand, that
> I don't know how the most recent git algorithm works, but I imagine
> there is some kind of 'brackets' saying the text is in a given file. Now
> if those 'brackets' were not flat, but nested, ie. instead of saying
> 'this is in foo/bar' it would say 'this is in bar is in foo', the
> difference when renaming directory would only affect the 'outer bracket'
> and therefore merge correctly with adding content inside it.

You mean, to consider "contents" of a directory union of contents
of files and directories it contains, and then use the same "rename
detection" algorithm as for files?

-- 
Jakub Narebski
Poland
