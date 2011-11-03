From: Reuben Thomas <rrt@sc3d.org>
Subject: git svn dcommit COMMIT silently checks in everything if COMMIT is not
 a complete revision
Date: Thu, 3 Nov 2011 15:12:04 +0000
Message-ID: <CAOnWdoj1eUipRd8M=jsAPdDTNcgEbT7adWR78iU5Oac9DvODkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 16:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLzN3-0006WK-IO
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 16:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933602Ab1KCPiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 11:38:21 -0400
Received: from exprod7og123.obsmtp.com ([64.18.2.24]:33702 "HELO
	exprod7og123.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932244Ab1KCPiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 11:38:20 -0400
X-Greylist: delayed 1575 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Nov 2011 11:38:20 EDT
Received: from mail-bw0-f51.google.com ([209.85.214.51]) (using TLSv1) by exprod7ob123.postini.com ([64.18.6.12]) with SMTP;
	Thu, 03 Nov 2011 08:38:20 PDT
Received: by mail-bw0-f51.google.com with SMTP id 17so1245159bke.10
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 08:38:19 -0700 (PDT)
Received: by 10.216.136.165 with SMTP id w37mr7891303wei.63.1320333124207;
 Thu, 03 Nov 2011 08:12:04 -0700 (PDT)
Received: by 10.180.107.198 with HTTP; Thu, 3 Nov 2011 08:12:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184722>

If I run

git svn dcommit COMMIT

with COMMIT being an unambiguous, but partial revision string, it
behaves like git svn dcommit, i.e. commits everything. (If I remember
to copy and paste the whole nine yards of the revision string, it
works as expected, i.e. commits just that revision.)

I'd expect it to work like other git commands, and understand partial
revision strings, or at least bail out saying it was an invalid
revision.

-- 
http://rrt.sc3d.org
