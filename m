From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: hitting home directory's parent
Date: Sun, 23 Aug 2009 00:42:02 -0400
Message-ID: <20090823044202.GA10761@panix.com>
References: <20090821200503.GA19660@panix.com> <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com> <20090822150542.GA29507@panix.com> <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 23 06:43:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf4vE-0008VR-IF
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 06:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbZHWEmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 00:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbZHWEmC
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 00:42:02 -0400
Received: from mail1.panix.com ([166.84.1.72]:60338 "EHLO mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbZHWEmB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 00:42:01 -0400
Received: from panix5.panix.com (panix5.panix.com [166.84.1.5])
	by mail1.panix.com (Postfix) with ESMTP id AEAEC1F082
	for <git@vger.kernel.org>; Sun, 23 Aug 2009 00:42:02 -0400 (EDT)
Received: by panix5.panix.com (Postfix, from userid 14662)
	id A38E024204; Sun, 23 Aug 2009 00:42:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126843>

Hi Duy:

On Sat, Aug 22, 2009 at 11:20:39PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Sat, Aug 22, 2009 at 10:05 PM, Daniel
> Convissor<danielc@analysisandsolutions.com> wrote:
> > Hi Duy:
> >
> > On Sat, Aug 22, 2009 at 11:10:18AM +0700, Nguyen Thai Ngoc Duy wrote:
> >>
> >> I guess it tried to find .git directory upward. I think you can set
> >> GIT_CEILING_DIRECTORIES to make it stop at /home/danielc. Excerpt from
> >> git.txt
> >
> > That didn't change the situation.
> 
> I'd suggest you to degrade Git to a version earlier than 1.6.1, when
> the error was not added. :-D

:)  Might be easier to use "svn ci" instead. :)


> But did it at least change the error message? Here is what I got when
> "chmod 000 /tmp/a":

No.  It produced the same exact error message:
    fatal: Cannot change to /home/danielc/..: Permission denied

Thanks,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
 4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335 f: 718-854-0409
