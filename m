From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Querying Git for the path to the system config file
Date: Wed, 20 May 2015 22:23:55 +0200
Message-ID: <CAHGBnuPCZCBsBXqGo26E-pcuZXZBxL8GwAehW4UziDpB2V8Npw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 20 22:24:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvAX2-0002Y3-QL
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 22:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbbETUX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 16:23:56 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35683 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbbETUX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 16:23:56 -0400
Received: by iesa3 with SMTP id a3so48409284ies.2
        for <git@vger.kernel.org>; Wed, 20 May 2015 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=vnfbG8LwYAdG/A9KEZfcDSQt8fFT4cdZinS3NgsxjUk=;
        b=MXzR+aiyFnmKh5MAa4tsT7pmYMHx2WFmMI3x8RJs5o9SGHwl7KuKpMu3UujGabxtNf
         97Rkqg4jzyDgHT4qLyWCJ/UGE1JBhNfqK6Ra+MgXXSPrd5exLN8mmTxAbYdBnfdcrLxB
         uXZOBxNF85fdS74u2zL9w1n5Rpq087oP0XZTMbqq76Yz7RYnGuZxoXkpd94Y7le4yUkt
         kVOA0PBrQRhPLc8jYrTwsVxBYqqvH++e1Hz0ezM7t0imAe+TKdalurcc/5avNri9uKR4
         ZhDXHQMjIi0wUYLZxVj1dSocA4XTULTFFTUUfiyPqPbdFUlgaZYvozv5RHffNUsqhSLN
         slPw==
X-Received: by 10.42.126.10 with SMTP id c10mr33636149ics.66.1432153435398;
 Wed, 20 May 2015 13:23:55 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Wed, 20 May 2015 13:23:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269517>

Hi,

I was in need to find out the path to the system-wide config file that
Git is using. I need to do this in a platform-independent way (Linux,
Mac OS X, Windows). What I came up with is

$ GIT_EDITOR=echo git config --system --edit

to trick Git into printing the path instead of opening the file in an editor.

Just wondering, is there a less hacky way to do that?

-- 
Sebastian Schuberth
