From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Wed, 1 Dec 2010 14:56:20 -0800
Message-ID: <F13BED73-8C90-46D9-8AC9-054EF24DC688@sb.org>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net> <1291230820.11917.25.camel@drew-northup.unet.maine.edu> <877hftuvvz.fsf@picasso.cante.net> <26B3CE3C-0C45-4D0B-8588-3769467AF527@sb.org> <87ipzdt8gb.fsf@picasso.cante.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 23:56:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNvbB-0002v9-LC
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194Ab0LAW4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:56:25 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46123 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233Ab0LAW4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 17:56:24 -0500
Received: by pzk6 with SMTP id 6so1159018pzk.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 14:56:24 -0800 (PST)
Received: by 10.142.6.35 with SMTP id 35mr9587929wff.303.1291244184067;
        Wed, 01 Dec 2010 14:56:24 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w14sm581176wfd.18.2010.12.01.14.56.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 14:56:23 -0800 (PST)
In-Reply-To: <87ipzdt8gb.fsf@picasso.cante.net>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162633>

On Dec 1, 2010, at 2:49 PM, Jari Aalto wrote:

> Whatever you feel. Consistency is important viewpoint. Try explaining to
> a group of people these two variations. The make them write scripts to
> use git commands. Guess which notation they choose? The "^" isnt' even
> scriptable.

What do you mean? I've personally taught nearly everybody at my office how
to use git, and every single one of them uses ^ when they want to go to the
previous commit and ~n when they want to go n commits back (where n > 1).
Even the few people who knew git before I talked to them use this convention.
And guess where those people learned it? By seeing the different syntaxes
in the manpage. Even for the people I taught, I never told them expressly to
use HEAD^ vs HEAD~3, but through the combination of my examples and the
examples in the manpages, they all understood both operators and how to use
them without any difficulty whatsoever.

You stated that you have "witnessed close hand for thousands of learners."
And you state that these people don't understand this sort of documentation.
I don't mean to give offense, but have you ever considered what the common
element here is?

-Kevin Ballard
