From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: gitk doesn't work w/o sudo.
Date: Tue, 20 Jan 2009 18:00:49 +0000
Message-ID: <3f4fd2640901201000h3ce33fd8i1a82487c9f6b0927@mail.gmail.com>
References: <c94f8e120901190216x246589ebwc4a44dd85bb655d2@mail.gmail.com>
	 <3f4fd2640901190359w39ded50ds246903808e94246c@mail.gmail.com>
	 <c94f8e120901190637i294d379dke3a07a90da5076f8@mail.gmail.com>
	 <200901200912.14432.brian.foster@innova-card.com>
	 <c94f8e120901200851n21c6d67r3c43e3efd435e3db@mail.gmail.com>
	 <vpq4oztgaz8.fsf@bauges.imag.fr>
	 <c94f8e120901200935t75dba11fw3ce14b4ba965c878@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Brian Foster <brian.foster@innova-card.com>,
	git list <git@vger.kernel.org>
To: Dilip M <dilipm79@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 19:02:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPKvZ-000223-AZ
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 19:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbZATSAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2009 13:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbZATSAw
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 13:00:52 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:38283 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbZATSAv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 13:00:51 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3894168wfd.4
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 10:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PDQZ924V24W8THvBF4vZTbFy7n0n6Q2Wxhk39DESFpU=;
        b=N049yI72jZ1ZwEn/vJNRuOXpKoaeMqvr0+LuW7n7uZ7EUR5eXcxWXV+WBXviStf+XK
         VfeShjvm4sdLl8s3UllZb7sTOPrGQbpGuLz7DE0zFzV/SZq8VfB3kOT0K1F6mdLAWvEh
         MaHfPfcyc42AC2pRx/q2iJVYAYQ6FCzYNp038=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VQGmiW0GP/ROSvBGA/6VsDT9ois5dpHukyJVyV+Q5orkkLbriHrNjI98gNWIJAEz+z
         b3Ob65kiEBkToO70JzkiRCp4Jgvj2BqvkE29SvBrex2AnTjtCxsJsNw5kx7bDUFI4A3W
         WHx5wHIR2/HYBK8rYm4qv7Hiy6pXY1uU7c18E=
Received: by 10.142.125.4 with SMTP id x4mr2622099wfc.233.1232474449449; Tue, 
	20 Jan 2009 10:00:49 -0800 (PST)
In-Reply-To: <c94f8e120901200935t75dba11fw3ce14b4ba965c878@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106505>

2009/1/20 Dilip M <dilipm79@gmail.com>:
> On Tue, Jan 20, 2009 at 10:40 PM, Matthieu Moy <Matthieu.Moy@imag.fr>=
 wrote:
>> "Dilip M" <dilipm79@gmail.com> writes:
>>
>>>>  repeating Reece's question, what is the permissions/owner
>>>>  _of_the_directory_which_contains_ the '.git/' directory?
>>>>  I can reproduce this behaviour (git 1.6.0.4) simply by
>>>>  denying myself search (n=E9e execute) permission on that
>>>>  directory, for entirely obvious reasons.
>>>
>>> It's the same issue....
>>
>> You didn't answer the question.
>
> Sorry..I read it for .git directory...
>
> .git's parent directory is owned by user who us issuing gitk command
> and permisssion bit of 755 is set.
>
>>> Any ENV variable I can set to debug this...?
>>
>> GIT_TRACE can help.
>
> I tried with that but it didn't help for gitk. But sure, it helps wit=
h
> git command(s).

So can you run git commands that modify the git tree, e.g. git add? If
these are failing, that may explain why gitk is failing, and you can
use GIT_TRACE.

Also, do you know what commands are being executed by gitk that are
causing the failure you are experiencing?

Or... is your ENV (e.g. your PATH) the same for dm and root? In
particular, can they find the git commands? This would also be visible
by not being able to do things like `git log` (or, if it is an issue
with the deprecation of the `git-foo`-style command invocation, is the
GIT_EXEC_PATH set to point to the correct location and does dm have
the rights to execute it -- that is, is the x bit set for the
GIT_EXEC_PATH directory, as per
http://www.digizenstudio.com/blog/2008/11/09/weird-git-gui-startup-prob=
lem/?).

What error message are you getting from gitk? Is it possible to debug
gitk to find out what command is being executed and what error
code/exception it is returning/throwing?

- Reece
