From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 10:29:11 +0700
Message-ID: <CACsJy8Ah2VH8mE7wMi0pVvUDKq3ic7AkwmCPa4oGnDSMGcD-hA@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
 <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com> <vpqh9h7f9kz.fsf@anie.imag.fr>
 <CACsJy8D-bHOLGKq0ZELcPYWpKXgct3HBF9Btp3UPw+tqGUR5Bw@mail.gmail.com> <xmqq7fi1e688.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 04:29:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWblL-0004eT-UP
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 04:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbcBSD3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 22:29:44 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34217 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030320AbcBSD3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 22:29:43 -0500
Received: by mail-lf0-f46.google.com with SMTP id j78so45643847lfb.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 19:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MOV2ZqzfNgXTpkx7X1YtcqejmGQQgOwkC43H80za130=;
        b=cBBBbt1wYepk6H4vg5VADHtLDoPlErn51AlHQxjf8PAZX+M3OyfwRtuFQsMN7vGQua
         EGtzAJQTDAypXYNNOeX6Cr7u4A+DGwF/5QXvCtUvK2kt7ZDA0hOlhDdEzBpCoxM634j9
         VkotGtpCnf5mhmtIepQIKtTDWSPKMMDrC6sapeB/7LmozFRzW6Zws/MLr5Qb/qp0PyGA
         8F59+MmXvdnRUMrLSOEQR0c45+jzw77a5AiOuJofIH4XpmexIkGalytAkaUPfBhIwbuJ
         MG0xhUt2ig359XF7japrMlxrSfKJDyzp9sD1eYxK9Mbwk8o9RconOODh0eFiIHe60ZvT
         bxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=MOV2ZqzfNgXTpkx7X1YtcqejmGQQgOwkC43H80za130=;
        b=jgPKp4I8gaP6MZa9kF1AnI1BYVb72tTqRZ/6ralBGFH0X1bc7IxaVJTZ/ohqG1s+YS
         vIxWGaemwue4Lk88uLvJHo2cpPcrHxmbBgVMtULUhvC1P7skWK2hwnbrATO09QJSuPLO
         JIwnZ20LUEwus+8dgO9W/I+HvpgsU6b/ZCn9g8tcc1hSpZ272NVeNZDJ0j+g9oYYIM0E
         wXeN8ZlzUfqMHKqkYvbAzC1maG9xjLzQVPKLrDSZaIINPn1rskWmRsp8fsmlKV1cU+Ig
         dPt5meMi8LAr6toh4ea6UYLbm18rjZpmZEJsMQ1KxE1LfVPnwW74DuA31qhKsq8XAgu6
         fb6A==
X-Gm-Message-State: AG10YORd4bQ2K5iDtLSpboCN/a1Vdws7c5EMn1zWir29QP5ZydRzA+JFJf9GuFbJkC/Axw0v506WyfzoGtOh2A==
X-Received: by 10.25.5.6 with SMTP id 6mr3724783lff.3.1455852581349; Thu, 18
 Feb 2016 19:29:41 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 18 Feb 2016 19:29:11 -0800 (PST)
In-Reply-To: <xmqq7fi1e688.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286657>

On Fri, Feb 19, 2016 at 10:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Probably too late now, anyway.. with David's multiple ref backend
>> work, we could have a third, no-dependency backend. We can use index
>> format to store refs. Then we can avoid case-sensitivity issue with
>> filesystems.
>
> I'd actually vote for a ref backend that is based on a tree object ;-)
>
>     http://thread.gmane.org/gmane.comp.version-control.git/282677

For reasonably small sets of refs I think index beats trees (remember
we have cache-tree, which basically gives us the tree behind the
scene), but when you have so many refs, hierarchical storage may be
more efficient. Either way it's nice to see a builtin, no dependency
backend besides "files".
-- 
Duy
