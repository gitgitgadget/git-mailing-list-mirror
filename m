From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Two janitorial patches for builtin/blame.c
Date: Tue, 21 Jan 2014 11:15:31 -0800
Message-ID: <20140121191531.GH18964@google.com>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
 <87d2jlqp7x.fsf@fencepost.gnu.org>
 <20140121165546.GE18964@google.com>
 <874n4xqlly.fsf@fencepost.gnu.org>
 <20140121174448.GG18964@google.com>
 <87zjmpp672.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 20:15:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5gnU-0001xo-LL
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 20:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbaAUTPh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jan 2014 14:15:37 -0500
Received: from mail-gg0-f169.google.com ([209.85.161.169]:64150 "EHLO
	mail-gg0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaAUTPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 14:15:36 -0500
Received: by mail-gg0-f169.google.com with SMTP id j5so2770651ggn.28
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 11:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SbE9U4l1vni2AUs3DjBESy+MD12EXaWdUIZlc+NM5S0=;
        b=YQqk8pBmLl4MNtUNN6PcOGA9T0Vj4g+8T/ujr0gwm17eVtXjLZSrNddglREwEUcvVS
         LJG93GV1vz4iXXyYfvn5O4M8idN2ZxuSFHH/fLwOZcueQrt88YaIvJDzxtUED1W6Hn6z
         hQ1fECqReMQREtE1tC9Cmw094t8t11YxhTtaqcJtPzH6KDJ5OnE6u4KF8m3ir0schphc
         1yyXhK6/iNwRhgBDFjpmfHBNOI1hf2pCSM0aZl2TyKTJns0tWNR1UyiHs+2OZEM4nNLq
         0aVZN6ofArdqpBY6IRdJEHwpcmfla47pG5+QH6RDSLvZGXXFrXek0HIqJcJa0mfCvW+I
         6veA==
X-Received: by 10.236.150.45 with SMTP id y33mr2526487yhj.124.1390331735178;
        Tue, 21 Jan 2014 11:15:35 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c44sm15776296yho.20.2014.01.21.11.15.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jan 2014 11:15:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87zjmpp672.fsf@fencepost.gnu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240763>

David Kastrup wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Any idea how this could be made more clear?  E.g., maybe we should
>> bite the bullet and add a line to all source files that don't alread=
y
>> state a license:
>>
>> 	/*
>> 	 * License: GPLv2.  See COPYING for details.
>> 	 */
>
> Probably somewhat more verbose like "This file may be distributed und=
er
> the conditions of the GPLv2.  See the file COPYING for details".
> I=A0think there are boilerplate texts for that.

All else being equal, longer is worse.

> Whatever the exact wording, that would be the cleanest way I think.  =
The
> respective Documentation/SubmittingPatches text looks like it is quot=
ed
> from somewhere else, so adapting it to the realities of files without
> clear copyright statement seems less straightforward.

Hm, the wording comes from the Linux kernel project, where it's also
pretty normal not to have a license notice in every file (and where
the default license is also GPLv2).

Is the problem the phrase "indicated in the file", or is the problem
e.g. the lack of a pointer to
https://github.com/libgit2/libgit2/blob/development/git.git-authors?

Jonathan
