From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: How to get status-like short format for old commits?
Date: Mon, 26 Mar 2012 13:24:24 +0200
Message-ID: <CAA01CsqM_cmf8A5OjdkX4i-ituCWK95ygEoK_Y0-2LkKo1D7kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 26 13:24:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC82L-0001mw-Vm
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 13:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224Ab2CZLY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 07:24:26 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57695 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932076Ab2CZLYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 07:24:25 -0400
Received: by iagz16 with SMTP id z16so8130882iag.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=82Wi0DBcRTvx8yOLFuFjxop6lNEau9VHqThcTXKblfc=;
        b=ZuMgF7s8NonuJcMJTS37B1cevllyGyNhRRHgxHvMlgUUkBCio1h4aBZ91kHpX5VqH1
         32ty6wAHbJ7yz/n/8fdozDSYvI3rpLg7c8glwC45Lod4OZx6qapBVqEbe/9UeS0GDCfU
         BPbZcMv1XyBBFLm0sTCYcFTahJ0cTlCj1R9wm5ekam//Bf9Xlfo/PWeUlmlKjxIAWCPr
         WdeAa2sO6zYmhBAcBWhYHPsONXE3NLObRq1B+WyGJaM/2B38kArOTGl2S4WAaEX5fglZ
         VVzi2WuQyRHlLFVdHmUFFcDyoto0auHFdNK+PivSO8Hx0PNkDLP3AiecLBdXXzSGyDE7
         pt4g==
Received: by 10.42.115.2 with SMTP id i2mr12523132icq.54.1332761065027; Mon,
 26 Mar 2012 04:24:25 -0700 (PDT)
Received: by 10.50.170.40 with HTTP; Mon, 26 Mar 2012 04:24:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193905>

Hi,

I there a way to get a clear status of some past commits, like 'git
status' shows for current index/HEAD? I.e. something like

git status HEAD^
#	modified:   Makefile
#	deleted:    t/t0080-vcs-svn.sh
#	new file:   t/t9011-svn-da.sh
#	renamed:   xxx -> yyy


Thanks,
-- 
Piotr Krukowiecki
