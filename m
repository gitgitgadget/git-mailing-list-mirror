From: Zabre <427@free.fr>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 04:00:45 -0800 (PST)
Message-ID: <1233144045221-2231849.post@n2.nabble.com>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se> <1233140751523-2231622.post@n2.nabble.com> <49804385.908@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 13:03:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS97m-0008Rk-B5
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 13:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbZA1MAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 07:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbZA1MAq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 07:00:46 -0500
Received: from kuber.nabble.com ([216.139.236.158]:38216 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbZA1MAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 07:00:46 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LS965-00023H-7G
	for git@vger.kernel.org; Wed, 28 Jan 2009 04:00:45 -0800
In-Reply-To: <49804385.908@dbservice.com>
X-Nabble-From: 427@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107529>



Tomas Carnecky wrote:
> 
> Do you mean 'undelete' a file? git checkout d.txt - That restores the 
> file in the working tree and resets the index just for that file.
> 

Hi Tom,
(thank you for your interest in my newbie problems)

yes that's what I mean : 'undelete' a file, after a "git rm d.txt".
But I did not manage to apply your solution succesfully :
$ git rm d.txt
$ ls
a.txt b.txt c.txt
$ git status
# On branch new
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	deleted:    d.txt
#
$ git checkout d.txt
error: pathspec 'mamma.txt' did not match any file(s) known to git.
Did you forget to 'git add'?

So it did not work but I've just noticed that unstage tip given by the
status command, and I did the following (which worked)

$ git reset HEAD d.txt
d.txt: needs update
$ ls
a.txt b.txt c.txt
$ git checkout d.txt
$ ls
a.txt b.txt c.txt d.txt

Reading the git reset help file gives me the feeling I should use this with
caution... It looks like you can somehow modify the change history.
Anyway these two commands helped me change the index the way I wanted.
Please tell me if this might somehow go wrong in another situation.
-- 
View this message in context: http://n2.nabble.com/%28beginner%29-git-rm-tp2231416p2231849.html
Sent from the git mailing list archive at Nabble.com.
