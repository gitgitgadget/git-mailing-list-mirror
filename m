From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH/RFC v4 0/2] Add -e/--exclude to git clean.
Date: Tue, 20 Jul 2010 12:28:59 -0400
Message-ID: <cover.1279643093.git.jaredhance@gmail.com>
References: <e257dd98b7493dcd72de9cf62d5847116e030ed0.1279564639.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 18:29:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObFgy-0003oC-7O
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 18:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598Ab0GTQ3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 12:29:10 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42495 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758192Ab0GTQ3J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 12:29:09 -0400
Received: by qwh6 with SMTP id 6so2187897qwh.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zgRPc9uTNjScylWVeaQ3Zeh4pa6hiuyTvN7rkcC3x1Q=;
        b=Ji8q0cEfhSRFO8sckyMl9+f7Dc2tvsajMFAAzVtD1MLcJi8U9S/1/JZV1obI44NWwp
         nI/gOWWa8QSqwmqfslu3dK6gtFRohxAMQDkpC33Nj0CvOaH0fSeZ5Bf2V+97Js6aM24m
         7lM75lOteo/ySfu5i95HxYz09bvwycjqC2cdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sUBQyoBuj2yuahNOnrecebbsC0WbpD2dpAYFAIjnaHTUPEC7538vt0Ku0EOcK06jBM
         gzcBWkOB5lV7SwXDIbtNW0WtlYmmC8pmd+QcPX8nSL2wNE+knHzz1SEEMY3shDMcHu2R
         2hIelhNG9E06yal0knfRbqVIXII9jGca0vQMQ=
Received: by 10.224.2.147 with SMTP id 19mr6116155qaj.9.1279643346094;
        Tue, 20 Jul 2010 09:29:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id q30sm28175540qcq.36.2010.07.20.09.29.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 09:29:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e257dd98b7493dcd72de9cf62d5847116e030ed0.1279564639.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151324>

This is the fourth round of patches for git clean -e.

This round introduces a test in t/t7300-clean.sh.

No other changes were added to builtin/clean.c or
Documentation/git-clean.txt.

Since this patch seems to be somewhat controversial, I've marked it as
PATCH/RFC. I would like some ideas on what to use for separators as
well as constructive critism on the Documentation and test.

Jared Hance (2):
  Add --exclude to git-clean.
  Add test for git clean -e.

 Documentation/git-clean.txt |    7 ++++++-
 builtin/clean.c             |   21 +++++++++++++++++++++
 t/t7300-clean.sh            |   16 ++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletions(-)
