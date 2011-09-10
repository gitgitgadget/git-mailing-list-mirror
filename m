From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: RFD: leveraging GitHub's asciidoc rendering for our Documentation/
Date: Sat, 10 Sep 2011 05:02:44 +0200
Message-ID: <j4ek0n$fsi$1@dough.gmane.org>
References: <4E6A23DB.1040606@drmicha.warpmail.net> <CAP2yMaJ+UBHZp0U=QWOZbnbbOuq8vNoJODWtxZPb1sKXTC_UEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 05:03:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2Dqj-00030J-JI
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 05:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758496Ab1IJDDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 23:03:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:53569 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758481Ab1IJDDG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 23:03:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R2DqR-0002u9-IF
	for git@vger.kernel.org; Sat, 10 Sep 2011 05:03:03 +0200
Received: from 151.54.153.148 ([151.54.153.148])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Sep 2011 05:03:03 +0200
Received: from giuseppe.bilotta by 151.54.153.148 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Sep 2011 05:03:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 151.54.153.148
User-Agent: KNode/4.4.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181135>

Scott Chacon wrote:

> Hey,
> 
> On Fri, Sep 9, 2011 at 7:34 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> which has all the renaming (*.txt -> *.asciidoc) and Makefile and script
>> changes, but is missing some include changes (because include breaks
>> anyway, see below).
> 
> I can change this so we can render .asc if that's less ugly.  I've
> been meaning to do this for a while, but I don't think I ever
> incorporated it.

Rather than forcing a rename on the repository, do you think it would be
possible to implement some form of gitattribute support in GitHub?
The user could then specify something like render=asciidoc (as opposed to,
say, render=markdown or render=rdoc or whatever else you support): a few
simple additions to .gitattributes and the user would be able to customize
the cooked file view without needing to use GitHub's expected extension.

-- 
Giuseppe Bilotta
