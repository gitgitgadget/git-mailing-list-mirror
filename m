From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 02/12] MINGW: compat/bswap.h: include stdint.h
Date: Mon, 28 Apr 2014 16:54:25 +0200
Message-ID: <CABPQNSa7TEyGSDPHD8Yf0duJZyZ13ms0k4nPgCdomc2iPW3Acg@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-3-git-send-email-marat@slonopotamus.org>
 <CABPQNSaE9ua_JM0bY8QNSThqSKHG3d7N_PV5hmnKRt93sZkVBQ@mail.gmail.com> <20140428145234.GA18918@seldon>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:55:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wemxj-0002r8-8D
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 16:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463AbaD1OzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 10:55:11 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:42027 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459AbaD1OzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 10:55:05 -0400
Received: by mail-ig0-f181.google.com with SMTP id h18so4859936igc.14
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=pK/vn/El4jn2ZxpC6TmlXQUfse1eq8myMnfbh46e9fc=;
        b=mFP/aZcly4OqMlaMJRNim0EZT0OFBnGnjXK45hGzXKEz7WUpLrXi4h/ppx6ejnNixG
         7d7rJaLWvJTpz8DnT+FxCngQjguv1d2vfJYHOx0K6g0qrZ6MeiUGojr/tMs/d0VRq5kb
         iXvzw4FFOKAkJnDE47iKZTLudaIziZtDsH2H7CcmAO6VT0/7l00FZs/UoFGS86S+Yuqw
         cQcFsiAcAuoVIh54fvNxt6ejWxMoSPUsIS/xXpeLeas1W7UKwZFBXHGebpwotg217v/4
         FyYstgojA8hJHe/IcE8UjA1Dismoj6h8kBW0vwcTY/v+bCPgSeC8bQEpa/4LlEJIMmzU
         8XLQ==
X-Received: by 10.42.162.68 with SMTP id w4mr17654167icx.50.1398696905345;
 Mon, 28 Apr 2014 07:55:05 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 07:54:25 -0700 (PDT)
In-Reply-To: <20140428145234.GA18918@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247347>

On Mon, Apr 28, 2014 at 4:52 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> On Mon, Apr 28, 2014 at 04:45:43PM +0200, Erik Faye-Lund wrote:
>> bswap.h is included after stdint.h from git-compat-util.h anyway...
>
> That only becomes true after PATCH 05 when talking about MinGW.
>
> Will drop this one.

Right, thanks.
