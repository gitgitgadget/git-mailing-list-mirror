From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git with large files...
Date: Sat, 21 Jul 2012 10:42:33 -0400
Message-ID: <CACPiFCLTPi5i3RZHwOD-+OJ_zSbtOwe7VLy=NMO1MUKPVyPHEw@mail.gmail.com>
References: <A18A933F-5627-4844-A4A6-B3AF244FD211@me.com> <86fw8mf3gp.fsf@red.stonehenge.com>
 <CACPiFC+a=46n-igTUBSDdpgDQyL4cz5vrcpurNBSsb+D1c0UnA@mail.gmail.com>
 <CAJDDKr5vZz_DepYKvdu34G60fmm8V_Sv8FU+J6O-DLoum07+jA@mail.gmail.com> <CA+EOSBk8XjA5=BO_kVOmfCPT-n2vKV1rbqUHnOnGi-ORF7wKLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Darek Bridges <darek.bridges@me.com>, git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 16:43:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsatW-0000B4-Vc
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 16:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325Ab2GUOmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 10:42:54 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60638 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab2GUOmy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 10:42:54 -0400
Received: by vbbff1 with SMTP id ff1so3656467vbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OzLG+QiJ0BRLPVjvZbaIqzokVGgS1dneMNAjerPQYZ0=;
        b=wqatUIOLMtzMPxtItUVl3SiWvJZklPNB46/0NGODwk5iACyE1BqYTR+fB4/R43j0KN
         IfgxdGwH33dVh+Pp7xVX6LvHa65rf1jOoupYp6zaZCsCqZNDA8lAaLrROrGdZQl4/C+D
         8gVHZIqHYUDpWP4pr7dpAJWxtX5qoTg2IT1XHbknC6LclyHnVoGy+/h4+CPr3ZK17oi3
         pOS/flGp0hbCyjOPpc9ueBDAJcRrP+gGRhKO4K0bqqswF2Hi0ncT1yeorI5kxShmKUcQ
         hOc2CL+qRChQBe7Xq+p7eFCXzDbhJqui/cdqqXdB46PXptMfHV8Z8Jo0BQZxaI6wN+fU
         +UZw==
Received: by 10.52.65.141 with SMTP id x13mr6439701vds.43.1342881773286; Sat,
 21 Jul 2012 07:42:53 -0700 (PDT)
Received: by 10.52.162.34 with HTTP; Sat, 21 Jul 2012 07:42:33 -0700 (PDT)
In-Reply-To: <CA+EOSBk8XjA5=BO_kVOmfCPT-n2vKV1rbqUHnOnGi-ORF7wKLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201809>

On Sat, Jul 21, 2012 at 3:11 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> Well, many folks use puppet in serverless configuration pushing the
> manifest from a central git server via cron and applying locally the
> configuration fetched. In this sense git IS used for deployement. And,
> for a configuration management system as puppet this could be a
> sensible thing to do - reduce load, scalability ecc.

That's a great thing to know, and timely too. I am looking at Puppet,
and worried a bit about reported memory load on the server side (and
some rumours of memory footprint issues on the client side too).

Can you point me to more information & discussion?

thanks!



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
