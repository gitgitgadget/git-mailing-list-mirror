From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in
 ~/.config/git/config file
Date: Sat, 26 May 2012 02:56:49 +0530
Message-ID: <CAH-tXsC6Z21YunJwb5oYQfcmC3LMeRpNtwdLvS_P5tuB8WY=Kg@mail.gmail.com>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri May 25 23:27:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY22p-0000RY-NL
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 23:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab2EYV1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 17:27:31 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35186 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab2EYV1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 17:27:31 -0400
Received: by wibhn6 with SMTP id hn6so1305496wib.1
        for <git@vger.kernel.org>; Fri, 25 May 2012 14:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j0s3Aq9U/YGb+WZICKCSClaMIKerl+s5qZzAZmvrmBw=;
        b=IroR374qJB5ogPgVbL8WPENyob23PNJ4jZeiRoejmqqEVmI1WOKkuTDaNBQcBAVKUL
         lFu9Uqrkpm62In3NBS5GVPn8qSqunbAYJkNRJUTN+QUwBG295YGiS+K+/AJN3mR03ORL
         BrSXX3VrnVSby1ik6MPihpxQv5sGgdrKRTkcJoDKFfhfbesR4OQL8n5Q355HR9kja5CH
         5D1mRNxWxvz1NkRrttJTwfix4OI/1Fqrpq0NKrjmzEz5wJOz8DRwhy5Sz8muXXKg9B4P
         b7weq+SSMJhkzfrNCmW5b45DCW96sySSccIOOFYfLOeU0RE2Ie+/9lfVKrQCUWoCYD71
         Uwzg==
Received: by 10.180.80.74 with SMTP id p10mr788327wix.10.1337981249753; Fri,
 25 May 2012 14:27:29 -0700 (PDT)
Received: by 10.227.173.142 with HTTP; Fri, 25 May 2012 14:26:49 -0700 (PDT)
In-Reply-To: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198528>

On Sat, May 26, 2012 at 1:17 AM, NGUYEN Huynh Khoi Nguyen
<nguyenhu@ensimag.imag.fr> wrote:
> git will store its configuration in ~/.config/git/config file if this file
> exists and ~/.gitconfig file doesn't, otherwise git store its configuration
> in ~/.gitconfig as usual


If a new config file gets introduced at `~/.config/git/config`, what
will be the new order of config file precedence?

`/etc/gitconfig` > `~/.gitconfig` > `~/.config/git/config`  > `.git/config` or
`/etc/gitconfig` >  `~/.config/git/config` > `~/.gitconfig` > `.git/config` ?

What will be the new flag to access it? I mean anything new like
--system / --global going to be introduced?

-- 
Jaseem Abid
http://jaseemabid.github.com
