From: Khawaja Shams <kshams@usc.edu>
Subject: Re: Multiple clients accessing git over NFS
Date: Sun, 14 Nov 2010 15:42:29 -0800
Message-ID: <AANLkTim1bUbofDzC5HJnB--0WkT45ewbWCa25RebEgae@mail.gmail.com>
References: <AANLkTimyFkVFAw4s2fiWKZFPvnx15K6U6GbxmRgznx7Z@mail.gmail.com>
	<rmi39r3mrf6.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 00:42:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHmDh-0007RB-0l
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 00:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240Ab0KNXmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 18:42:31 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63493 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab0KNXmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 18:42:31 -0500
Received: by fxm6 with SMTP id 6so1366484fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 15:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=9QvmrI9bYxJS1LI3DQC7+i3BmgMKfmdR2ASHTLRuXtI=;
        b=VVw15sqNo6yamGs8OqHYVNuoouOfgITjYnLla8W9I3atzWM6HtpX7GAk0v0P5jX4nv
         XSVJu7ZAlIHRuB8bAJHPU9IvEaAt9n0g66QXYdZHvImnoWhXL3Nk2VDKu+wQHbDd76gi
         nFYBOZRBF3CoDgA9rvtp4Hu37C5L0QutD5Pr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        b=njwWs9Rc18dSWiaNPOafE96651kjzstMXU17387A14mX8UNqTQC0gxICqfJKITo734
         JEZ65lwtwjdKlwlESpJWS+W3UmCdHMmWYQ/LhxKy6vABS25i3gG6wi3BCXNWepSK4zGF
         g8wcA7QJIjPXNJjcb2/AywRIjcQXn544KmlLk=
Received: by 10.223.79.4 with SMTP id n4mr4085497fak.69.1289778149984; Sun, 14
 Nov 2010 15:42:29 -0800 (PST)
Received: by 10.223.86.205 with HTTP; Sun, 14 Nov 2010 15:42:29 -0800 (PST)
In-Reply-To: <rmi39r3mrf6.fsf@fnord.ir.bbn.com>
X-Google-Sender-Auth: GWMndfn4BsXBW7tT1o7xxp6xLkU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161460>

Hi Greg,
   Thank you for the insightful response. We have multiple automated
clients pushing and pulling changes from git as events occur. We have
not hit any real performance issues just yet. Our main goal is to
improve the availability of the repository in case the box running the
apache server has an outage during a mission critical period. Any
other ideas on how to accomplish this? From your remarks, it sounds
like putting the git repository on NFS, even with a single client, can
be problematic due to the locking issues. Is that what you meant?

   I am still interested in knowing if git can handle multiple
simultaneous pushes on the same repository without encountering
corruption issues. Thank you.
