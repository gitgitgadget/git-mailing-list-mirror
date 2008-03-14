From: "Ping Yin" <pkufranky@gmail.com>
Subject: Should 'git config' support key with dot such as 'a.b'
Date: Fri, 14 Mar 2008 16:24:34 +0800
Message-ID: <46dff0320803140124t1469defsf7002f720cf2002e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 09:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja5EB-00064Y-Qx
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 09:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbYCNIYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 04:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbYCNIYh
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 04:24:37 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:43204 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYCNIYf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 04:24:35 -0400
Received: by an-out-0708.google.com with SMTP id d31so911969and.103
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 01:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=XRPVR8bFxEXoHsGYHFFVpVEPpC3WTqHHA5E9CMS2SGk=;
        b=Lwb52F0jE1wMRK2UPJcfZ77IRrZts67CIgMFEtRataGRFUmSpGaz/KmGfu+l6qQiGTHvOlRrpWeostaiJ3o4xQ6V4gQX1ucHcQtDuuMbAvD3i04ZVVwFB68cfn/aIECrDi+6o2QYlnqA9FU1raY3C3t9aXmW27rsqcSchiw07I4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Wa2UI+MfaYQs/wVQ+ZU1izHzjRXSicsA82c30nthrWxWW5wuLgyFYC6fz11DijpROs6mU8jf/mVJNpI+fRfSLZQxAKHQGDPqessj9ly09t1BDHK2lx8CNzu4HAyrs+JRjgYQcoZq0g5tKM0Whfx1m717RxewyWBfYxRB6hh9fGc=
Received: by 10.100.211.8 with SMTP id j8mr22216566ang.35.1205483074170;
        Fri, 14 Mar 2008 01:24:34 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Fri, 14 Mar 2008 01:24:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77190>

I find it is so annoying to write submodule definition as follows
(yeah, only url, without path)

------------------------------
[submodule 'crawler']
    url = url1
[submodule 'search']
    url = url2
------------------------------

I think the following form is more simple
---------------------------------
[submodule]
     crawler.url = url1
     search.url = url2
---------------------------------

So, could we support such simpler form?


-- 
Ping Yin
