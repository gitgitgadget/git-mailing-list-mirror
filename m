From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] Make "git request-pull" use the configured 
	remote.REMOTE.uploadpack
Date: Wed, 29 Jul 2009 02:13:30 +0200
Message-ID: <adf1fd3d0907281713t378440eamb39baae3be6d41c4@mail.gmail.com>
References: <1248728563-23906-1-git-send-email-tgrennan@redback.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tom Grennan <tgrennan@redback.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 02:14:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVwo3-0006Hz-To
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 02:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbZG2ANg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 20:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753295AbZG2ANg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 20:13:36 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:60914 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbZG2ANf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 20:13:35 -0400
Received: by ewy26 with SMTP id 26so457705ewy.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 17:13:31 -0700 (PDT)
Received: by 10.216.21.194 with SMTP id r44mr2149703wer.80.1248826410863; Tue, 
	28 Jul 2009 17:13:30 -0700 (PDT)
In-Reply-To: <1248728563-23906-1-git-send-email-tgrennan@redback.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124290>

2009/7/27 Tom Grennan <tgrennan@redback.com>:
> git-request-pull.sh should use git-parse-remote:get_uploadpack() to
> load a configured remote.REMOTE.uploadpack like "git remote show" and
> "git fetch". This allows one to specify the path of git-upload-pack on
> the remote side.

Sorry, but I removed all unused functions from git-parse-remote in 62d955f
(parse-remote: remove unused functions, 2009-06-12), and it is in
v1.6.4-rc1. I don't think there is much problem reverting part of that commit,
but I wonder if the problem is that "git ls-remote" does not read the
remote.<remote>.uploadpack by itself as it reads the remote.<remote>.url.

Santi
