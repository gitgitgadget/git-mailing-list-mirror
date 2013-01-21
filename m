From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Mon, 21 Jan 2013 08:46:22 +0700
Message-ID: <CACsJy8AunW_qWEimNhdgzw9xzgs4T+uBZm8o51Kfur0e9pv+HA@mail.gmail.com>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <CACsJy8C4qx0P621imj5B+HdoJkow0_jaGLVDRvdCDw3YRnK98g@mail.gmail.com> <7v38xxnfv3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 02:47:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx6Ti-0002XY-Uf
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 02:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab3AUBqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 20:46:54 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:36727 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3AUBqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 20:46:53 -0500
Received: by mail-oa0-f48.google.com with SMTP id h2so5576609oag.35
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 17:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Sow4fJOgiNyedJvBI/fobWO8Q/IFFyi4jafnP+nsrzo=;
        b=GfG0UaTYPNr4a43XtC51BGTPh4s2b35DqoTNPMwwemxL3SApby/BQVzq+plT5yC3t7
         q+uAgMcARFkH5onVP2HMxFfDwuKZ5DzTgzvlu1e3xitRXXm+t+XY5+kUr/pz9SnE3R4m
         yH62Mj1c8sD1bBGLWF+Wanhql2Lp/N/h8wP9Km6J88tRfhkROdZ+or/e9yL6EWfUPfDh
         NIEktJUXCMPV+WySP1gAqXyuzyYCOrefa/X6gDYhRt8KzJo+z/uysvoRtuYpXfQj/p5y
         T5z3Bvl9w6XP7t5oKSfdG+5pNXyjUaR4M7leBrI23ZE0+tGFLK2ThAKXst7o/2rzayoD
         j8wQ==
X-Received: by 10.182.159.33 with SMTP id wz1mr12835893obb.57.1358732813082;
 Sun, 20 Jan 2013 17:46:53 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 20 Jan 2013 17:46:22 -0800 (PST)
In-Reply-To: <7v38xxnfv3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214070>

On Sun, Jan 20, 2013 at 2:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Should the client side learn how to list hidden refs too? I'm thinking
>> of an extreme case where upload-pack advertises nothing (or maybe just
>> refs/heads/master) and it's up to the client to ask for the ref
>> selection it's interested in. upload-pack may need more updates to do
>> that, I think.
>
> What you are talking about is a different goal.
>
> Look at this as a mechanism for the repository owner to control the
> clutter in what is shown to the intended audience of what s/he
> publishes in the repository.  Network bandwidth reduction of
> advertisement is a side effect of clutter reduction, and not
> necessarily the primary goal.

Probably stupid question: does gitnamespaces.txt attempt to achieve
the same? The document says smart http supports passing namespace,
nothing about git protocol so I guess we need some extension in
upload-pack (or git-daemon) for specifying namespace over git
protocol.
-- 
Duy
