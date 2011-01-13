From: Harry Johnson <hjohnson@viasic.com>
Subject: noob question
Date: Thu, 13 Jan 2011 18:58:13 -0500
Message-ID: <AANLkTinU---Bw5nWFXr7psSyZEty=awihPrDGqNX916O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 14 00:58:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdX3e-0002tH-08
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 00:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756629Ab1AMX6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 18:58:16 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42409 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984Ab1AMX6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 18:58:15 -0500
Received: by wwa36 with SMTP id 36so2425122wwa.1
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 15:58:14 -0800 (PST)
Received: by 10.216.17.3 with SMTP id i3mr1103486wei.80.1294963093885; Thu, 13
 Jan 2011 15:58:13 -0800 (PST)
Received: by 10.216.243.129 with HTTP; Thu, 13 Jan 2011 15:58:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165070>

I am completely new to git and have only read the tutorial as well as
some git for subversion users documentation. Our company is
considering switching from subversion to git and I have been doing
some experimenting and have run across a potential problem. Our
systems are kubuntu/linux.

I have used git-svn to create a git repo from our subversion repo. I
have done this as user foo which is just an account that is used for
doing central builds. I have then cloned this as repo as myself,
harry. My thought is that the repo owned by foo would be a central
repo that all of the developers, including myself, could clone and to
which  we could then 'git push' our changes. The nightly builds would
then simply build whatever was currently in the foo repo. This of
course completely ignores the complexity of branches at this point but
like I said, I am experimenting. I did a test of this and what I found
when checking the git log is that while the changes I made and checked
into my repo clearly showed me as the author, the same changes after
being pushed to foo's repo showed a different author.

So two things.. First should the author have been preserved? How can I
make sure that it is?

Second, and probably the better question. Am I too focused on the
subversion methodology? Is there a better way of managing a central
build scheme using git?

Thanks!
-Harry
