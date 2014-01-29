From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify support, nearly there
Date: Wed, 29 Jan 2014 15:33:24 +0700
Message-ID: <CACsJy8Bi-dFbWKOGw4C3fUXZ2p_0mc5CjhyMkL9p_F0H4V1rOg@mail.gmail.com>
References: <CACsJy8CG5QUqYOM46mOHOWDKB-A45B2-fj1uS9OtgniV+P8Ktg@mail.gmail.com>
 <20140129074435.GA21044@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 29 09:34:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8Qat-0002uv-UU
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 09:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbaA2Idz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 03:33:55 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:55100 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaA2Idz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 03:33:55 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so2296120qcx.9
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 00:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4Kc6WHFErpqXD5h2q3FF/5m9jBgOro4hdhSC1n/+1d8=;
        b=0Hf7r0LaAZQOQayRiAZ64DpJPtafOxJz6jdAjTopZOQEM4L7UylMV6CtdaFKEvMcbk
         WRkqc6DWcbNQCsPx55R6+QdZqE3Gq8paqqdyoJhblnA8Oaf8SrRhSmX15Nfg/OKzFBEy
         ysiz0w+uCfaCrGihK4GmndhiNFbA65nSHTn6OmvI2hLYN2AJVTLI2ha4s1Jg537thrub
         vpx8ApiRlSaq2RJrtjWV6/95KwQ2umG9nEavGpyQHz0R9mkb9JS3iHCnNt3VRSyjcW9d
         dXJYC3rqwhznJshTiWEHN7OF2qUHCZlplAaRG0HqsiC6jANhGFejwHPfHMPzHJuB2azz
         A33g==
X-Received: by 10.224.80.8 with SMTP id r8mr9879640qak.88.1390984434528; Wed,
 29 Jan 2014 00:33:54 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Wed, 29 Jan 2014 00:33:24 -0800 (PST)
In-Reply-To: <20140129074435.GA21044@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241202>

On Wed, Jan 29, 2014 at 2:44 PM, Mike Hommey <mh@glandium.org> wrote:
> Haven't looked at the code, so I don't know if you've done that, but in
> case you haven't, it would be nice to have an environment variable or a
> config option to make git use the file-watcher *and* normal lstat
> operations, to check consistency.

No I haven't. So far I depend on my manual tests and the test suite to
check for consistency. Will do.
-- 
Duy
