From: Romano Giannetti <romano@dea.icai.upcomillas.es>
Subject: Two newbie question: "dead" branches and merging after cherry-pick.
Date: Fri, 27 Jan 2006 18:36:19 +0100
Message-ID: <20060127173619.GA26199@pern.dea.icai.upcomillas.es>
Reply-To: Romano Giannetti <romano@dea.icai.upcomillas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
X-From: git-owner@vger.kernel.org Fri Jan 27 18:35:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2XVj-00080k-5c
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 18:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWA0Rfo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 12:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWA0Rfo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 12:35:44 -0500
Received: from mail1.upco.es ([130.206.70.227]:65429 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S1750823AbWA0Rfo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2006 12:35:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail1.upco.es (Postfix) with ESMTP id 903541131E5
	for <git@vger.kernel.org>; Fri, 27 Jan 2006 18:35:40 +0100 (CET)
Received: from mail1.upco.es ([127.0.0.1])
	by localhost (mail1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 25292-09 for <git@vger.kernel.org>;
	Fri, 27 Jan 2006 18:35:39 +0100 (CET)
Received: from pern.dea.icai.upcomillas.es (pern.dea.icai.upco.es [130.206.71.186])
	by mail1.upco.es (Postfix) with ESMTP id 7F3B51131C8
	for <git@vger.kernel.org>; Fri, 27 Jan 2006 18:35:39 +0100 (CET)
Received: by pern.dea.icai.upcomillas.es (Postfix, from userid 1153)
	id 54AF2102DB; Fri, 27 Jan 2006 18:36:19 +0100 (CET)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at upco.es
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15182>


Hi,

   this is a "really-newbie-question"...  git is the first SCM that I try to
   use, and I am really fascinated with it. I develop my software on three
   different PC and git solves all my problems of keeping uptodate with
   myself in a really nice way. 

   I have a couple of doubts that probably are at the very silly level but... 
   Here I go: 

        - I use to work on a topic branch to make test, try solutions for
        bugs, etc. Say I am done with the branch "test-bill-idea". I decide
        it's a dead branch, so that I do not want to see it in day-by-day
        work (git branch, basically), but I do not want to loose it. If I
        delete the branch I will loose all its commit at the next prune,
        correct? There is a way to maintain it as a dead or hidden branch,
        shown for example just by gitk --all? If I tag the tip of the
        branch, and then delete .git/refs/head/test-bill-idea, will the
        "dead branch commits" be preserved by next prune(s)? 

        - Easier: suppose I cheery-picked "abababab" from branch "testing"
        to master branch. What will happen if later I decide to merge
        all "testing" to master branch? I will have a merge conflict (trying
        to apply two times the same fix) or not? 

   Thank you very much for your time! Have a nice week end,

         Romano   

   
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/
