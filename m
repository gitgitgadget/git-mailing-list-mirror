From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Introduce new configuation option to override
 committer information
Date: Thu, 20 Jan 2011 13:19:03 -0600
Message-ID: <20110120191903.GB11409@burratino>
References: <igadki$4tb$2@dough.gmane.org>
 <1294568989-5848-1-git-send-email-artagnon@gmail.com>
 <ih95il$62b$2@dough.gmane.org>
 <201101201352.01874.trast@student.ethz.ch>
 <AANLkTin-zUbVmJ3gUsDE5+AkECoAzN2Oim4=45JrcT6o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 20:21:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg04k-0000zx-3M
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 20:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab1ATTVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 14:21:36 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53550 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab1ATTVf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 14:21:35 -0500
Received: by fxm20 with SMTP id 20so937953fxm.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 11:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2PK8ojbvcniLiAWLnaxsbZI6tpDXWmxPv8MQlA+Yf0w=;
        b=x82g5J6mRkhGlYXVHtNc2rFIZzsyrPrMin8Qy8U5iyERP/iCvYxCXofKzVbmoTEFQe
         Pjah5i1XmvG8Bv0/ljasoV3zzAKFgNACU3UlJIAnuIEs763Q/oJXMwTqfN8Q7/DbSJw1
         j0fVyQjQJHYOKRRIXo9h475qGAfqgR6E/9DE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JcQFP+5AdfvZ1EHz1+yfOoCPn+ObjzytOR7BAcSwtcB0DWZcPeyTitYJMRf9zbAWfS
         VzKb4J+bLafcaDYmVa6Rm7VOLVODrqgg4mi4fZwBKd24c5nz/aQeQK9NA2+ZJV/zMmPB
         2elNCgMnDt/7lj8TUJJb25LWJvMf1zg2T1Ylk=
Received: by 10.223.89.139 with SMTP id e11mr2487418fam.69.1295551160802;
        Thu, 20 Jan 2011 11:19:20 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id y3sm3285149fai.14.2011.01.20.11.19.17
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 11:19:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTin-zUbVmJ3gUsDE5+AkECoAzN2Oim4=45JrcT6o@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165324>

Stephen Kelly wrote:
> On Thu, Jan 20, 2011 at 1:52 PM, Thomas Rast <trast@student.ethz.ch> wrote:

>>  My gut feeling is that a footer line in the commit along the lines
>>  of
>>
>>    Bugzilla-Id: Registered Name <registered.email@example.com>
>>
>>  would work.  I suspect others have a similar feeling.  A good case
>>  why this is not a feasible solution for (presumably) border cases
>>  like you would help get rid of it.
>
> Yes, my case is a border case. This solution seems to duplicate the
> committer email address in concept. It also requires more work for the
> KDE sysadmins.

Okay, this stirred my particular combination of lazy person and
busybody.  I volunteer to work on modifying the
commit-reading/bug-closing script to take a Bugzilla-Id line into
account when present if the KDE sysadmins are willing to accept such a
modification.  Another possibility would be a table (for example a
plain text file) mapping git identities to bugzilla identities.  Could
you put me in touch with them?

Thanks for your work to improve tools.  I do appreciate it.

Jonathan
