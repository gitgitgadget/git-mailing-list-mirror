From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 14:02:13 -0400
Message-ID: <9e4733910606101102k2a860cf3jd767331e6b5dcf10@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	 <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
	 <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>
	 <87y7w5lowc.wl%cworth@cworth.org>
	 <Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>
	 <448A847C.20105@dawes.za.net>
	 <Pine.LNX.4.64.0606101041490.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rogan Dawes" <lists@dawes.za.net>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 20:02:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp7nA-0002aR-VJ
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 20:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWFJSCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030468AbWFJSCP
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 14:02:15 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:9383 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030477AbWFJSCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 14:02:14 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1334693nze
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 11:02:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XM2MQaudLk5+9MfQkdwyhAgxxvUbY+CeZYzo3SltiAmb6oiWJsWV+Loi23ufBebb//3Etz9foUnYirvM5FtdQfWc7ZTniH1HoMqlWHISaS52gV1E0GH3lI1juzlLXxmpzvbekeUqVjaPIIz+zsgnuyM6YcVkNuJ5xeVZ/ReLNao=
Received: by 10.36.36.8 with SMTP id j8mr1186708nzj;
        Sat, 10 Jun 2006 11:02:13 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Sat, 10 Jun 2006 11:02:13 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606101041490.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21613>

Here's a random idea, how about a tool that turns a real pack into one
that is segmented and then faults in segments if you do an operation
that needs the old segments? The full pack would always look like it
is there even if it isn't. Something like gitk would be modified not
to fault in the missing segments.

-- 
Jon Smirl
jonsmirl@gmail.com
