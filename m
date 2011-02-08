From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] Add support for merging from upstream by default.
Date: Tue, 8 Feb 2011 16:38:07 -0500
Message-ID: <AANLkTi=rZMfUiwr9m3BogaVFWfKCy6FQaHaqKKJrEsCY@mail.gmail.com>
References: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 22:38:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmvGl-0001GG-EE
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 22:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab1BHVii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 16:38:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60732 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1BHVih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 16:38:37 -0500
Received: by iyj8 with SMTP id 8so3745570iyj.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 13:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ChVajCHrWpM5QGY4Y718HlehQPzEpHmcgNrX3IZAQjE=;
        b=q82Uk0hnJ0hiLGRZeeBSFTzHLq6ZUyEcbgJG/zNGtlnvFjhJ4VpnjxZDkhxIXRKl6N
         WcbVOVPgUvguz26JijTLT1Bt0H/SdL9MnUzMfXHp1vxaoKzmYBm3Wn4Qlcj5aqVELr04
         pSDLrSbLUAbJ501zTpKN0ATY6+3QeBuS4HpV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=g6SM4YzqurQbwKYcYsOgB+/CFmySNw02eXL4WeBHjlSJi06ZBNvzJ+pRnCIadCPQd+
         5LeHkF5jLRTbfUH3h+fHslMllAHWixo8AruDj6yNWNUez7jsczK+EB+OKWSSFgtpP1NR
         nZ++btJgZNpaFsN/tf7+OkzgEgWuHhBAXFYgA=
Received: by 10.231.192.7 with SMTP id do7mr19483045ibb.102.1297201117103;
 Tue, 08 Feb 2011 13:38:37 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Tue, 8 Feb 2011 13:38:07 -0800 (PST)
In-Reply-To: <1297198129-3403-1-git-send-email-jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166369>

On Tue, Feb 8, 2011 at 3:48 PM, Jared Hance <jaredhance@gmail.com> wrote:
>
> Adds the option merge.defaultupstream to add support for merging from the

Nit: I agree with Jeff[1] that this should be called merge.defaultToUpstream

[1] http://article.gmane.org/gmane.comp.version-control.git/165745

j.
