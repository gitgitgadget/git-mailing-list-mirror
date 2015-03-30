From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: how to make "full" copy of a repo
Date: Mon, 30 Mar 2015 22:22:07 +0700
Message-ID: <CACsJy8AN6X3oh2=yLn-szEApEMC+uQMmO6qBYbPrVNK1_d5tEQ@mail.gmail.com>
References: <1427511397.19633.52.camel@scientia.net> <20150328143152.GB9387@vps892.directvps.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin D <me@ikke.info>
X-From: git-owner@vger.kernel.org Mon Mar 30 17:23:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcbWW-0006EM-07
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 17:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbbC3PWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 11:22:39 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34793 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbbC3PWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 11:22:38 -0400
Received: by iedfl3 with SMTP id fl3so135811732ied.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vi0z8fYeSDAKmsJH57gdwgex2GWZJIjau7w2G/j3yQE=;
        b=IX7ugq9Tmbb9PAnypMEOOcWGvE98PJTRHjmS5M5a2HREx7qKehp5Tvo340vgYzTQvx
         /BhUTXUZA3rSYtO7SbHRKkr9FJUkiWhhyJa4ccRlE8Mt3aClGLs/odJUqfLyIEVLlK1l
         lgQxh3ABGvu9hUIPCvQdJwC/5b9XU8SxFTe9PQ+fni2sAwsrkCKHntnze+egpCVkzLk+
         hDy5FfX0XbC7FUPLgCJ094J8GYV1xhwHU/mtBWKFFCPab+CtR1HjjrR/Ie3zdmRUZmh0
         NB95Bo3AaLTePww42PI6tVoN9W9maBkzR4AdwXsfufVR5o+QJOM33Z8rGMl59M8YHfNh
         SHMw==
X-Received: by 10.50.79.197 with SMTP id l5mr7654799igx.39.1427728957979; Mon,
 30 Mar 2015 08:22:37 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 30 Mar 2015 08:22:07 -0700 (PDT)
In-Reply-To: <20150328143152.GB9387@vps892.directvps.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266455>

On Sat, Mar 28, 2015 at 9:31 PM, Kevin D <me@ikke.info> wrote:
> Git clone is never going to get you a copy where nothing is lost.
>
> What you are losing on clone is:
>
> * config settings (this includes the configures remotes)
> * hooks
> * reflog (history of refs, though, by default disabled for bare
>   repositories)
> * Stashes, because the reference to them is stored in the reflog
> * unreferenced objects (though you said those are not a requirement, it
>   is still something that is lost)

This is true. But I wonder if we should (and can) support
--super-mirror option (disabled by default), where reflog and stashes
are kept, for backup purposes. We might keep unreferenced objects as
well if it's not hard to do.
-- 
Duy
