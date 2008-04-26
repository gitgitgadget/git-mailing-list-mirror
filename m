From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Welcome to Git's GSoC 2008!
Date: Sat, 26 Apr 2008 20:28:08 +0200
Message-ID: <200804262028.09746.jnareb@gmail.com>
References: <20080422013201.GA4828@spearce.org> <m3d4odq3w1.fsf@localhost.localdomain> <20080426172945.GD29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 20:29:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpp8z-0002Ba-1s
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 20:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbYDZS2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 14:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756161AbYDZS2R
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 14:28:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:58731 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbYDZS2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 14:28:16 -0400
Received: by ug-out-1314.google.com with SMTP id z38so359489ugc.16
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=V+oVLAlmpwdqhHtHskeYjOkbwPQggReIREJKjpSqvzw=;
        b=Hvl87rW1sZmOhNaY8x5aT5CFjk8ZZnt5ZtUEl3YPXQFN8slMs5wPC3H3BY5PHDmNRznagtMC3Eh6kXVhE8rPYAGlEYVROXcrqcD6W1txr417Z97SJLnO4mypwso2ptqeF7/lJ4mi8/IlDm8I17XJmH4/9gAOzQ0bgbMF28lyQ+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=s8wUu3SbDJIDNB7CaoiTsVe8LSydhMsYbKPJSsVKi1lm+C/Aq99HWeujTkZFh3nSrRoXEhrhRF8D1NKstUEYClKThJycibCiv2XYoutHd1YSyL524cqLrrJn4/Qo9eCgHBOdzVbvH8y864udpUYLVzjQmkLyMdxKqX8hIGeUYHY=
Received: by 10.67.195.14 with SMTP id x14mr2125634ugp.40.1209234490514;
        Sat, 26 Apr 2008 11:28:10 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.201.50])
        by mx.google.com with ESMTPS id t2sm5182106gve.3.2008.04.26.11.28.04
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Apr 2008 11:28:06 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080426172945.GD29771@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80384>

On Sat, 26 Apr 2008, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> I have found three another Git-related Google Summer of Code 2008
>> projects by other organizations:

By the way, it is a bit strange that Google Summer of Code 2008 pages 
are not fully indexed.  Currently searching for "git soc 2008" from 
"Search Google Code:" search form finds only organization info for Git 
Community, "Git plugin for Anjuta IDE" project, SoC2008Template 
(Note, this template is blatantly plagiarized from Git's SoC 
template ;-), and netconf project for Debian which uses Git repository 
but is not about git in any way; none of other were found.
 
>>     Git plugin for Anjuta IDE  (GNOME)
> 
> This project was new to me; prior to your message I did not know
> about it.  Thanks.

Have they contacted Git Community (IRC channel, mailing list, individual 
developers) for help, or did you contacted them, as with "KDevelop DVCS 
support"?

>>     KDevelop DVCS support      (KDE)

With these two projects, and egit/jgit for Eclipse, and also planned Git 
support in NetBeans IDE, there would be Git support in I think most 
used IDEs... What's left is something akin to AnkhSVN, i.e. support for 
Git in Visual Studio; perhaps Git# projects would help with it...
 
> I contacted this student/mentor pair and offered them our mailing
> list address if they have questions.  Apparently the project is
> trying to create some common DVCS abstractions but wants to use
> Git as the first supported tool.

I think it is a very good idea, because in my (certainly biased) opinion 
Git has best design and best model of DVCS.  It also has many 
interesting features: working with multiple branches in single 
repository, bisect to find where bug was introduced, blame/annotate 
working across code movement and possibly ignoring whitespace changes 
(although I guess that it would be nice to have interface to pickaxe 
search instead/in addition).

I wonder how much will be done; I guess it can borrow at least a bit 
from QGit (history viewer) and KGit (commit tool).
 
>>     Git# implementation        (Mono Project)
>
> There is some concern from people who are close to the summer of code
> program that two students working on the same project this summer may
> result in one's success being dependent upon the other's success.
> This sort of dependency is not permitted under the Summer of Code
> rules, as it can be quite unfair to an otherwise successful student.

I was wondering how this have passed GSoC projects screening...

> It will be interesting to see how everyone's project turns out at
> the end of the summer.

-- 
Jakub Narebski
Poland
