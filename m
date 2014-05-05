From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Mon, 05 May 2014 00:47:17 -0500
Message-ID: <536725e522a80_2c827cb30c1c@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5364A143.1060404@bbn.com>
 <5364b62d5fb7b_ac68dd30816@nysa.notmuch>
 <5365691C.1010208@bbn.com>
 <5365af33825c3_520db2b308bf@nysa.notmuch>
 <5365F10C.6020604@bbn.com>
 <536613bd14e24_1c89b0930cac@nysa.notmuch>
 <53669051.6090204@bbn.com>
 <5366ad66b9a6c_18f9e4b308b8@nysa.notmuch>
 <5367254E.5030402@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:19:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhtD-0005Yp-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600AbaEEF57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 01:57:59 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51873 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbaEEF56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 01:57:58 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so1133284obc.19
        for <git@vger.kernel.org>; Sun, 04 May 2014 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Vny43W5I/5oRfuVjq+R2Bgf3++Dx1VpCKpMeRCfI3dY=;
        b=nl6webTaPqqBUxwq6ZxkbOqDA3xg0Lolc+stQq0cm/YI9sO/ELO4naH0wprSFreMnL
         xD8pc+L8Smh7KEtpIxvcmh3N33Fli+y3RJiagowuOGn3dK0sVVOJZp0rsc1fbvGG1C+g
         ZEUS7BMApib1pNQj7QG8ObeE3cXELbnLRyTWquSefdayW+/M/YqGHV1l6SosmaKbp4KP
         117Cn6pkcdfSbFQR8HOuiB70J/1cr5bS3WvZMBtvpagJD2qzA+oqH3BJG9tSHXRXy/KZ
         kRYqb/PnGNSHLD0KZmtloUHjuEJXyhmqJeMpaa6VPVudQc9WVYYpuYbiWk51Wvyr8ZZ0
         NTeQ==
X-Received: by 10.182.79.9 with SMTP id f9mr190563obx.64.1399269478259;
        Sun, 04 May 2014 22:57:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id p1sm17020552obn.20.2014.05.04.22.57.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 22:57:57 -0700 (PDT)
In-Reply-To: <5367254E.5030402@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248127>

Richard Hansen wrote:
> On 2014-05-04 17:13, Felipe Contreras wrote:
> > Richard Hansen wrote:
> >> On 2014-05-04 06:17, Felipe Contreras wrote:
> >>> Richard Hansen wrote:
> >>>> On 2014-05-03 23:08, Felipe Contreras wrote:
> >>>>> It is the only solution that has been proposed.
> >>>>
> >>>> It's not the only proposal -- I proposed a few alternatives in my
> >>>> earlier email (though not in the form of code), and others have too.  In
> >>>> particular:
> >>>>
> >>>>   * create a new 'git integrate' command/alias that behaves like 'git
> >>>>     pull --no-ff'
> >>>
> >>> Yeah but that's for a different issue altogheter. I doesn't solve the
> >>> problems in 1. nor 2. nor 3.
> >>
> >> 'git integrate' would handle usage cases #2 (update a published branch
> >> to its "parent" branch) and #3 (integrate a completed task into the main
> >> line of development),
> > 
> > But these cases are completely different. One should reverse the
> > parents, the other one not.
> 
> No -- for both #2 and #3 I want the remote branch to be merged into the
> local branch.

I didn't mean #2 and #3, I meant (#1) vs. (#2, #3).

-- 
Felipe Contreras
