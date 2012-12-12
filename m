From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Wed, 12 Dec 2012 14:10:44 -0500
Message-ID: <CABURp0oc_g3T3n0A4on=n8443sTFR6SKf1xcgN2EAFcx9eU_Ng@mail.gmail.com>
References: <50C22B15.1030607@xiplink.com> <7vvccdhhod.fsf@alter.siamese.dyndns.org>
 <50C22F72.6010701@xiplink.com> <7vwqwtfzis.fsf@alter.siamese.dyndns.org>
 <50C24ED7.90000@xiplink.com> <7vsj7hfw6q.fsf@alter.siamese.dyndns.org>
 <50C25539.9010206@xiplink.com> <7vobi5fu3c.fsf@alter.siamese.dyndns.org> <50C4FD00.4010003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 20:11:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiriG-0003UW-TK
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 20:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab2LLTLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 14:11:07 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:53019 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab2LLTLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 14:11:05 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so725227eek.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 11:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qr5xBCRFFrP3aHDIWoJ5depCnrWneBnuRyqW9yQ0tmQ=;
        b=lXAqHNfvwhU2C+wTKT9kFCOf25URAJrZoH+18A/bM+Pi98N0C1iojG8aiz/+7lA1Uv
         ckY5XQbBpR2MqnE8kFK1m2oouN8/CB46qvB+W6ILYVjgfs6MF+zaWHrc6E0NbS8wqs10
         e7cpCkOSo1fruFWG8tVZKAcf5lV5qxQ9zq6XzftvCyR/yT+C0DRrdchBECtsKliUGWWU
         C3nnUqtb/uzJiEVGku0iEm90/WUjQZnZKedY0QXzw5qabnD+up1vnWMe23/+rwsajblj
         jlZIbsmRJjAvAz6H2+RpXhIBC+URv8HOcSGhRIaWngslVt9HX6QRn4kiQU/LRVJekH/v
         JGKQ==
Received: by 10.14.209.193 with SMTP id s41mr5257299eeo.9.1355339464647; Wed,
 12 Dec 2012 11:11:04 -0800 (PST)
Received: by 10.223.195.135 with HTTP; Wed, 12 Dec 2012 11:10:44 -0800 (PST)
In-Reply-To: <50C4FD00.4010003@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211382>

Marc Branchaud <marcnarc@xiplink.com> writes:
> It's FreeBSD 7.2, which I know is an obsolete version but I'm not able to
> upgrade the machine.  I believe FreeBSD's sh is, or is derived from, dash.

Dash has been the default '/bin/sh' for Ubuntu for quite a long time
now[1] in spite of repeated reports of compatibility problems[2].

Phil

[1] https://wiki.ubuntu.com/DashAsBinSh
[2] https://bugs.launchpad.net/ubuntu/+source/dash/+bug/141481
