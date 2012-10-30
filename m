From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 0/3] completion: refactor and zsh wrapper
Date: Tue, 30 Oct 2012 17:15:34 +0100
Message-ID: <CAMP44s1swF2COvt6miVOWpZ7h1Av3GUgAT5ei1XXuGELXtFvCw@mail.gmail.com>
References: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 17:16:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTEU0-0005ic-5r
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 17:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759921Ab2J3QPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 12:15:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59072 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759901Ab2J3QPj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 12:15:39 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so422634obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4mpsYLMNPo3+HZn68p4IOlU3PUwW8V01FCWYNixql80=;
        b=mWItfF83BMynQq05dGiX+pXItnxqC7uSWNRVJ0A9GgyodSFJ8bvLnP4xmm19QUckRO
         KTc3dVHqluqyNfEapSV7ayvu5LJGKa6eDGOXxe5azjTKuZFJXNAr35P/qEOTgzn36tVI
         TSLpJPKWzsHBKq1vQXJG7/bbqCJiQJ99EYeLc/IfUh6p4cHiT+0FN7g9wefsBd1Q2I+9
         uXJpp9ZH8pUU2hSD5Zqc77o9ZVziSr5rQvMJD6xEgIedNl3G1IKbIm+sD7J72zzd2QQ6
         LKLYJqHiwJZxnSQELYLozMBPS/c8sodkW45/yrSzsWq+aVGcPLv4y+s/WrENgm8iBYFz
         llDg==
Received: by 10.60.31.241 with SMTP id d17mr29081359oei.107.1351613734603;
 Tue, 30 Oct 2012 09:15:34 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 09:15:34 -0700 (PDT)
In-Reply-To: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208707>

Hi,

On Mon, Oct 22, 2012 at 3:45 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Here's a bit of reorganition. I'm introducing a new __gitcompadd helper that is
> useful to wrapp all changes to COMPREPLY, but first, lets get rid of
> unnecessary assignments as SZEDER suggested.
>
> The zsh wrapper is now very very simple.

Junio, Jeff, just to let you know, this is an updated version of the
new zsh wrapper patch series with the feedback from SZEDER. I see the
old version is in pu, and hasn't been updated.

Cheers.

> Since v5:
>
>  * Get rid of unnecessary COMPREPLY assignments
>
> Felipe Contreras (3):
>   completion: get rid of empty COMPREPLY assignments
>   completion: add new __gitcompadd helper
>   completion: add new zsh completion

-- 
Felipe Contreras
