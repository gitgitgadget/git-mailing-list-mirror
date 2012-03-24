From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFH] SoC 2012 Guidelines
Date: Sat, 24 Mar 2012 17:11:29 +0100
Message-ID: <201203241711.30270.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 17:11:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBTZ6-0001Lh-CU
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 17:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684Ab2CXQLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Mar 2012 12:11:35 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40666 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809Ab2CXQLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2012 12:11:34 -0400
Received: by wibhj6 with SMTP id hj6so2967991wib.1
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        bh=lhK96hAMHh4rEx4wFoESBoF+ktC4HzmeolhSLaYistI=;
        b=uDtSWBwB/beV8/WBQJx9EWk8y+AAKWfhh1ic9nyhDPFJoZAgn/qYAARP8JV5+za9e3
         9OkTichPVayudu5PuLqQ+1Q/Jf7BTY3JvTodpPQ/fX+OrFLP/XIHZfFJvX4OBbkwxHiV
         151bkUl8ROvmwzQc6w0eY36apdc3YJt8HqVVcmRzNyZUI2gEcBXWEOuyfGi3rnXuzBOG
         cYyEap2d+85q+SldJPM8PmteYrolLvZ4SKj78ROd0+GJv9HO4JCmlGrLd/cqEWDFJihC
         e+mqhac96/+hTOHvG5NJCxbgmt1pDJkYrzjOnN5/cQ6NyG9IYl49EoDJBHK1Z82JugrX
         3MnQ==
Received: by 10.180.88.169 with SMTP id bh9mr5850725wib.5.1332605492915;
        Sat, 24 Mar 2012 09:11:32 -0700 (PDT)
Received: from [192.168.1.13] (epw177.neoplus.adsl.tpnet.pl. [83.20.64.177])
        by mx.google.com with ESMTPS id ex2sm39407066wib.8.2012.03.24.09.11.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Mar 2012 09:11:32 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193830>

First, I'd like to thank Jeff King for creating and hosting GSoC wiki 
pages for Git.  Without his initiative, and even more his volunteering 
to be GSoC Git organizator we (as the Git Development Community) 
wouldn't be in Google Summer of Code 2012.

The https://github.com/peff/git/wiki/ includes the following pages:

* "SoC 2012 Application", which should probably be renamed to
  "SoC 2012 Organization Application"; it was here to help (crowd)craft
  organization application.

* "SoC 2012 Template", which perhaps should be better named
  "SoC 2012 Student Application Template"; it is here for prospective
  (would-be) student to help craft better project application.

* "SoC 2012 Ideas", to gather ideas for GSoC project from Git developers
  and others, as _example_ ideas for students applications.

  We really should have more ideas, as it looks like students would be
  battling for a few projects (I think there are two would-be students 
  for any proposed project).  Well, too late now.

I'd really like to see blue-sky proposals not mentioned on ideas list,
or at least greatly expanded on proposed ideas.

When students proposals would get accepted at April 23, there would
be created "SoC 2012 Projects", listing accepted projects and hopefully
tracking their status.  I guess we would try to list git-related GSoC
projects from other organizations, like in previous years.


What is lacking (for me) is something like "SoC 2012 Guidelines" wiki
page, which would gather guidelines and suggestions both for mentors
and for students.  

One can find some information buried in GSoC FAQ:
 
http://www.google-melange.com/gsoc/document/show/gsoc_program/google/gsoc2012/faqs

It would be nice however to have it extracted and make easier to find.

This page could also serve to gather organization-specific requirements,
for example:

* That the discussion of GSoC project application ideas with mentoring
  organization (i.e. with us) should take place in the open, here on git
  mailing list, git@vger.kernel.org.

* That each student should examine relevant parts of existing git code,
  read SubmittingPatches and Coding Guidelines, and at least lurk (read)
  on git mailing list during the Community Bonding Period (e.g. via
  GMane; I don't think we should require subscribing to git mailing
  list).

* That for each project there should be created a public git repository
  on one of git hosting sites like repo.or.cz, Gitorious or GitHub.

* How often students (and/or mentors) should send updates about status
  of a project (once per week perhaps?), and what should those  
  announcements include.


And to gather help:

* There should be some information about what parts of discussion and
  work should take place in private communication between student and
  mentor, and how much should it take place in public, on git mailing
  list.

* How can and how should mentors help students.

* How to make use of comments on patches (or design ideas), while not
  getting bogged down in "bikeshed"-ding :-)

* Perhaps also some advice from successfull students to students,
  and from mentors to mentors.


[I was neither GSoC student, or GSoC mentor.]

-- 
Jakub Narebski
Poland
