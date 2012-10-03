From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 3 Oct 2012 17:18:24 +0700
Message-ID: <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com> <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 12:19:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJM2j-0004VF-4w
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 12:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2JCKSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 06:18:55 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64795 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab2JCKSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 06:18:54 -0400
Received: by qchd3 with SMTP id d3so5396392qch.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 03:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h5Qgk+pjABaJQh4iDVZC+qqnpuX+NUgiJ3Z308qD+Nk=;
        b=i9O+5LWRgUxFeqLe9Wo/HfSPgs+YoLScC6NNhXoXiUXQSq9wAN9ndAv8PoxHr01tT9
         HcaY8CDNClO1JgU295xLPyLS5+Lb8jr3pFT12mOe3iDZ/izFdti6FIsRW5nj5EzuyX1+
         t9yQTcDnIix+BhaxCpLUBASFkVjukAF/6TWPHn21yh76+8M0n3AZ8ez3fg5I2aravckQ
         dl0QsmMdR5ANl5imnUHA/IquH3aYpGcwHE1DLNiSSLdztyz5t0VW1SrcJG7LcClyZ5Ju
         m1jYFPCRQ8s6t2yXmC0J328wRXYDjectIiCD8qmJLdMDXPcQne3161qFAcVZs64Hreq5
         Rf+w==
Received: by 10.224.58.147 with SMTP id g19mr6461014qah.77.1349259534319; Wed,
 03 Oct 2012 03:18:54 -0700 (PDT)
Received: by 10.49.72.201 with HTTP; Wed, 3 Oct 2012 03:18:24 -0700 (PDT)
In-Reply-To: <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206877>

On Wed, Oct 3, 2012 at 3:46 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> On second thought, it might not be such a good idea.  There are *lots*
> of variables that control the operation of each command, and it's hard
> to decide which ones to list and which ones to omit.  I've listed all
> the relevant variables for git-push, except the advice.* variables- I
> don't know how useful such a long list might be.

I think listing receive.* and advice.* (and maybe even
remove.<name>.*) is still ok. The goal is to give users a clue.
They'll need to look up in config.txt anyway for explanation. If we
name the config keys (and groups) well then users should be able to
guess what those keys may be for before deciding whether to look into
details.
-- 
Duy
