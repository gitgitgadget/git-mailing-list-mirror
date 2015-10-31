From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH] checkout: refactor of --progress option
Date: Sat, 31 Oct 2015 11:13:18 -0600
Message-ID: <CAOc6etb+Fom9t=2R=opR-fKYDkR1X6FFA=OGyQqo8HWycgqUVw@mail.gmail.com>
References: <1446310669-9790-1-git-send-email-eantoranz@gmail.com>
	<CAOc6etasvk6f0XhJumwXtYiC7h_ufQUAyN1BktQ=qdd4_f0hSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:13:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsZiU-0007fl-VC
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbbJaRNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:13:19 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36566 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbJaRNS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:13:18 -0400
Received: by pacfv9 with SMTP id fv9so108261888pac.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mjZK8XwpN5u7SAz9VirsqDRSrrx1SjPY9XgzvoTB67c=;
        b=xx2K8j67bvmFaMKNGR6qHiAGodDE+rD27TTpLAwyr7fwGE/RC+wBnMkYPT2jjQj3eh
         d3la1ZX+imh7IDvVZ/a7040EDo0j7L9BhA38Sv4reXoCRMAA70ftWVQOCvxss1fUT4q+
         eVF5KzBKlmMxoxbLiwPYrIqUsNz/piOHAE5fKaErwNId6/N3kVXMjzjho3rRhdJnMRAb
         95QqQlz1TBT0nKQY0m7OZtifx9F7rhIU4h5tZE5pMqAmvJTjYINvlhrRA0YY4ajpzgAa
         B2EpUJM5Y4d0HfCOJgpymm1w2d7a4AW0ZBrpWlknzXcukT7NfwS3bLnE9+MIwdbOm1Uo
         MGaQ==
X-Received: by 10.68.69.79 with SMTP id c15mr15872631pbu.90.1446311598422;
 Sat, 31 Oct 2015 10:13:18 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Sat, 31 Oct 2015 10:13:18 -0700 (PDT)
In-Reply-To: <CAOc6etasvk6f0XhJumwXtYiC7h_ufQUAyN1BktQ=qdd4_f0hSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280583>

On Sat, Oct 31, 2015 at 11:10 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> by the second item on the outer short-circuited if:

I meant: ...short-circuited _and operator_, sorry.
