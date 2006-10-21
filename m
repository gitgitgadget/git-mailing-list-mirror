From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 15:05:22 +0200
Organization: At home
Message-ID: <ehd5u7$c5g$1@sea.gmane.org>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com> <46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com> <45373E27.3050209@op5.se> <vpqwt6wsmb5.fsf@ecrins.imag.fr> <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com> <45379A02.1010105@utoronto.ca> <72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com> <45384B0F.4040901@utoronto.ca> <20061021123027.GB29843@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Sat Oct 21 15:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbGXZ-0004HP-9T
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 15:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992991AbWJUNF0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 09:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993007AbWJUNFZ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 09:05:25 -0400
Received: from main.gmane.org ([80.91.229.2]:63424 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S2992991AbWJUNFZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 09:05:25 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GbGXN-0004Fv-OC
	for git@vger.kernel.org; Sat, 21 Oct 2006 15:05:17 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 15:05:17 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 15:05:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29608>

Jan Hudec wrote:

> On Fri, Oct 20, 2006 at 12:05:35AM -0400, Aaron Bentley wrote:
>> Tim Webster wrote:
>> > Also svn does not allow files in the same directory to live in
>> > multiple repos
>> 
>> It would surprise me if many SCMs that support atomic commit also
>> support intermixing files from multiple repos in the same directory.
> 
> In fact I think svk would. You would have to switch them by setting
> an environment variable, but it's probably doable. That is because
> unlike other version control systems, it does not store the information
> about checkout in the checkout, but in the central directory and that
> can be set. I don't know git well enough to tell whether git could do
> the same by setting GIT_DIR.

You can very simply embed one "clothed" repository into another in GIT,
like shown below

  project/.git
  project/subdir/
  project/subdir/file
  project/subproject/
  project/subproject/.git
  project/subproject/file
  ...

It depends on circumstances if one wants files belonging to subdirectory
be ignored by top repository. You would want to ignore .git/ directory,
though.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
