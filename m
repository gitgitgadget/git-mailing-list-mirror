From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 00/16] git bisect improvements
Date: Tue, 22 Mar 2016 17:05:14 +0530
Message-ID: <CAFZEwPOiUWDZKprWW4q3diUUvauc2epJHVD64qjCi_3S8KBWMQ@mail.gmail.com>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<CAFZEwPPon1q_iW_xNfmVxiQhyaQh_pZpk2jzoyzi3RjJd998pg@mail.gmail.com>
	<56F07434.8090005@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 12:35:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiKan-0000HJ-K4
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 12:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758624AbcCVLfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 07:35:16 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35946 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbcCVLfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 07:35:15 -0400
Received: by mail-yw0-f193.google.com with SMTP id p65so21181344ywb.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 04:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1u5N8NIe+p58iBpWnnEPzNXZH7x1QBk6e/unxRbBFgo=;
        b=hNtY+z5/xDW8ljh7JcPLWTrTLMGUoYKm3xexehfgcVVfgv9jSm1quGdme4aiPGBnKA
         NZPSCwNmgKn0tsSlvlu6WG7mHgbEOTahxlFX52Es8qL+xQy3Gv4eXBHe58jepJ5KXUlJ
         HJHHGXDwTGEFCDo+wipnGXt2FGQTc9llsqDmb8hU9RG5uDYu6qNmL6hQVKMDspo4OfJq
         2X3Q/oGO2r/PTxOUmjihlCpkLKmC1IXblSUDOWxX2evmXMaAQH9zAkFmNmkd7y/wJkpM
         RG281ZRJjNaoV6xCFdWr/UIYx04TcsTzNNxuF2BdA6HyyIzwGqYCIScjqAegxMh9BaVV
         P+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1u5N8NIe+p58iBpWnnEPzNXZH7x1QBk6e/unxRbBFgo=;
        b=V1SE8bqcyiXeN3xJYzLdwFonUIGX1eqmROk5GNasvjPl5IwVJ/VYtxIF8Gp5JF2LJG
         x4vvv2T6KO+dvBkVv7ss3mvJH0/au37W3m7DaBN4wwoP0hNOhXv/mB7x+0BM06P0sg2a
         iN1Ywv7nV4PmYZTteLGrcOp4ArQkf8FelNoOp/x4cE9pbHWqTcvXuU8PXxz+hROHbqdX
         9ZJrhAGOz4i0zhH5tEh55dqfO4x7f89fih9oq1TWgnjoa8mup6xI0alj5F+6Dk+VOThG
         YexvWwKwerQlVtIFMTH3uguMX0j0RJjFcwLM2s/3GItAdFzHpONzHeFZGhk4eIZgNj+J
         awZQ==
X-Gm-Message-State: AD7BkJJg5IymiSbNAhalgM9JSVd8sNVBxsBSNKhW6zI7eC5WtDcghUJwWoX1V4Q2rJkA+fy+OY3uc5ryiY3psQ==
X-Received: by 10.129.37.3 with SMTP id l3mr16024694ywl.128.1458646514866;
 Tue, 22 Mar 2016 04:35:14 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Tue, 22 Mar 2016 04:35:14 -0700 (PDT)
In-Reply-To: <56F07434.8090005@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289503>

On Tue, Mar 22, 2016 at 3:52 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>> If it is okay with you then can I work more upon these
>> patches in my GSoC project.
>
> I'm totally fine with that, of course. :)

Thanks! :)
I will try and fix the left over bug if time persists.

Regards,
Pranit Bauva
