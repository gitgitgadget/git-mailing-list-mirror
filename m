From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Wed, 24 Jun 2015 17:18:34 +0700
Message-ID: <CACsJy8CZqpAARwYpj6g7fR-qiKcV6UeWZaei5Yqh-0oSV8DW6Q@mail.gmail.com>
References: <1435020656.28466.8.camel@twopensource.com> <20150623114716.GC12518@peff.net>
 <CAJo=hJsu2b0kmpjOhGwvgRsG3yGK56+U_2RANDi2qoEg7V_PmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 12:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7hlv-0008CS-F1
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 12:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbFXKTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 06:19:06 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36129 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbbFXKTE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 06:19:04 -0400
Received: by igbiq7 with SMTP id iq7so94081957igb.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=o2l4ofPw5jqImAkQkh7v1QMeBuLNry4szVkc8BNunhI=;
        b=dYtXz69EiFnXqXqQHjeFbcyeRrdwPUc+xEAz7ggywAH/fzfeqPn3PggnVRW9/cdBMk
         /oOXiQZ9UCDRlCPmB9AWfD043CSNVHwzorf9cTq0rawZouKZvqfaQlQOghDjPVN7gLd8
         6zAaGJCbRaXO8Vg5t4UZKmBM16ATg5SRORIlWInqpAOstNmceGqFi/BBMpTqiGindYEm
         NxrDOWJu8ydNGnrhrlwd1cIQapa8Nmz4VEdnstSkjsGcSyIfedXxIfcUYwz9eOBPBt31
         /Uo0XM25Xad92k2jslw521VXOj+woIMCKKgwt+aCovb1qZxQ/scfIcMNNjHzeJaUT4TI
         o72A==
X-Received: by 10.107.128.72 with SMTP id b69mr34526589iod.84.1435141143649;
 Wed, 24 Jun 2015 03:19:03 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 24 Jun 2015 03:18:34 -0700 (PDT)
In-Reply-To: <CAJo=hJsu2b0kmpjOhGwvgRsG3yGK56+U_2RANDi2qoEg7V_PmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272545>

On Wed, Jun 24, 2015 at 1:09 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>> I chose to use LMDB for the database.  LMDB has a few features that make
>>> it suitable for usage in git:
>>
>> One of the complaints that Shawn had about sqlite is that there is no
>> native Java implementation, which makes it hard for JGit to ship a
>> compatible backend. I suspect the same is true for LMDB, but it is
>> probably a lot simpler than sqlite (so reimplementation might be
>> possible).
>
> Yes. Whatever the default standard format is for git-core, we need
> that format to be easily supportable from JGit. Loading code via JNI
> is not "easily supportable".

I'm under the impression that this will be opt-in, not completely
replacing fs-based ref backend. Anyway, any recommendation about
database format or engine that is more friendly to Java and JGit (and
preferably has good C support too)?
-- 
Duy
