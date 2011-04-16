From: David Chanters <david.chanters@googlemail.com>
Subject: Generating GNU-style Changelog from git commits
Date: Sat, 16 Apr 2011 23:46:37 +0100
Message-ID: <BANLkTi=j_Ge9h8+r8R-a5Fppan_2dtu5LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Chanters <david.chanters@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:46:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBEGJ-0004at-QC
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 00:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759321Ab1DPWqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 18:46:39 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61780 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab1DPWqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 18:46:38 -0400
Received: by iyb14 with SMTP id 14so2981214iyb.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=8Y876xW4bKVLZmm9epJ751uBHuIk7nsnXdzSNANoyAM=;
        b=clonrt2UaCn+nJ16XvyUFDC9WmBWx7axbtYcfXeBhfbTBUNW03w5SWV7ZAzIH4pyIr
         MtgSkzlgF1GLLJssY5xsi5Vb81Un1Wlx+56eKrOthRwJarBCRovkYnLmBdxWT+JCwFnI
         OGbure4rPuPZ6SAmhbECGQ/ZHWP4OuRlHdTII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Ay8kX8WP4T21iZJTBuZ4bFGQ/fJPsv9C6LTXai28Yb3EVWiJ5FVNZGurWY88R+iX1G
         oLAoLFqV9oZTXiyQ6lpVDpFWGsyTO4BG+wyQb/RoO8k5XWy94CMQy7ciBDOJ4wgaAsDk
         TgQMgBiF8//gjdk1FsFGhys6VIX/yNMNQShVI=
Received: by 10.43.68.204 with SMTP id xz12mr2489593icb.354.1302993997846;
 Sat, 16 Apr 2011 15:46:37 -0700 (PDT)
Received: by 10.42.178.3 with HTTP; Sat, 16 Apr 2011 15:46:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171701>

[Please Cc me on replies.  Thanks!]

Hi,

Some projects maintain a ChangeLog file, which looks something like this:

2011-01-01  David Chanters  <d.c@example.com>
        * foo/bar.c (some_function):
         Changed static variable in some_function to auto.

etc., etc.

Here "foo" is some directory relative to the top-level directory the
.git one is in.

These ChangeLog files are maintained manually, irrespective of the/any
revision control system in use.  I am wondering if it's possible if
the project is in Git to be able to automatically append to such a
ChangeLog file with each commit automatically, and have it formatted
in the style above.

Is this possible?  Is it a solved problem?  If not, and I wanted to
try myself, could someone point me at the git-specific tools I'd need
to know to use to achieve it?

TIA!
DC
