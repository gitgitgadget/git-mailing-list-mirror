From: Daniel F <nanotube@gmail.com>
Subject: git am mangles commit author name.
Date: Mon, 12 Jul 2010 23:53:15 -0400
Message-ID: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 05:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYWYd-0000OF-8I
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 05:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096Ab0GMDxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 23:53:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46736 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab0GMDxR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 23:53:17 -0400
Received: by vws5 with SMTP id 5so5273685vws.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=7be+RFiGX9oQCm0Eo1UAulOQYqF7slIUS4TLcWIvUD4=;
        b=npDrwVhahfxJ18MwMblf6SFwA9oXEh/jT8PnbkDq0ic6uykefjwxXgY0+AWNa66kSY
         afqjrLqSrkaBV6z101lNUmvJBYV51OUdo73NK5kVDf1aOorNBGHEAWI1yWxGPCtMwGW9
         Ej+xQ1nVeXYPVzWay9zo2TmPu105tthLwO4Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=FJPzTW8hAS7BMBwC2O1eNaWPJQLD+gQ8qmDAPce0OO27K7oBDDFdxy0/eTRrE9wefx
         V5gYhvBdODqnHFPd4DlPz35nglj/+4D4ph+2js41O1YQx1K9M0zlVcoFvqdrsk4WaOjL
         rc3h5G8WgTaci/uRMkRDsENjsERxyENCqds/s=
Received: by 10.220.88.167 with SMTP id a39mr7454318vcm.213.1278993195891; 
	Mon, 12 Jul 2010 20:53:15 -0700 (PDT)
Received: by 10.220.186.132 with HTTP; Mon, 12 Jul 2010 20:53:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150871>

Hi all,

Have a problem with git am. I am trying to apply a patch (created with
git format-patch) that I have in a file.
The file contains the line (along with the rest of the patch, of course):
From: username <emailaddress>

So I do the following:
git am --signoff < patchfile.patch
It applies just fine, but the commit author shows in in git log as:
emailaddress <emailaddress>
(i.e., the username is nowhere to be seen)

I'm using the latest git release, 1.7.1.1, on ubuntu intrepid.

Would anyone happen to have some suggestions as to what i'm missing,
and how I can get git am to properly treat the commit author name?

Thank you all in advance,
Daniel
