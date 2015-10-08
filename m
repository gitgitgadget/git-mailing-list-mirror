From: Victor Engmark <victor.engmark@gmail.com>
Subject: `-u`/`update-head-ok` unsupported on pull
Date: Thu, 8 Oct 2015 18:27:44 +0100
Message-ID: <CAA5Ydx9ySzEBWcUkmGQKTq93W0HzfEmb3ER7GPKzcnQJ0dbFKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 08 19:28:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkEzC-0002Zz-SY
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 19:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbbJHR2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 13:28:06 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35762 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965074AbbJHR2F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 13:28:05 -0400
Received: by wicge5 with SMTP id ge5so35710849wic.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=iV1NIcDtd8xMwl1QUu6cVx8VZpoW2WAC91pynUfSUuI=;
        b=sxVJHENTGxasOKKzcTLkkXPIsaIr8lDo7yRerTbvtoz6E1bBnS9RgO3fU7MNxzSDpy
         0ncxl1RpxlacnfIoJXGHmKUZx1wAKM9SNwYqOygenW8KW3TvnnVsh6kAGZSCZeg34Nsg
         wMjkJkegjaSAFPVQUEgZnhlOybCX5kCqqMCOKwifNBxRMUEfM76eErJWbgIf6O6Q61zK
         FIBADXjvtJ5tNl0G7VXioV8SLILHx4x3AKpnhRd4S6nc1eEhgPUh5kagnaIpRXWiGd99
         lQhP/9xmLjgYUR2qEghPiIJtfj6vXw2ZmLXPioANBg1O2pSTTb2PWMbWgkxxGkJt1/vL
         4KtA==
X-Received: by 10.180.85.164 with SMTP id i4mr5798269wiz.54.1444325284178;
 Thu, 08 Oct 2015 10:28:04 -0700 (PDT)
Received: by 10.28.13.12 with HTTP; Thu, 8 Oct 2015 10:27:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279250>

According to the documentation these options are supported:
$ git help pull | grep -e '--update-head-ok'
       -u, --update-head-ok

However:
$ git pull --update-head-ok
error: unknown option `update-head-ok'

Using:
$ git --version
git version 2.6.1
$ pacman --query --info git | grep ^Version
Version        : 2.6.1-1

Am I missing something? The manual seems to be for the right version:

$ git help pull | tail -n1 | tr -s ' '
Git 2.6.1 10/06/2015 GIT-PULL(1)

I'm running the system installed Git:

$ type -a git
git is /usr/bin/git

Cheers
Victor
