From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Feature request: Config option for
 --no-ignore-removal/--ignore-removal
Date: Wed, 16 Oct 2013 19:31:58 -0500
Message-ID: <525f2ffe6790b_43dcf8be8485@nysa.notmuch>
References: <1380081691.7963.4.camel@localhost>
 <xmqqli1s6gly.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthew Cline <matt@nightrealms.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 02:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWbcM-00062Z-QN
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 02:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761339Ab3JQAjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 20:39:06 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:61510 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760618Ab3JQAjF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 20:39:05 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so1301295obc.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Ie6bvIY6p27TUceDChsoz9HOOBiE+8u+7LJMqvPxhi4=;
        b=Xkk/HmzXQIMlfyPYIVc+znI8w3+mbLBYcCZ4+PHAMr1b1HnM36QrJXYAAblFs/Ursd
         0s8yqL6MNVQdd3BawnvGJ+KC1LbTj9MGe4203gwUsJW7EjbrFmGE8Rfy1B5Pb+5l2L+2
         /4+SsNwkgukGg94cUSqUHWphSt2eCGLWDmk4/xkBMDWDiynYK/Jl5y/QJJZPrZaggsLI
         GioHXn2imvcPaAxKm4FhmSFHjTs+6bgyFv61wigKVBbDYOzv6MtQ1r0P09oxSlcVqOFv
         hjlTKl+Kyj0U7BCWQTTn7JnI5xg9NQcaw4oi0OKCOa9fhPT8mE2UDryhxoSl+d/nGZFc
         W5mA==
X-Received: by 10.182.113.195 with SMTP id ja3mr8122015obb.46.1381970344349;
        Wed, 16 Oct 2013 17:39:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm68235046obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 17:39:03 -0700 (PDT)
In-Reply-To: <xmqqli1s6gly.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236285>

Junio C Hamano wrote:
> Matthew Cline <matt@nightrealms.com> writes:
> 
> > When I try to a plain old "git add ." when files have been
> > deleted/moved, I get the warning
> >
> >> You ran 'git add' with neither '-A (--all)' or '--ignore-removal'
> >
> > There should be some way to put something in ~/.gitconfig to tell git to
> > always choose one or another.
> 
> The lack of configurability is very much deliberate.
> 
> Adding such knobs that make basic behaviour of Git different
> depending on the per-user setting will make it unnecessarily harder
> to run to help your coworker when she is having problems.  "git add
> directory" you type in her terminal during the session to help her
> could work differently from the way you are used to, if we added
> such a knob.

That's going to happen regardless. You are assuming she is running Git v2.0,
which she might not.

-- 
Felipe Contreras
