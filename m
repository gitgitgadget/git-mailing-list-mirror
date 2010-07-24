From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Git workflow with upstream repository
Date: Fri, 23 Jul 2010 20:58:08 -0400
Message-ID: <AANLkTinyUGLMTQ=ruk69pptDUQ3VyaQ7CwtO+QfeJUVC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 02:58:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcT4C-0005tJ-96
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 02:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317Ab0GXA6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 20:58:11 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48122 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755739Ab0GXA6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 20:58:10 -0400
Received: by qyk7 with SMTP id 7so571839qyk.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 17:58:08 -0700 (PDT)
Received: by 10.224.79.151 with SMTP id p23mr3302007qak.312.1279933088805; 
	Fri, 23 Jul 2010 17:58:08 -0700 (PDT)
Received: by 10.229.184.204 with HTTP; Fri, 23 Jul 2010 17:58:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151588>

Hi, I'm trying to figure out the best way to work with two remote
repositories: one origin and an upstream repository.

Basically, with one remote origin I do 'git fetch' and then a 'git
status' which tells me my status as compared to my remote at which
point I decide wether I want to rebase or pull/merge.

If I'm working with another remote repository 'upstream' that I
perhaps don't have permissions to and then my branches are not
tracking against, how would I do something similar to be able to first
see how my branch compares to the remote and then either rebase or
pull/merge.

Am I missing something in git status that allows me to see my status
as compared to another remote?
