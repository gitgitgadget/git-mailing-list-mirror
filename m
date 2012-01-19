From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Rebase and incrementing version numbers
Date: Thu, 19 Jan 2012 13:48:38 -0500
Message-ID: <CADo4Y9is9mBOJaU+YRTMedTz7FfDrMFoDiqiUvQpVxQpyariPQ@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	<CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
	<CANgJU+WWq=+BP1ZDbGY3weB5Xey2TtbryDJvz5=eMLFzNet3xQ@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 19:48:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnx2S-0003uC-0r
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 19:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644Ab2ASSsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 13:48:40 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37619 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543Ab2ASSsj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 13:48:39 -0500
Received: by vcbfo1 with SMTP id fo1so198724vcb.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 10:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6W4HuGkn6Cg95ON41AA06Zjp0zZhQvOfnysSO6guwSo=;
        b=cg6+cM2tYsk3WL1xoNRtDBj14jHWb5cDmdPg8O8RnQ2xsMz9fh+LUgWiHMJ/4pjWIe
         ypTCzx0WVZqEUncYlxp37E6/QpkCVblD0gYytwiIKpspRIx5g7eX1IjLWMNU8FgUjfCj
         MS21BIy7uht3S5gkDAD19CYEJxKBQrhE6WApE=
Received: by 10.52.177.40 with SMTP id cn8mr217173vdc.43.1326998918918; Thu,
 19 Jan 2012 10:48:38 -0800 (PST)
Received: by 10.52.64.231 with HTTP; Thu, 19 Jan 2012 10:48:38 -0800 (PST)
In-Reply-To: <CANgJU+WWq=+BP1ZDbGY3weB5Xey2TtbryDJvz5=eMLFzNet3xQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188825>

On Thu, Jan 19, 2012 at 1:12 PM, demerphq <demerphq@gmail.com> wrote:
> Stop using version numbers and start using the git sha1 of the code
> you are using.
>
> Yves

1. Others in the group use SVN.
2. The version number needs to be increasing, to work with the current
process.  SHA1's are random.
3. The "git sha1" for the commit/snapshot cannot be put into the
config file, which is part of the snapshot.

Mike
