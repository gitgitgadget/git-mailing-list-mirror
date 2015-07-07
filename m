From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Git force push fails after a rejected push (unpack failed)?
Date: Tue, 7 Jul 2015 19:05:11 -0400
Message-ID: <CAPig+cTMqjrM=EQFaTU+9OcC=-bSPLXoMR-NEH9Q-w782KiSmA@mail.gmail.com>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
	<20150707141305.GA629@peff.net>
	<DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
	<20150707194956.GA13792@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: X H <music_is_live_lg@hotmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 01:05:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCbvR-0003wy-Dv
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 01:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122AbbGGXFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 19:05:14 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35938 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbbGGXFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 19:05:12 -0400
Received: by ykdr198 with SMTP id r198so192012739ykd.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/NXPicVRap4vEz8kUJGvIGp5x7fB/VMl2h4h6vkeUgI=;
        b=H8KUwFxBDQAMwBWaWS8QLLYU7xt5xvOS8Z5xRKFnumnUtdY4ji699Z6Ny9of4sCBP9
         JF5AQUBFXknXYntqDEMx6Yr6HUZV+jbnt6hXgAGRXcyC6osGojQjkNExEHH5IGYu7UqF
         W/SiOn3qC1KmAJ974UpHx/XBqmbmyNFrcHt81JrL13DgsceDOQwbO66+qpexipf3h97u
         tV7aMuA2FxzAEWRCGhOshKeXlJBRkRaJDfAQG04FfG/wWVJK1rbv3gxmwp8djdYsMp/H
         WNa8//+li7ll/aiDJQj1GvAs4BShErVfCQN2nmhsYtB/9aClCDJlqL8xqLaS6WdsQuG1
         6VBg==
X-Received: by 10.129.91.135 with SMTP id p129mr8043082ywb.95.1436310311197;
 Tue, 07 Jul 2015 16:05:11 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 7 Jul 2015 16:05:11 -0700 (PDT)
In-Reply-To: <20150707194956.GA13792@peff.net>
X-Google-Sender-Auth: hd7J_1LVVDYxmIEit3zaOO6Imq0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273616>

On Tue, Jul 7, 2015 at 3:49 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 07, 2015 at 09:31:25PM +0200, X H wrote:
>
>> For the moment, I'm the only one pushing to the remote, always with
>> the same user (second user is planned). I use git-for-windows which is
>> based on MSYS2. I have mounted the network share with noacl option so
>> permissions should be handled by the Windows share. I'm in a group
>> which has read/write access. I have not configured
>> core.sharedrepository, I don't think it is useful with noacl since
>> unix group are not used in this case. The permission for the folder
>> above the file with permission denied is rw, but this file is read
>> only so if git try to modify it it won't work.
>
> Ah, so this is not a push to a server, but to a share mounted on the
> local box?
>
> That is leaving my realm of expertise. I'm not sure if it could be a
> misconfiguration in your share setup, or that git is trying to do
> something that would work on a Unix machine, but not on a Windows share.
> You might want to ask on the msysgit list:
>
>   https://groups.google.com/forum/#!forum/msysgit

Is this possibly another case of Windows virus scanner interference?
That could account for its variable nature.
