From: Aaron Crane <git@aaroncrane.co.uk>
Subject: Re: [PATCH/RFC v4 0/2] Add -e/--exclude to git clean.
Date: Tue, 20 Jul 2010 18:03:36 +0100
Message-ID: <AANLkTinzavHKSVs4BYGtc-T1IKAS21yk-yzybn7G7IaZ@mail.gmail.com>
References: <e257dd98b7493dcd72de9cf62d5847116e030ed0.1279564639.git.jaredhance@gmail.com> 
	<cover.1279643093.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 19:04:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObGEb-0004yV-1m
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 19:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761417Ab0GTRD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 13:03:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39619 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761396Ab0GTRDz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 13:03:55 -0400
Received: by bwz1 with SMTP id 1so3036305bwz.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 10:03:52 -0700 (PDT)
Received: by 10.204.84.230 with SMTP id k38mr5348305bkl.160.1279645431829; 
	Tue, 20 Jul 2010 10:03:51 -0700 (PDT)
Received: by 10.204.100.16 with HTTP; Tue, 20 Jul 2010 10:03:36 -0700 (PDT)
X-Originating-IP: [87.194.157.167]
In-Reply-To: <cover.1279643093.git.jaredhance@gmail.com>
X-Google-Sender-Auth: 4XPzsNFuDbS8QSigKD6AYgHlvOU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151331>

Jared Hance <jaredhance@gmail.com> wrote:
> This is the fourth round of patches for git clean -e.
> Since this patch seems to be somewhat controversial, I've marked it as
> PATCH/RFC. I would like some ideas on what to use for separators

Rather than stuffing multiple exclusions into a single option, how
about requiring one -e option per exclusion?

git clean -e foo -e bar

-- 
Aaron Crane ** http://aaroncrane.co.uk/
