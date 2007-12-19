From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: git-svn and migration
Date: Wed, 19 Dec 2007 16:50:30 +0000
Message-ID: <320075ff0712190850r35263bcfv1d8f84e699208e15@mail.gmail.com>
References: <320075ff0712190849u2c40cc46pf01fa2a75f557482@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 17:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J528H-0002VO-Ov
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 17:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbXLSQud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 11:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbXLSQud
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 11:50:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:3612 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbXLSQuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 11:50:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so309543ugc.16
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 08:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c5jhDK1DN5OTAqZ/T3pqpn2F4fuwrtykD5t2ZMTN/Tw=;
        b=r2GQW6KfHeT3TJjxojUDrP/VLRPm3KaVsiJ++oipUE6CzeRCY8Q4CvBUtB2vXhG2gDoJH3BgUwjNtDzvMx+lgIthWgxX4PyCmYshqHCJseoyYhIE/BZ1tlDJwXhkXSVDm7oawiN0ALobbgjRqey4uZqxOEEy8wdakL4i2wur9TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cTW2XkC+s14R/+s3FAKehFuRUB0Pi5mkVzvgJOltGFGeHQ2itGjyHVIGgGtBGi2xcjn1Hw6ceDr2r7aSEUXiPFnB5PUZwla00fmG9yycmVNMigIWeCduOgXpACa5VGi+9STIh0kExhtl9LJl/hIkH8ZNujYOHpLe+AFCzROZ644=
Received: by 10.67.196.2 with SMTP id y2mr2344580ugp.60.1198083030445;
        Wed, 19 Dec 2007 08:50:30 -0800 (PST)
Received: by 10.66.243.3 with HTTP; Wed, 19 Dec 2007 08:50:30 -0800 (PST)
In-Reply-To: <320075ff0712190849u2c40cc46pf01fa2a75f557482@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68919>

Hi there!

I've been playing around with git for a while, read the guides to
git-svn and have been successfully using it on my own to track an
upstream svn repository.

Eventually, I'd like us all to switch to git, throw out the svn
server, and replace it with a git repository that can be pushed to,
where commits that pass tests get merged into the master.

But - that's not going to happen overnight. The most likely next steps
are going to be something like migrating a couple of other developers
onto git to test the water, but in the interim most people will still
be on svn.

Has anyone got any tips as I'm sure it's a path trodden before? I've
seen examples of keeping a read-only svn, but that's not really what
I'm after. I'm considering whether to have a central git repo
regularly pull from svn so that it's up to date, and having us
possibly push to svn (or git if it's not merged to trunk) as an
interim step..

Nigel
