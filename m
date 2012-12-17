From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: git log reliability
Date: Mon, 17 Dec 2012 09:38:22 +0000
Message-ID: <1355737102-ner-5842@calvin>
References: <CANirugRmpoGb=T1V2ZBw3GEE5nYwD-hyLOfWgt-UVvMXh-i_OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Prasad Karmarkar <prasad.s.karmarkar@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 10:38:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkX9q-0006ZD-CZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 10:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab2LQJi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 04:38:27 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:53539 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab2LQJi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 04:38:26 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so2283052eaa.19
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 01:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:in-reply-to:mime-version:date:message-id
         :content-type;
        bh=xfsOUeicq7A9McKTTReOP4YGTobdxDRRF7IthFgDeIk=;
        b=sXihnntd+PpjItY/3SUA7v9XCdtOHq/XbAibMClsyHVMNlB8oW49Lczn5ug6qFkKUV
         soTl4Md9U4XPkNDpSBzc2IOaV+6tOE3MqKyMGsvTntxUB3wG134HIbueWk3DquweF5oS
         nGVXh1LFZvKLORAvXxL8HhNGF0euou6D8OXc4bXPa54jpmx/RTsLHLlPHttVQFmaf1IT
         96swMPAY4BSuPMTT1QaTUPZyZMJNrhYfyboyc3GfhfydJTR5jIn3leg/DZtN7iGIItc9
         JPAgblL3ozY24M5vmEWNScJzhTa/1fmJ2JZ6YUG6k7EGoNr3ENGGQD7nHTOPJvirZ+M0
         SB6A==
Received: by 10.14.225.72 with SMTP id y48mr39488952eep.46.1355737105781;
        Mon, 17 Dec 2012 01:38:25 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id 46sm27936417eeg.4.2012.12.17.01.38.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2012 01:38:25 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 9E3D0129243; Mon, 17 Dec 2012 09:38:22 +0000 (UTC)
In-Reply-To: <CANirugRmpoGb=T1V2ZBw3GEE5nYwD-hyLOfWgt-UVvMXh-i_OA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211667>

On Mon, 17 Dec 2012 14:56:17 +0530, Prasad Karmarkar <prasad.s.karmarkar@gmail.com> wrote:
> Hi ,
> 
> I have been hearing from my Release Management that git log is not
> reliable. Is it so ?
> Is there a known instance where Git log has missed out on commits ?
> 
> Any information about this would be really helpful

Are you talking about git skipping commits due to history simplification (read
the corresponding section in the git-log man page)?

Also, what for does your release management use git log? Maybe there is
a better way to do what you need to do.
