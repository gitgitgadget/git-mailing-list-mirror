From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [Fwd: Re: GiT and CentOS 5.2]
Date: Tue, 8 Jul 2008 14:58:43 -0400
Message-ID: <76718490807081158v5acb6e6co670597d5e08db6c1@mail.gmail.com>
References: <50493.216.185.71.22.1215543081.squirrel@webmail.harte-lyne.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "James B. Byrne" <byrnejb@harte-lyne.ca>
X-From: git-owner@vger.kernel.org Tue Jul 08 20:59:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGIPf-0001Hc-5H
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 20:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbYGHS6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 14:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbYGHS6p
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 14:58:45 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:5933 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbYGHS6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 14:58:44 -0400
Received: by py-out-1112.google.com with SMTP id p76so1283187pyb.10
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sIuzNjDcojy0LHk0ABOSvlvu6+yESjpSzrGTBzGRpNU=;
        b=QgqeZd3Tbx5cydeoPw6/JAa2VnkgpjMcfvLdkMlPS3+a1PhHqaJE1mmdoKkIG3hLfU
         zw/TpBh+J4YAGBBLDZTQeLOybla+9DxrtsibOAPBzAFRv6GNDA1dzA4Eka1XmkRcEPAC
         8jK3Y1vg1c0mQhzgXnnok6fX5DdDvxwNBGVio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=r3u61hndlqHF3uC9ucMaDJZLt4EEJiOmixwIJ5KolukNSmkYoEnJT4G+hZ5WC6kvxf
         i3v49lccmA8pTUjLZbhvDsE/GIteOjizw6sI0r3KuqNWgJJjLah4Mh5corkm1xWBEBhF
         BD7Faj3fLNICSZ/BkHNJQsaUs6V9Az4BQUL+U=
Received: by 10.114.178.13 with SMTP id a13mr6238850waf.158.1215543523330;
        Tue, 08 Jul 2008 11:58:43 -0700 (PDT)
Received: by 10.114.14.19 with HTTP; Tue, 8 Jul 2008 11:58:43 -0700 (PDT)
In-Reply-To: <50493.216.185.71.22.1215543081.squirrel@webmail.harte-lyne.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87785>

On Tue, Jul 8, 2008 at 2:51 PM, James B. Byrne <byrnejb@harte-lyne.ca> wrote:
> So, my question still remains: are these dependencies only artifacts of
> the build environment or do they supply actual features that the latest
> release of GiT depends upon and which are not available in the earlier
> version of the software?

You could of course answer this yourself. Download the latest RPM, rpm
--nodeps or rpm2cpio it and see if it works.

But from the looks of it, the git binary links against libraries not
on your system and it will not work.

j.
