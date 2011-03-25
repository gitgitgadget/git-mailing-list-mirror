From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git-svn: --include-paths ?
Date: Fri, 25 Mar 2011 11:10:30 +0100
Message-ID: <AANLkTimL=ew2EmcfdJdJr89-NiUO5TtSYuLLVxBUORB1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 25 11:10:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q33yX-0004rf-4u
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 11:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933837Ab1CYKKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 06:10:32 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34520 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab1CYKKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 06:10:31 -0400
Received: by vxi39 with SMTP id 39so655200vxi.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=YmdWLP08f+Ebzf+IE0XPkuR66Bkan52Z5fUFK5kcxtg=;
        b=qgLuP7liRpXNv5fnnAT5HrKkhm6II/AqCeRl2zXM8lqeRphAjkNxxckLk/qohfvXsP
         oOStp6A3NgIgK6HAy1K9VrRMMgaRlefNQTNrB0TDIlLXDaraPyVbLM0rf1DK7V/Ahc/q
         e9A8csjbQriqhqYR37irS7tz5z2QMe97HNb30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bwlxZJa4uufXj38iaGMVjoRg51NELpHb4dfka7PLXeZvg36hiU03btJg6xNlVO51TY
         NqzvLJBDlfwC4isqQvt2L8bTQrwRi/AuKjKufh0Qx5CPAWxx1nbvJmy5seJo/ewI5Pl6
         uxh0KQsIA0opuKfAeOvjRt1E6+4LGVn7FM3e0=
Received: by 10.220.203.11 with SMTP id fg11mr155398vcb.136.1301047830851;
 Fri, 25 Mar 2011 03:10:30 -0700 (PDT)
Received: by 10.220.210.16 with HTTP; Fri, 25 Mar 2011 03:10:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169977>

Hi,

when using git svn, is there an easy way to
specify which branches/tags should be cloned?

I know I can use --ignore-path, but in my case there
are almost 140 branches+tags, and I want to clone at
most 10 specific ones, so it would be *much* easier
to specify what I want instead of specifying what I
don't want.


-- 
Piotr Krukowiecki
