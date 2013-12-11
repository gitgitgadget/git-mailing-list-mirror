From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Question] Git recovery with HEAD commit broken
Date: Wed, 11 Dec 2013 11:12:07 -0800
Message-ID: <20131211191207.GL2311@google.com>
References: <CAP9B-Q=ARp00Bj5zJ0J=3qv9R16YGu5AZgLpqoO0y+cY1at1Zw@mail.gmail.com>
 <vpqzjo7whwj.fsf@anie.imag.fr>
 <20131211161407.GA15939@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Shilong Wang <wangshilong1991@gmail.com>, git@vger.kernel.org,
	Wang Shilong <wangsl.fnst@cn.fujitsu.com>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Dec 11 20:12:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqpCo-0005Gn-06
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 20:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959Ab3LKTMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 14:12:15 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:57286 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3LKTMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 14:12:12 -0500
Received: by mail-yh0-f51.google.com with SMTP id c41so5382557yho.38
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 11:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eX0ylwffzZr09FiPHXQQXLVAbAWfpopSRrTTMwAEQN8=;
        b=Mv+cEJaOuEyJFq/yJASn8AsE+old7C7ehyW+ge+ARf/omrynGiSXog3fdcf/MOQX0h
         SfpYUrQKLfd2uiO0UiahZ/NSjlN95dB//zgz1EnpxWU79cY4mR8Fp/KZwwF0TZI3M5OK
         ALMheHHNqb5d21VYXZ0+uNPfjTZLYt89Vp4f8BHprAyDAduD9hCMmEsGI3C2ZUJZ+xRd
         n2R21+TvZ355yBR6oEcbFIFzaMhS11I0bH64O9VIyJSSulZMihHYMRnto1LyCEQbIkGz
         yriroFN1EyK5HLGQmViOkx44MaHXu6RDSH2EqgUiXD+YSIShtw/ftREI97b+yrFcynX8
         NWmA==
X-Received: by 10.236.62.194 with SMTP id y42mr2672658yhc.54.1386789131152;
        Wed, 11 Dec 2013 11:12:11 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 9sm29729698yhe.21.2013.12.11.11.12.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 11 Dec 2013 11:12:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131211161407.GA15939@kitenet.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239209>

Joey Hess wrote:

> [2] A particularly annoying one is that git branch -d cannot be used
>     to remove a branch that is directly pointing to a corrupted commit!

It's generally considered okay for everyday commands like "git branch -d"
not to cope well with corrupted repositories, but we try to keep
plumbing like "git update-ref -d" working to give people a way out.
Is update-ref -d broken in this situation, too?

Curious,
Jonathan
