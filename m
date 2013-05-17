From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Fri, 17 May 2013 15:01:57 -0500
Message-ID: <CAMP44s1N4XpR4W-DgGgZrBPp-xe+14JpRTAXs=C0CdAb149nfQ@mail.gmail.com>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
	<51968311.1020107@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Fri May 17 22:02:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdQqz-0002Cg-Ik
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 22:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351Ab3EQUCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 16:02:00 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:50860 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab3EQUCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 16:02:00 -0400
Received: by mail-lb0-f181.google.com with SMTP id w20so4437619lbh.12
        for <git@vger.kernel.org>; Fri, 17 May 2013 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AI05WLH2wj0g1cHV/dPXS1QOSTPl8RyXfos8Wk3cCK0=;
        b=hGonQXKkXKKyFaZ2uAFNePTgldOQGKQc2CxBD0cuakuYfpugPk/iINcUlhilS9l8oU
         EftVRxiDHlh+FkTDYKxxDIP4yvae4bGjA70FObu8lGK9VZmiMehMtM3bjnH0qES9sFB+
         Abu81TP405vzOIk1d83em4mjxNtIPClCV+lIbk+A6tlDbvvezpMhlUlJPBejuiM7QW7l
         pO71LK+EkEHw8Ld1CSJKthD15CGus1LRtb948f9dIUUwvQxXgTY9S5zg0E97a0dh1l8q
         25zaJPW/UGFXOHczcI5CXFtSRGVf3XiBQiZZ1k3qB6YEq7mBMuwOwA+6/EuIuUsrI5FY
         wTgQ==
X-Received: by 10.112.172.40 with SMTP id az8mr12181228lbc.88.1368820917206;
 Fri, 17 May 2013 13:01:57 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 13:01:57 -0700 (PDT)
In-Reply-To: <51968311.1020107@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224734>

On Fri, May 17, 2013 at 2:20 PM, Kevin Bracey <kevin@bracey.fi> wrote:
> On 15/05/2013 23:34, Felipe Contreras wrote:
>>
>>   I think I'm using 'upstream' for something it was not intended to, and
>> I think the current 'upstream' behavior should be split into
>> 'upstream' and 'base'.
>>
> I found myself thinking the same thing. It's really convenient being able to
> set your topic branch's upstream to another local branch, so git rebase
> works without parameters. But then I can't use upstream to point to a remote
> version of that topic branch. I want my topic branch to know both that it's
> based on master (or origin/master), and that it's upstream is origin/topic.

If you are in your topic branch, what do you expect 'git pull' to do?
And what do you expect 'git push' to do?

-- 
Felipe Contreras
