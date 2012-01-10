From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [linux.conf.au] VCS Interoperability
Date: Tue, 10 Jan 2012 14:18:17 +0530
Message-ID: <CALkWK0kMmDMZ4wiMSmOfwBLzd+xBEA+WKsviu9FVcvj9eZEahg@mail.gmail.com>
References: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 09:48:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkXNt-0004gZ-HW
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 09:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab2AJIsk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 03:48:40 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:44112 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab2AJIsj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 03:48:39 -0500
Received: by wibhm6 with SMTP id hm6so3198894wib.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 00:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nj1OYPATFRSUan+L0sJyHSk9K+wnzl1c3WO9mBRdnjc=;
        b=xuznclxfxuty/3ljIrAJDULCV8AzeCCVEDB/LAgJWU784eC//q6ao30Ll4aJTN9I0F
         /C+L1HBvL/9lsCB9yM8+h3bqTzzT+Y/Wpw6u5CCDOWrKyVmvxxH9EwVhdlMKCJE9clCF
         sP37YTPmV9yKe90kiCl0exRGVgGVPUjsTdnEw=
Received: by 10.180.103.2 with SMTP id fs2mr10294300wib.21.1326185318198; Tue,
 10 Jan 2012 00:48:38 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 00:48:17 -0800 (PST)
In-Reply-To: <CAFfmPPMH2643JMMZdVbOQJL7DB-DiRYQS8x0TqEaSbGmhMdBNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188228>

Hi David,

David Michael Barr wrote:
> Next week, I'll be presenting =C2=A0a summary of the past 2 years wor=
k
> on improving svn interoperability for git.
> I'm requesting feedback from anyone who cares with regard to
> what they'd like to hear about.

Nice.  As a lay person attending the conference, here are a few things
I think I'd like to hear:
- Why this project is so challenging compared to say, a git-hg bridge
or a git-darcs bridge.  What makes Subversion especially hard to deal
with?
- What is the biggest motivation for developing the svnrdump/ svnrload
combination?  Are there any other usecases for the tools?
- How has this project contributed to the development of the
fast-import infrastructure?  Can these changes be used to improve
other/ future remote helpers?
- You've spoken about exporting Subversion history to Git so far, but
what about the reverse?  Which parts of the picture are still missing?

Thanks.

-- Ram
