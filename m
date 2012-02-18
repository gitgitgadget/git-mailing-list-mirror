From: =?ISO-8859-1?Q?Philip_J=E4genstedt?= <philip@foolip.org>
Subject: Re: [PATCH] remote: align set-branches builtin usage and documentation
Date: Sat, 18 Feb 2012 14:11:44 +0100
Message-ID: <CAKHWUkY2ZNniJmhheHdxj4dzBLtY-+Pn4teAm2WE+0eTXYMYvg@mail.gmail.com>
References: <1329563867-13283-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 14:12:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ryk5G-0006Do-GH
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 14:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab2BRNMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Feb 2012 08:12:07 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53651 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab2BRNME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2012 08:12:04 -0500
Received: by vbjk17 with SMTP id k17so2794986vbj.19
        for <git@vger.kernel.org>; Sat, 18 Feb 2012 05:12:04 -0800 (PST)
Received-SPF: pass (google.com: domain of philip@foolip.org designates 10.220.38.5 as permitted sender) client-ip=10.220.38.5;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of philip@foolip.org designates 10.220.38.5 as permitted sender) smtp.mail=philip@foolip.org
Received: from mr.google.com ([10.220.38.5])
        by 10.220.38.5 with SMTP id z5mr7377490vcd.63.1329570724205 (num_hops = 1);
        Sat, 18 Feb 2012 05:12:04 -0800 (PST)
Received: by 10.220.38.5 with SMTP id z5mr5890317vcd.63.1329570724110; Sat, 18
 Feb 2012 05:12:04 -0800 (PST)
Received: by 10.52.106.137 with HTTP; Sat, 18 Feb 2012 05:11:44 -0800 (PST)
In-Reply-To: <1329563867-13283-1-git-send-email-philip@foolip.org>
X-Gm-Message-State: ALoCoQkY6NJnAJsnbhRL8/O/NG3E7S7BQbg0vx7jtYBTlaNJ7UVLRVr/MJ9JctMTYv4x1mVjJZTu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191007>

On Sat, Feb 18, 2012 at 12:17, Philip J=E4genstedt
<philip.jagenstedt@gmail.com> wrote:

> The order of [--add] <name> <branch>... was inconsistent
> between builtin remote usage messages and git-remote.txt.

To clarify, it's the order of "git remote set-branches" that is
inconsistent with the two instances the patch touches:

usage: git remote set-branches <name> <branch>...
   or: git remote set-branches --add <name> <branch>...

--=20
Philip J=E4genstedt
