From: Manuel Corpas <mc@manuelcorpas.com>
Subject: Checksum mismatch problem
Date: Wed, 14 Apr 2010 14:31:16 +0100
Message-ID: <g2y67740bda1004140631h292e222dmefa68b91051d59cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 15:31:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O22h5-0005go-5V
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 15:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab0DNNbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 09:31:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36049 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab0DNNbo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 09:31:44 -0400
Received: by gwaa18 with SMTP id a18so55707gwa.19
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 06:31:43 -0700 (PDT)
Received: by 10.100.254.4 with HTTP; Wed, 14 Apr 2010 06:31:16 -0700 (PDT)
X-Google-Sender-Auth: 0d7f1429fc765045
Received: by 10.101.101.2 with SMTP id d2mr12506049anm.240.1271251897170; Wed, 
	14 Apr 2010 06:31:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144871>

Hi there

has anyone come across this problem? Any ideas?

$ git svn rebase
Checksum mismatch:
branches/prerelease_4.2/data/templates/custom_print_read_ajax.tt2
87713960a22f08430930baa8826fbc5e17abc722
expected: 3d4d50882e2ca57f22518201a2cf26f2
    got: 7985ae0b3e37d915347cfb1a82d4d48c

I've tried to delete .git/svn/ to no avail.
I have even created a fresh check out following the instructions on
the git book on git svn.

http://progit.org/book/ch8-1.html

git svn clone file:///tmp/test-svn -T trunk -b branches -t tags

Still couldn't fix the problem :-\

M


Manuel Corpas, PhD
The Wellcome Trust Sanger Institute
Wellcome Trust Genome Campus
Hinxton, Cambridge CB10 1HH (UK)

Tel:    +44.122349.2372
Web: http://manuelcorpas.com/about/
