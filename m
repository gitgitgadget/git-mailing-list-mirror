From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git interactive rebase bug?
Date: Mon, 5 Oct 2015 21:34:43 -0700
Message-ID: <CA+P7+xq8V0tNXsRaKYDQ34CWLTUpq9kGbArJc0OgxSSkPzjy-w@mail.gmail.com>
References: <CA+P7+xqMFFtVPnZ7Pw9B9oYXHe5N=Ectyd-M+_aGb2NKjRvLAg@mail.gmail.com>
 <CA+P7+xomv59bevbAMV=NYwo+UtY29OqVog3nDFUG8Jp1YbLYpw@mail.gmail.com> <xmqqsi5ox6ih.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 06:35:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjJy2-0001y9-Du
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 06:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbJFEfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 00:35:04 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35856 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbbJFEfD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 00:35:03 -0400
Received: by ioii196 with SMTP id i196so208772112ioi.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O3kt8Rphhq65k8SmxbodxJRE7Yi6hv2CrSbY73pZyAo=;
        b=yFlRvlNrSl8Fg6u3uWzkmW2L8VcB3WmM+MFESeAm2VLb1ukfP50k+LAKywR3StnAqD
         ODwX4C0Sb0VDu+zxO6Zzf5Z+ooQTEX4pjJRpQgA0d54fH3wx0VGSRl3FlrKuiZY2D6rP
         ZMyeNGWLcdhuY61kb7GS1XQ1+hq/BOBr0kENQfNLvS8hjYZgwwNjo8kW58UIsEMrHiER
         m3SHWHuTS4h6zqwjdgXvobHLq+cheA+CRIwaLbD5qprI3hy/T5Ruv9H1WWpWM9bTAro/
         llLD+P1GQv9AKzh8rDcgpgOcwhK6gMTXq2a9ueK5VFwwxl2ZtEjw3Pe1/CjEMXUZiyIR
         h1eQ==
X-Received: by 10.107.133.151 with SMTP id p23mr40262321ioi.71.1444106102522;
 Mon, 05 Oct 2015 21:35:02 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 5 Oct 2015 21:34:43 -0700 (PDT)
In-Reply-To: <xmqqsi5ox6ih.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279117>

On Mon, Oct 5, 2015 at 4:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Platform, editor, terminal emulator, specifics?
>

I run ssh to a tmux terminal emulator and run vim, I normally see this
when my local client is a windows machine running putty. After I close
the editor it just hangs. and I have to Ctrl-C to get it to go. I
suppose it could be an issue with vim or similar.

I never noticed the problem with the same setup when I wasn't using
the next branch. Tomorrow I will have some time to try out the 2.5.x
tag and maybe see if I can bisect if it doesn't have an issue. I can
try 3-4 rebase interactive attempts it usually shows up pretty fast.
What bothers me is that it's not 100% reproducible.

I'll follow up with more detail tomorrow.

Regards,
Jake
