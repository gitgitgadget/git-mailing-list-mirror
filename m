From: sunny110 <mehran.sunny@hotmail.com>
Subject: [fatal error] cannot pread pack file: Input/output error
Date: Tue, 1 Apr 2014 04:22:04 -0700 (PDT)
Message-ID: <1396351324120-7607133.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 13:22:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUwm3-0006wl-9h
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 13:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbaDALWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 07:22:07 -0400
Received: from sam.nabble.com ([216.139.236.26]:35578 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbaDALWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 07:22:04 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <mehran.sunny@hotmail.com>)
	id 1WUwlY-0002hs-5L
	for git@vger.kernel.org; Tue, 01 Apr 2014 04:22:04 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245582>

Hi;
I hope this is the right place for my question.

I wanna build GoldenDict from source, however I get a fattal error when I
try to clone the repository.

Here is the recorded session:

    sunny@s9:~/Programs/goldendict$ git clone
git://github.com/goldendict/goldendict.git
    Cloning into 'goldendict'...
    remote: Reusing existing pack: 11370, done.
    remote: Counting objects: 7, done.
    remote: Compressing objects: 100% (7/7), done.
    remote: Total 11377 (delta 1), reused 0 (delta 0)
    Receiving objects: 100% (11377/11377), 27.17 MiB | 11 KiB/s, done.
    fatal: cannot pread pack file: Input/output error
    fatal: index-pack failed 

So what's the problem? could anyone help me? Thanks in advance.



--
View this message in context: http://git.661346.n2.nabble.com/fatal-error-cannot-pread-pack-file-Input-output-error-tp7607133.html
Sent from the git mailing list archive at Nabble.com.
