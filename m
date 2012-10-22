From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: diff support for the Eiffel language?
Date: Mon, 22 Oct 2012 13:58:00 +0200
Message-ID: <508550E8020000A10000CF36@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 14:05:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQGlI-0000ll-0y
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 14:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab2JVMF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 08:05:28 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:59931 "EHLO
	rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab2JVMF2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2012 08:05:28 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2012 08:05:28 EDT
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id EC1E39E67
	for <git@vger.kernel.org>; Mon, 22 Oct 2012 13:58:04 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id D658E9E52
	for <git@vger.kernel.org>; Mon, 22 Oct 2012 13:58:03 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Mon, 22 Oct 2012 13:57:23 +0200
X-Mailer: Novell GroupWise Internet Agent 12.0.1 
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208179>

Hi!

After a longer pause, I did some programming in Eiffel again, and while doing so, why not use Git? It works!

However there's one little thing I noticed with "git diff":
The conte4xt lines (staring with "@@") show the current function (in Perl and C), but they show the current "feature clause" in Eiffel (as opposed to the expected current feature). I wonder how hard it is to fix it (Observed in git 1.7.7 of openSUSE 12.1).

For the non-Eiffelists:

Eiffel has a class structure like this:
class FOO

feature {BAR} -- This is a "feature clause", grouping related features (attributes/routines)

   baz (x,y : INTEGER) : STRING is
      -- blabla...
      do
         ...
      end -- baz

end -- class FOO

---
Now if I change something inside "baz", it would be nice if the @@-contect line would show "baz" (or more) instead of "feature {BAR}...".

Regards,
Ulrich
P.S. Apologies if the feature requested had been added already.
