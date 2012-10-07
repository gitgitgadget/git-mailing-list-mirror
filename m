From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Sun, 7 Oct 2012 21:39:48 +0530
Message-ID: <CALkWK0m0ZzOmwFxAt40gHXi98JEq+==9ctiLYVYf4UE5GB+V8A@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com> <7v7gr75s40.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:10:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKtQq-0004vR-OX
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 18:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab2JGQKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 12:10:11 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:64830 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab2JGQKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 12:10:09 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so1407925qaa.19
        for <git@vger.kernel.org>; Sun, 07 Oct 2012 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vkTe4cLV1yGisNN6QXW2DOyqi5w0oxVFsHVpXjwgy70=;
        b=yLqpdx/AVjMFdh9nuEjZp46AkcdSyU4J6D9ibW+HUCfqfxNrfwT98gwxPH8q0c7STX
         EVHF/w8Nm1icWktaeljf7AFW453xzlvg1Lx15JOVhBwqAOzHmX3lHn15SRNE0LBm58gL
         EZ9r0P3zaBPCptsGLCXWGHou0+4w0AZXg2HY8/GdfPUg8MpEa0sG3TjoV4mFqkUIhRAM
         mQtJh24qGVYsWPXIFzLFh46n6+Zom86ZvfJg+nJOk6RYVg2rgGK4J9Df6emMIPvICp0z
         a8pzoZGs1PNXLkoH9f8LMT46XyuXN2hJGVRGAjS1sMnCOZ3R4xPfF46wZxK5PG2tzYqv
         QSOA==
Received: by 10.224.202.9 with SMTP id fc9mr25984514qab.23.1349626208705; Sun,
 07 Oct 2012 09:10:08 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Sun, 7 Oct 2012 09:09:48 -0700 (PDT)
In-Reply-To: <7v7gr75s40.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207184>

Junio C Hamano wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Wed, Oct 3, 2012 at 3:46 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>>> On second thought, it might not be such a good idea.  There are *lots*
>>> of variables that control the operation of each command, and it's hard
>>> to decide which ones to list and which ones to omit.  I've listed all
>>> the relevant variables for git-push, except the advice.* variables- I
>>> don't know how useful such a long list might be.
>>
>> I think listing receive.* and advice.* (and maybe even
>> remove.<name>.*) is still ok. The goal is to give users a clue.
>> They'll need to look up in config.txt anyway for explanation. If we
>> name the config keys (and groups) well then users should be able to
>> guess what those keys may be for before deciding whether to look into
>> details.
>
> Please do not label the list as "These variables affect this
> command" to give a false impression that it is the complete list if
> it isn't.
>
> Unless somebody promises to keep an up-to-date complete list there
> (or even better, come up with a mechanism to help us keep that
> promise automatically, perhaps by annotating pieces with structured
> comments in config.txt and automatically appending such a section to
> manual pages of relevant commands), that is.
>
> With a weaker phrase, e.g. "These configuration variables may be of
> interest", such a list may not hurt readers, but personally I do not
> think it adds much value to have a list of variables without even a
> single line description of what each is used for.

Okay.  Does this work?

-- 8< --
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Sun, 7 Oct 2012 17:24:36 +0530
Subject: [PATCH] Documentation/git-push: add a configuration variables
 section

The list of configuration variables that affect the operation of a git
command can often be hard to find.  As a first step, add a
"Configuration variables" section to git-push.  The intent is to
create similar sections in all manpages.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-push.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index cb97cc1..a125536 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -426,6 +426,30 @@ Commits A and B would no longer belong to a
branch with a sy
 and so would be unreachable.  As such, these commits would be removed by
 a `git gc` command on the origin repository.

+Configuration variables
+-----------------------
+
+These configuration variables may be of interest.  For more
+information see linkgit:git-config[1].
+
+branch.<name>.remote
+core.gitProxy
+http.proxy
+push.default
+receive.autogc
+receive.denyCurrentBranch
+receive.denyDeleteCurrent
+receive.denyDeletes
+receive.denyNonFastForwards
+receive.unpackLimit
+receive.updateserverinfo
+remote.<name>.mirror
+remote.<name>.proxy
+remote.<name>.push
+remote.<name>.pushurl
+remote.<name>.receivepack
+remote.<name>.url
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.7.12.1.428.g652398a.dirty
