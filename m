From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: VSS to git
Date: Mon, 2 Mar 2009 17:51:12 +0000
Message-ID: <e2b179460903020951h7f1538daya4d3cdb96fc7c65d@mail.gmail.com>
References: <b0a3bf780903020915g60d97b76pfdbbd60017625f0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Velevitch <chris.velevitch@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 18:52:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeCJm-000653-US
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 18:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbZCBRvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 12:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752681AbZCBRvP
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 12:51:15 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:6526 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbZCBRvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 12:51:14 -0500
Received: by qw-out-2122.google.com with SMTP id 5so3753613qwi.37
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Tdl4mDEUqjiRzej9Gv/TnbLWA9jrhZwui/l09EzxJWk=;
        b=T6Yg84uvDEQynK681OfjX2jqnGKG9MB3ijQhsnKM4z/35Csw4aUeR3U0ZVW4Uw9ryL
         H3tTsoNgCui9HbJx0Wn4dXcHlDMm+8h5QXMZFsL/6Zq3nlSdVavHZuIRPEw9tte0yeVp
         uYT1F7xuVSa8WngJscM6wOeyrUJCbyEK8/EJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ttrnU/W5IMj57j5A9TKKOVrYKJ9h0ycVlspPXsMxyd06BGY06Ll/mZPRbGz+56kSjt
         rmgUuimR/ihrQVlfxNFhEmWxfUYb+6CuD68nuW4d57FJTjoE3ZV7fLUlQnlhBrw88Uxj
         85LWQBmok7SjPS4uc1XgvqYrYXCj1siMi1Bdc=
Received: by 10.224.54.5 with SMTP id o5mr7958469qag.140.1236016272089; Mon, 
	02 Mar 2009 09:51:12 -0800 (PST)
In-Reply-To: <b0a3bf780903020915g60d97b76pfdbbd60017625f0a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111952>

2009/3/2 Chris Velevitch <chris.velevitch@gmail.com>:
> I can't seem to find any utilities to convert a vss repository to git.
> In the absence of such a tool, what is the best approach to converting
> an vss repository to git?

You might be able to two-stage through vss2svn[1], and from there to git.
Or take the guts of vss2* [2] and rewrite the backend to create git
fast-import format?

Mike

[1]http://www.pumacode.org/projects/vss2svn
[2]http://sourceforge.net/projects/vss2cvs
