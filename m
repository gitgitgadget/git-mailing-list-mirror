From: Kevin Sheedy <kevinsheedy@gmail.com>
Subject: Git unpack-objects on Windows
Date: Thu, 13 Jan 2011 03:07:55 -0800 (PST)
Message-ID: <1294916875939-5917819.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 13 12:08:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdL2B-00087h-7c
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 12:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732Ab1AMLH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 06:07:58 -0500
Received: from sam.nabble.com ([216.139.236.26]:52199 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932488Ab1AMLH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 06:07:57 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <kevinsheedy@gmail.com>)
	id 1PdL23-0000Mp-Uf
	for git@vger.kernel.org; Thu, 13 Jan 2011 03:07:55 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165047>


I'm trying to import a cvs repository into git using cvs2git. After running
cvs2git, I'm left with a git pack file. I'm now trying to unpack this file
using:

git unpack-objects < myfile.pack

Or to be more exact:

$ git unpack-objects <
"C:/dev/cvsToGitWorkingRepository/.git/objects/pack/pack-479ea920f4a7389f8a52eb6062.pack"
Unpacking objects: 100% (66409/66409), done.

It looks like it worked except I'm not getting any unpacked files.

Has anybody gotten git unpack-objects to work on a Windows system?
-- 
View this message in context: http://git.661346.n2.nabble.com/Git-unpack-objects-on-Windows-tp5917819p5917819.html
Sent from the git mailing list archive at Nabble.com.
