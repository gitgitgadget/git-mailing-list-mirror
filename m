From: Brandon <siamesedream01@gmail.com>
Subject: From Perforce to Git
Date: Sat, 25 Oct 2008 17:18:27 -0400
Message-ID: <82c87da00810251418y4a6ef1fbgccefb12061535226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 25 23:19:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtqXu-0006eq-JE
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 23:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbYJYVS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 17:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbYJYVS2
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 17:18:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:38850 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbYJYVS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 17:18:28 -0400
Received: by rv-out-0506.google.com with SMTP id g9so2504980rvb.5
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=W5nTBpacNSfJKJZqGwmc/8ybDu1KXSDOWyBOChwVKI8=;
        b=i6QS14YGcMGv5ysjWKI60tfvQvWWFYwdeZnfrxSHW9ymJJ6t8a0sjsEg4ifByPefhl
         IgEVGorQ0qdDBpPUquY4cmuk0vkTxd0oxYVXORhW6r1rJotivysAAhrJ8OFHpPqrXaYX
         T0z/OpbwDcUt7CWWssz50PA7tjfwmuT5ORlRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RAbgtLt3i3EJgj9Sn7Ucofat8WdXR4Sa+nL3ia9n8tsD5KuuPctp7B386zC+Uk+E7f
         1jNV0DPBio5b6T5SZnkgHVIUjt8QJExKluuiyIpy9KC4aa/ipm8HptMwfxz40BmAnwIt
         usLFZJLCESu2zopo73Ea4cRrfdiYBYiks21/g=
Received: by 10.141.76.1 with SMTP id d1mr2133932rvl.269.1224969507267;
        Sat, 25 Oct 2008 14:18:27 -0700 (PDT)
Received: by 10.141.79.18 with HTTP; Sat, 25 Oct 2008 14:18:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99130>

   I'm trying to make a comprehensive comparison of Perforce and Git
features. There are two things I currently can't find:

1) "Who's editing what"
    It's been documented that git can help developers communicate who
is editing what at any given time like perforce. (assuming there is a
central repositry) Has anyone seen an example of scripts to do this?
    References:
http://www-cs-students.stanford.edu/~blynn/gitmagic/ch07.html  (Who's
editing what)
  "To view "pending" changes a la P4 C<git cherry> or C<git log> can be used on
  someone else's branch, but their changes must be published."
     - http://www.nntp.perl.org/group/perl.perl5.porters/2008/09/msg139661.html

2) Symlinks to checkout partial repository
   I believe I read symlinks could be used to checkout part of a
repository. Is this true? any references? I imagine submodules is the
preferred way of doing this, and "narrow" or "partial" or "sparse"
checkouts are under development
(http://kerneltrap.org/mailarchive/git/2008/9/14/3292714), but I'm
still interested in learning this solution.

any direction would be appreciated,
-brandon
