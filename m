From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GSoC intro
Date: Mon, 19 Mar 2012 21:31:34 +0000
Message-ID: <4F67A5B6.7090508@pileofstuff.org>
References: <11292500.AVmZFUUvNi@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 22:31:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9kB6-0005Uz-DB
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 22:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab2CSVbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 17:31:39 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:59537 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753631Ab2CSVbi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 17:31:38 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120319213136.QDU21084.mtaout03-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Mon, 19 Mar 2012 21:31:36 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120319213136.HERV5924.aamtaout02-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 19 Mar 2012 21:31:36 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <11292500.AVmZFUUvNi@flobuntu>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8 a=Bglz_tkCSw_yKlQMGfgA:9 a=30LdRSyxERXcoXktzR4A:7 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193462>

Hi Florian,

I've become interested in Git<->SVN issues lately, so I'll tell you what
I know.  Hopefully more knowledgeable people will correct me if I'm wrong.

The main thrust of SVN development is done in the "svn-fe" project.  You
can see the work so far in the "vcs-svn"[1] and "contrib/svn-fe"[2]
subdirectories of the main git repo.  My experience as a user has been
that it does a great job of the things it does, but so far it only does
a subset of the things I want.  For example, it can't write to SVN and I
think I'm right in saying it can't yet update from SVN after the initial
download.  David Barr is the main contact for svn-fe - he's an
experienced mentor and will be able to tell you all about the juicy
low-hanging fruit.

One limitation of svn-fe is that it downloads the whole SVN repository
into a single git branch, without separating out trunk, branches and
tags.  I've been working on this problem over the past few months, and
have split it into three parts (a language to describe which directories
are branches etc., export from SVN to that language, and import from
that language to git).  I'd be very flattered if you wanted to work on
this, but I couldn't honestly recommend it over svn-fe.  The language
itself is a one man job that doesn't have much creative work left; SVN
export is all about exposing yourself to weird little abuses of version
control that don't teach you much beyond bad habits; and while git
import would be a fun little project, I don't know enough about git's C
implementation to provide any useful mentoring.

Good luck with the summer, and as an svn-fe user I hope you're very
productive :)

	- Andrew

[1] https://github.com/git/git/tree/master/vcs-svn
[2] https://github.com/git/git/tree/master/contrib/svn-fe
