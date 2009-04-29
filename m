From: John Bito <jwbito@gmail.com>
Subject: EGIT: problems using eclipse project below root of working tree
Date: Wed, 29 Apr 2009 11:28:22 -0700
Message-ID: <3ae83b000904291128j27ad6c1ah3422f091c956533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 20:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzEWH-0004LE-6p
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 20:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbZD2S2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 14:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbZD2S2Y
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 14:28:24 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:14449 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbZD2S2X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 14:28:23 -0400
Received: by yx-out-2324.google.com with SMTP id 3so774597yxj.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=DvGGns0C7GovJ6iNi4FAU+5aSpFxRXJbzHh/JGJGFV8=;
        b=VTfC0q6CO0YOGp7RMDFcI+tTJ65D8Ja3//azDrfReNf50SywdYBYPNb1OaIJ4gqB6+
         On47yxmlEgQyEO1UjfL3MO7xmRUyGs9xWsGm+tZ66Pxm6R8OsInQPaKjyVKtkysOKENs
         aZCZCe8KTIEkZhO62AHXibgAtLW663rLjFuW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=PGGX/yIOwdN8RvzV2DVPsf1XDUCTDjBe/cpjIfXcGdTgYITqjvpwb3RfU61t0DHcpi
         IQECIMktwxXIcKpvP/u8d+JNEr11ZV9WAiapYupk+gEo2JOyIAGL7vBjewubheDpbWMy
         vEvsQieqP4OHugZJHmPpZUCgGA/wzGogwGp5w=
Received: by 10.100.10.15 with SMTP id 15mr1292869anj.8.1241029702332; Wed, 29 
	Apr 2009 11:28:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117909>

My Java project is part of a larger repository, so the Eclipse project
I'm opening is rooted one level below the directory containing .git/.

When I open only the subproject (the root project shows as closed in
the project explorer), all the members of the working directory of the
subproject show in the Project Explorer as if they were untracked
files (query icon).  If I open the subproject after opening the root
project, the members correctly appear as committed (can icon).
Opening the root project after opening the subproject seems to produce
an error in references to jars in the subproject - not obviously
related to EGIT.

If the root project is open, changes made in the subproject are listed
twice in the Commit dialog (once prefixed by root-project-name: and
once prefixed by subproject-name:).  If the root project is closed,
the Commit dialog lists the changes once (prefixed by
subproject-name).

I think the commit dialog gives me the correct status, but I'd have
more confidence if the icons in the Project Explorer were consistent.
I don't want to work with the root project open because it's MUCH
bigger than the Java code I'm working on and Eclipse seems faster with
only the subproject open.  I'm also concerned that if I let it commit
with both the root and subproject instances of the changes checked,
I'll cause a problem that'll take some time to unwind (not interested
in experimenting with that at the moment).

Should I add this as a bug?
