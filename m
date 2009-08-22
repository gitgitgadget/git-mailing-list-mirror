From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: hitting home directory's parent
Date: Sat, 22 Aug 2009 11:05:43 -0400
Message-ID: <20090822150542.GA29507@panix.com>
References: <20090821200503.GA19660@panix.com> <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 22 17:05:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MesAA-0002Xb-GG
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 17:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbZHVPFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755329AbZHVPFl
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 11:05:41 -0400
Received: from mail1.panix.com ([166.84.1.72]:60577 "EHLO mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990AbZHVPFl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 11:05:41 -0400
Received: from panix5.panix.com (panix5.panix.com [166.84.1.5])
	by mail1.panix.com (Postfix) with ESMTP id 1A6611F082
	for <git@vger.kernel.org>; Sat, 22 Aug 2009 11:05:43 -0400 (EDT)
Received: by panix5.panix.com (Postfix, from userid 14662)
	id 5F91224202; Sat, 22 Aug 2009 11:05:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126812>

Hi Duy:

On Sat, Aug 22, 2009 at 11:10:18AM +0700, Nguyen Thai Ngoc Duy wrote:
> 
> I guess it tried to find .git directory upward. I think you can set
> GIT_CEILING_DIRECTORIES to make it stop at /home/danielc. Excerpt from
> git.txt

That didn't change the situation.

I did read a bit farther in the manual and initialized a new repository.  
Issuing "git --help" once inside that new repository works.  Requiring 
the --help command to be called from inside a repository, or even that 
it's looking for a repository at all, seems unwise.  All it should do is 
display the usage information and exit.

Thanks,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
 4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335 f: 718-854-0409
