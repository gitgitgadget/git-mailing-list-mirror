From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Lift --stdout restriction for using reachability bitmap in pack-objects?
Date: Tue, 17 Feb 2015 17:36:30 +0700
Message-ID: <CACsJy8C=MC2xVbkXE-RBcLtcn0yEX4iqBLjgOw+M0iK5n-Kyhw@mail.gmail.com>
References: <CACsJy8AC5ZcsB2_qS4k-+6fJt2_e7m=o8C9UAEcywh=P_4HXAw@mail.gmail.com>
 <20150217101344.GA5343@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Vicent Marti <tanoku@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:37:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNfWe-0002FT-0J
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 11:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbbBQKhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 05:37:01 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:40785 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756679AbbBQKhB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 05:37:01 -0500
Received: by iebtr6 with SMTP id tr6so29327744ieb.7
        for <git@vger.kernel.org>; Tue, 17 Feb 2015 02:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QHioBC0QvsySOSrI8iYP4HfiXql6emDxYmFIiepLoms=;
        b=djDc69gYiT+HSWbeRAAZbvhcTDTN0dfNGUHYLwUYz7NGLpVfLHiz6dCrFkteJyFK8+
         Wx4ZjdrZLUugIN0+0GZZk0EXJGPHV9nWMqmUih54ChemojINMmF/D2EdLqQ7cTwM+NwJ
         wqwMWMY42ENsjN8iPgMV+uP8JJ+jUJgd6PEgj4LJEpgcD5PXAp8k1IqhEyS+TvlYC9td
         UNznf1ZHqFvCfTsHPgPNtWSKdWwOAWOGNse0WEcaeaJKIls/vH0jtAbmH3AK9VCyUdHm
         0x2fDBu+Wgz6dqa8OR0D3E3JAK1tyCYVmT/c2zRSDKXUeG0Qz4MR2LKy6lDauBdvLC5g
         xNZQ==
X-Received: by 10.50.79.161 with SMTP id k1mr26928060igx.14.1424169420449;
 Tue, 17 Feb 2015 02:37:00 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Tue, 17 Feb 2015 02:36:30 -0800 (PST)
In-Reply-To: <20150217101344.GA5343@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263942>

On Tue, Feb 17, 2015 at 5:13 PM, Jeff King <peff@peff.net> wrote:
> If the only reason is for gdb, then perhaps:
>
>   set args pack-objects --stdout </dev/null >/dev/null
>
> in gdb would help?

Right. I used "gdb --args command >/dev/null" instead. Stupid
question. Sorry for the noise.
-- 
Duy
