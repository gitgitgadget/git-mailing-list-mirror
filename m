From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Sat, 7 Sep 2013 14:26:17 +0200
Message-ID: <CAHGBnuMmm=tHdpcBpcY6Vro-un3g2JR1N6C=J-jSX8f-1b0UOw@mail.gmail.com>
References: <522A36AA.3050701@gmail.com>
	<4065B5CE-7E81-41F3-B9DE-FDA05C43AAB0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 14:26:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIHay-0001SU-8g
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 14:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881Ab3IGM0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 08:26:20 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:42983 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab3IGM0T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 08:26:19 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so3696371lbh.37
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f96WLFrJOa/BOnj7/rzfjyWYLwVvwAOxgqQ5VszVP5w=;
        b=QYX82T/3D+Blbf7wopETrkZYBuUVq070l5KaFuuhZQ+u+5ABZLdRDRhT5rz6wPW5hn
         s3aVBitQ5cXnS/0zQzgfIbV74pO95qvabii6OxbslGN6O0Fh5V/+KlXtGDWyrBQHiuhB
         0bvCq6j78HkDQKsw7kFmWq/tNBkP0H27EBRX5u1VlfXs52TfyJ+fArwNk3ZZKZBBPtmP
         zl1TS0h55nvBI7/eOgP5GlcArOY9g76U+aVplJAV2CNoPO5mF+oLloDlvhOjifDTnURG
         tjSJUeUZKOnTUuWvXUUoN9j4CxnGjspKtiuvU6dxMoZQTz1xxeS41ZpxOE/ymoxHb8IW
         //GQ==
X-Received: by 10.112.167.230 with SMTP id zr6mr8591lbb.35.1378556777864; Sat,
 07 Sep 2013 05:26:17 -0700 (PDT)
Received: by 10.114.5.161 with HTTP; Sat, 7 Sep 2013 05:26:17 -0700 (PDT)
In-Reply-To: <4065B5CE-7E81-41F3-B9DE-FDA05C43AAB0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234132>

On Sat, Sep 7, 2013 at 12:34 AM, Kyle J. McKay <mackyle@gmail.com> wrote:

>> For custom builds of Git it sometimes is inconvenient to annotate tags
>> because there simply is nothing to say, so do not require an annotation.
>
> It's not that hard to add -m "" to the command line:

It's not hard to type those characters, but (for me) it's hard to
remember that I have to do it.

> if you're just trying to avoid the editor or thinking up a message.  Is `-m
> ""` really that inconvenient?

Yes, to me it's inconvenient, but not that much. And I think passing
an empty annotation like you suggest is even worse than not setting an
annotation at all, because I would assume if an annotation is set it's
not empty, and if it is, I would expect this to be a user error.

-- 
Sebastian Schuberth
