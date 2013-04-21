From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/1] git-multimail: a replacement for
 post-receive-email
Date: Sun, 21 Apr 2013 03:56:12 -0700
Message-ID: <20130421105612.GA28959@elie.Belkin>
References: <1366541380-10786-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 21 12:56:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTrwd-0008Gz-1g
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 12:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab3DUK40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 06:56:26 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54506 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3DUK4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 06:56:25 -0400
Received: by mail-pd0-f174.google.com with SMTP id y14so81433pdi.5
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MU6X+6ZZLi94ipJNhOOZO463QFOSj2amlhOmBd821CE=;
        b=z2lHhBChxC5xpiEf9/UpunT7SeeQTj8hHK+E82ExIns1IX+i5tN+vuIc2KHnnhF2vf
         /odlYeZeanB80yH9utZcfLLz8N7IiDbqQmAeFZXKNbXlwrgFuJCqrB/nQ1VEQui+BhCy
         nK+uJzwejp88RuEqNXmrXJk3C77sE3AgmScCW12Oy+SJs/ThdWnYfVTI8d4HbOUEhFgh
         WisPOY3a3VZzvygDVFX+U6suzYsl0fQMHCqXcO5cvO5yatFDCkk2jKPAobTDsGyue5OT
         PvksMhfGyrWc/KMw8myLQB4GIdCi5kWeN19HVpdRnV5K1Fpf0PNjnbG6wg8MLmjmZVLW
         y2Ow==
X-Received: by 10.66.145.166 with SMTP id sv6mr10859529pab.1.1366541784886;
        Sun, 21 Apr 2013 03:56:24 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ad7sm20623304pbd.14.2013.04.21.03.56.22
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 03:56:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1366541380-10786-1-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221943>

Hi,

Michael Haggerty wrote:

> This series consists of a single patch that adds a directory
> contrib/hooks/git-multimail/ containing five files, described in the
> patch's commit message.

Yay!  I look forward to seeing it.

[...]
>                                       The first of these commits
>     consists of a code drop from the private repository just
>     mentioned.  The recent part of this history includes commits by
>     other authors.

That could be a reason to do a subtree merge if you want.  A code drop
with a commit message that acknowledges the contributors would also
presumably be fine.

[...]
> * How to organize future development?  Directly in the Git repo, using
>   the git mailing list, etc?  As a fork of the Git project that
>   occasionally issues patches and/or pull requests to the main
>   project?  Or as a separate project that does not include the whole
>   Git tree, which is occasionally merged back to the Git project using
>   subtree merge?

My personal preference is that patches come on the git list, are
reviewed here, and then go to your fork of the Git project that Junio
can periodically pull from at your request (like git-svn).  But of
course this is up to you, too.

Thanks,
Jonathan
