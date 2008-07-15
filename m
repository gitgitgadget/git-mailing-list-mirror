From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: applying and committing patches in a single git command
Date: Tue, 15 Jul 2008 11:50:24 +0300
Message-ID: <ce513bcc0807150150l783e9ff1kd7780dc59f4b5a3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 10:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIgFt-0006Af-W0
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 10:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbYGOIu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 04:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbYGOIu0
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 04:50:26 -0400
Received: from po-out-1718.google.com ([72.14.252.154]:20976 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbYGOIuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 04:50:25 -0400
Received: by po-out-1718.google.com with SMTP id c31so5632707poi.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=YSFRiP7TpTbvSC4WXCWa7dSOJ8XFhZ9h1DsMSdmbniU=;
        b=jqzNTXjymbq7x8Id4YhKLl5vlZ2ifUvHPSrb1hXR8r9Gg1sm34FzNK7YbkqSpyAbQ2
         qnRjLf2DBnlwjLZNx4VuoFWD9szalT314PoJ3mL/UIH39LE1VwQlHgBZu0FOuHwdfcNC
         tV8qD6Obmq0488gPKAhr1qAGcwdrsUMc5G+4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=lLWFQicLAiiuQPyEmUE/mGU9jTZ/W0uiz4rYK24KaYYpSf5l3bkcSQ/pEJNpMq8cci
         qMcX0d/Xb+2BwkHO7wfI6CJ2WwkKGp/nVy6v+0CMljJjb0qlXfgwS2MlCRAjUOX6u8Yi
         fsP3LyZa2ckf8WPp4PnYIZbFs05tJeltGXW60=
Received: by 10.141.88.3 with SMTP id q3mr7255096rvl.46.1216111824317;
        Tue, 15 Jul 2008 01:50:24 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 15 Jul 2008 01:50:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88540>

Hi,

Someone created a patch with git-format-patch and sent it to me. I
would like to apply & commit the patch. If I use git-apply, it only
patches my tree without committing it. Now, I need to copy the commit
log, run git-commit and paste the commit log there. Is there a more
intelligent way to do that?

Thanks,
Erez
