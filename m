From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 3 Oct 2012 13:47:23 +0530
Message-ID: <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com> <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJK9Y-00073C-8g
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 10:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772Ab2JCIRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 04:17:46 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:55980 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2JCIRp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 04:17:45 -0400
Received: by qchd3 with SMTP id d3so5338508qch.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 01:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+/watowPJv3nnmBgfvRu48cE8GDMwCxNleL8vElmbxA=;
        b=Jd8zxHtQkYCf4abJK8EBSFQlvoJWGZ2kPYdEVxEGiGHrWaoqbMxF4+JpS7mJghLJ+g
         zaUcOq4kL0eLulDLNboTWOQy79psFeAk45bHHJtp1IxJytYdHS6t3NRPVueqRR6Ih2/N
         +I9YzHKnqqCAb6iaJMatS5zq1ItwhyiVHHUKPlTlY5micw8/SzcBzVYDH3aolhUgNDf9
         NndzgsUDTvm0cfv6yGOj87EqRINwlor3G0ydavmWpHYORZn1D1my1MucCcXz1i8ZkAE7
         jjUGVKfJIIogHgtkLcS2e4hoPv8nXqBW+tAc/9k3nxL5+6rZnYeLBjtZbzu1a60nYyk2
         tAdA==
Received: by 10.229.135.193 with SMTP id o1mr502625qct.100.1349252264461; Wed,
 03 Oct 2012 01:17:44 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Wed, 3 Oct 2012 01:17:23 -0700 (PDT)
In-Reply-To: <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206870>

Hi Duy,

Nguyen Thai Ngoc Duy wrote:
> Your patch is fine. I'm just thinking whether it's a good idea to add
> a section in the end of each command's man page to list all relevant
> config keys to that command, somewhat similar to "see also" section.
> It may help finding useful config keys that otherwise hard to find.

That sounds like a good idea.  Would you like to write the first patch
(for git-push)?

Ram
