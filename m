From: "Marvin Fraeman" <marvin.fraeman@gmail.com>
Subject: How do I control the automated commit message on a merge?
Date: Tue, 3 Jun 2008 14:55:10 -0700
Message-ID: <bd2cb52a0806031455r151303achf0424b5320bf2f07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:56:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3eUB-000858-LW
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 23:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbYFCVzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 17:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbYFCVzN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 17:55:13 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:51936 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbYFCVzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 17:55:11 -0400
Received: by gv-out-0910.google.com with SMTP id e6so328341gvc.37
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 14:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=uyhQ3R50+3r7OjnHCMRbx3M77a9odZsBe0hl+EJ6zZQ=;
        b=V/vQB0Rbs75wTHU36/+EuCNr7MFo0++eqOXmQ+HN8spTfTrGfUGuBGayVPuqIFE1oN5C/tAcUMPkk6759agsoqmRBVnjmlXIMb52J/taOIRn8djPjo+e/S7YSZ0wVe5wynB6YR0gu6X/A8KahlTfCms5BkSurgU71tgD+CCPzRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=w8wzdb62gQ1cXNm1GRwRTqczqHS7W0PVYi0HOCv9Nz9XjUYs7JInmQHl9MyNsKWPnM77HDKT4DN1gabR9soQx7zj+W3s+pzXKkPtHdFc+R2TO0BzAyC0bPdV7uBgLMZHsaObSzDKeXUN9tEOHVatU8aezPoLWYoTQntIztPLAH4=
Received: by 10.103.202.18 with SMTP id e18mr6668392muq.59.1212530110308;
        Tue, 03 Jun 2008 14:55:10 -0700 (PDT)
Received: by 10.103.214.18 with HTTP; Tue, 3 Jun 2008 14:55:10 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83716>

I am using git-svn. The SVN repository I'm dealing with has a standard
comment convention I must follow. It is a simple static string of
information that must appear on the first line of the commit message.
Everything else can be free-form.

I figured out how to add a commit template to my gitconfig file. So
for regular commits, I think I'm fine. But when Git does a merge (no
conflicts), it auto-generates a commit message like:

        Merge branch 'master' of  /path/to/other/repo

How can I change this so my required string gets written at the
beginning of the commit message. I played with the commit-msg and
prepare-commit-msg hooks, but it didn't seem to get triggered in the
merge case.

Also, having the prepare-commit-msg hook add text had the side-effect
that in my normal commits, the message was always accepted, even when
I wanted to abort (vi using :q!). In case I ever do need to use
prepare-commit-msg, is there a way I can use it where abort still can
work?


Thank you
