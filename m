From: Nicholas LaRoche <nlaroche@vt.edu>
Subject: Can `git config` override entries in .gitconfig?
Date: Tue, 23 Dec 2008 07:05:46 -0500
Message-ID: <4950D41A.5050009@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 13:07:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF62Z-0007D9-Fo
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 13:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbYLWMFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 07:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbYLWMFu
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 07:05:50 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:47666 "EHLO
	lennier.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbYLWMFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 07:05:49 -0500
Received: from dagger.cc.vt.edu (IDENT:mirapoint@dagger.cc.vt.edu [198.82.163.114])
	by lennier.cc.vt.edu (8.12.11.20060308/8.12.11) with ESMTP id mBNC5mU5001286
	for <git@vger.kernel.org>; Tue, 23 Dec 2008 07:05:48 -0500
Received: from auth.smtp.vt.edu (EHLO authsmtp2.cc.vt.edu) ([198.82.161.56])
	by dagger.cc.vt.edu (MOS 3.10.2-GA FastPath queued)
	with ESMTP id KUM66237;
	Tue, 23 Dec 2008 07:06:03 -0500 (EST)
Received: from [192.168.93.171] (pool-72-73-46-16.clppva.east.verizon.net [72.73.46.16])
	(authenticated bits=0)
	by authsmtp2.cc.vt.edu (8.13.1/8.13.1) with ESMTP id mBNC5lf8023772
	for <git@vger.kernel.org>; Tue, 23 Dec 2008 07:05:48 -0500
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
X-Mirapoint-Received-SPF: 198.82.161.56 authsmtp2.cc.vt.edu nlaroche@vt.edu 2 pass
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103812>

Is there a direct way to change the user.email entry for a git 
repository for one user (applied to all previous commits)?

I tried `git config --unset user.email` followed by `git config 
user.email email2` but it just sets a second field called user.email 
that shows up in `git config -l` as a duplicate. My ~/.gitconfig file 
contains email1 for the user.email entry.

Also, when the repository is created can I specify a second set of 
contact information (i.e. using a project specific email) which isn't a 
part of ~/.gitconfig?

output of `git config -l`:
user.email=email1
..
..
user.email=email2

Regards,
Nick
