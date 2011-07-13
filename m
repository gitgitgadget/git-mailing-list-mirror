From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/3] doc/remote-helpers: document the gitdir feature
Date: Wed, 13 Jul 2011 14:04:24 +0200
Message-ID: <CAGdFq_igyPMfhhKb-3v5Vnob-DQ9GLR0ONLEc+xjgTwZ1R1sRg@mail.gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com> <1310483428-29833-4-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 14:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgyBl-0005Fj-EY
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 14:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281Ab1GMMFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 08:05:06 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37848 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab1GMMFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 08:05:05 -0400
Received: by pvg12 with SMTP id 12so4646233pvg.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4h3cLlrU1TK8D8S0VukG+8EVKN6Qb77Fpt4/xdIKYig=;
        b=WxJS90Tj1CshRyZAnm356gNX9/D/B1L8MLIX7ONt9OHOQq77M17eJ+8MjhKHW9xCHY
         aorcpsDIVC3aff3SZqDbNkbJpWPfRCbIDYxBYeAEeawTYr6NNBtv8SyxYQcucq7MCFhn
         nAIHA96La5w2rbHupldWP0XGAe4h4Te1vlmtc=
Received: by 10.68.12.225 with SMTP id b1mr1315537pbc.116.1310558704403; Wed,
 13 Jul 2011 05:05:04 -0700 (PDT)
Received: by 10.68.49.39 with HTTP; Wed, 13 Jul 2011 05:04:24 -0700 (PDT)
In-Reply-To: <1310483428-29833-4-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177023>

Heya,

On Tue, Jul 12, 2011 at 17:10, Dmitry Ivankov <divanorama@gmail.com> wrote:
> The gitdir capability is recognized by git and can be used to tell
> the helper where the .git directory is. But it is not mentioned in
> the documentation.
>
> Document the gitdir feature. Upon reading this capability
> transport-helper sends out "gitdir path_to_dot_git" command to the
> helper. Which looks exactly like sending a command. So let's call
> this a command.

Johannes suggested that we should remove this feature and instead
always export an GITDIR environmental variable. I'm inclined to agree.

-- 
Cheers,

Sverre Rabbelier
