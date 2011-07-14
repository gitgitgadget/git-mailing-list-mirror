From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How to force git to use authentication as author
Date: Thu, 14 Jul 2011 12:38:59 +0200
Message-ID: <CACBZZX4X8qRBXqwi70kZ0eZ+mb7rdD6p36xD=GoX6soha0TZcg@mail.gmail.com>
References: <20110714160638.065b6542@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Thu Jul 14 12:39:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhJJy-00039u-AP
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 12:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab1GNKjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 06:39:00 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:57964 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab1GNKjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 06:39:00 -0400
Received: by fxd18 with SMTP id 18so950687fxd.11
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+wk67Rqzefk6UrefP+IK5A7ptYt1frHfTkWlWWIJDhc=;
        b=K9L71qEzK9iDRsVFD2xx+M03Vxbm1Yd1BvLpe2Ud/TMRRVrz2VXTKIif9a9JORvkII
         W7sYMnmBYl6oxSClEwHI0AXd0lyhV1kWQHNEDErCEmfsapLwOy+NOAoxhfnPvFBxo2vf
         qDjcKjkA5TH2u2UgvJUExkHICJM7nXJJ1ks4M=
Received: by 10.223.5.212 with SMTP id 20mr3380206faw.40.1310639939050; Thu,
 14 Jul 2011 03:38:59 -0700 (PDT)
Received: by 10.223.123.78 with HTTP; Thu, 14 Jul 2011 03:38:59 -0700 (PDT)
In-Reply-To: <20110714160638.065b6542@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177108>

On Thu, Jul 14, 2011 at 12:36, J. Bakshi <joydeep@infoservices.in> wrote:

> How can I force git to use the username as define at /home/git/PASSWD as the author name for git commit ?

Edit the global bashrc to have:

    export GIT_AUTHOR_NAME=$(cat ~/PASSWD)

?
