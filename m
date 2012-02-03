From: Chris Lee <chris133@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Fri, 3 Feb 2012 15:35:05 -0800
Message-ID: <CA+B68xBG8c3eMg5ULUYgmZ4vTiSgvu2nEFfgTD1m0-dLhLKZhg@mail.gmail.com>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:35:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSfS-0003Qv-Qz
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230Ab2BCXfh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 18:35:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40706 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695Ab2BCXfh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 18:35:37 -0500
Received: by iacb35 with SMTP id b35so5402237iac.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 15:35:36 -0800 (PST)
Received: by 10.50.104.134 with SMTP id ge6mr238830igb.1.1328312136181; Fri,
 03 Feb 2012 15:35:36 -0800 (PST)
Received: by 10.42.76.1 with HTTP; Fri, 3 Feb 2012 15:35:05 -0800 (PST)
In-Reply-To: <CB5074CF.3AD7A%joshua.redstone@fb.com>
X-Google-Sender-Auth: MCq4nEVUsF7a0EEHAZczb_-NrFY
X-Gm-Message-State: ALoCoQnboTR7rzPNJCggLh6VpjrDk18HKPIRfvf2WGQKeB134HD//vRgeUNSRw7vl/wJJvMFFjTz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189831>

On Fri, Feb 3, 2012 at 6:20 AM, Joshua Redstone <joshua.redstone@fb.com=
> wrote:
> [snip]
>
> The git performance we observed here is too slow for our needs. =C2=A0=
So the
> question becomes, if we want to keep using git going forward, what's =
the
> best way to improve performance. =C2=A0It seems clear we'll probably =
need some
> specialized servers (e.g., to perform git-blame quickly) and maybe
> specialized file system integration to detect what files have changed=
 in a
> working tree.

Have you considered upgrading all of engineering to SSDs? 200+GB SSDs
are under $400USD nowadays.

-clee
