From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: Branch dependencies
Date: Tue, 2 Aug 2011 15:06:40 +0200
Message-ID: <CAKPyHN0kAJ-MVsrXam5NjsOYkta4nsSrZUvKoMSi-FeRUSuLEw@mail.gmail.com>
References: <20110801121946.GA575@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Aug 02 15:06:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoEgH-0006Vs-Ki
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 15:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab1HBNGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 09:06:43 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38004 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1HBNGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 09:06:41 -0400
Received: by vws1 with SMTP id 1so5162201vws.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uuVf3F3adwBRTdmGPk/7mzhe1p97CEk5S5FeO/MxCdc=;
        b=LuWHpb0/3wKtrBydlnzTAweH8urd5ut7+e3uDKYus4QRukmyEgMcsYpYMwht936MQf
         6H1vwLCGjL5chSCudGPTjzCXrHmCYcUPvNYg48cacHmeXMK6ubHC9jlUVT2AeqAxPW47
         s4RwS14nBnjQAXS/SsiTqUM+wWqSIcoh0VVpg=
Received: by 10.52.29.42 with SMTP id g10mr5786568vdh.36.1312290401037; Tue,
 02 Aug 2011 06:06:41 -0700 (PDT)
Received: by 10.52.184.4 with HTTP; Tue, 2 Aug 2011 06:06:40 -0700 (PDT)
In-Reply-To: <20110801121946.GA575@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178467>

Hi,

On Mon, Aug 1, 2011 at 14:19, martin f krafft <madduck@madduck.net> wrote:
> Dear list,

while I appreciate, that you dig this topic up. I think you are trying
to solve the wrong problem first. My main problem with the TopGit
approach is, that you can't freely change the dependencies of a topic.
This may be not the most common case in distro development. But in my
eyes more problematic than maintaining the meta data.

Please note, that I'm more than aware the the TopGit approach for
handling the meta data is awful and we need a new way here. My
personal impression is, that the git notes is the best we can have.

For my first mentioned problem, I think a new 'system' needs to be
'rebase' based, not merge based like TopGit.

Bert
