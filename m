From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 18:56:17 +0530
Message-ID: <CALkWK0kx7NwzsC1-2JYwxjykMkCwz8RZ=y3LqjkQWB6tuOWNtA@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <20130727121406.GB4940@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 15:27:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V34Wj-0006eA-9d
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 15:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586Ab3G0N07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 09:26:59 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:41856 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab3G0N06 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 09:26:58 -0400
Received: by mail-oa0-f52.google.com with SMTP id g12so9602579oah.39
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D/d9ir8Vu7ki/ayquogDD1kgPWjruFmhb5QsqZfRo2I=;
        b=lHrOhETlX2SdehxoVEWXbxQtvyNkD2DU1fVTPR7vVVBH6iCx1NMOv1+WevbCife/V1
         G+zTz/5HFw2EpOLMnWaZxFHsBKqMGz8VNrKXTVhyqm7wTvL5lwTGWGaWFZ4Jf/nhahaI
         2ePuGOJkwvoGNWSMrdYkYuW7mSO0TS815pzx6zFVXeTS3av2Uc4SmXsgZ7qRAczxhfyp
         PnnES9UJDtoCAtCkWZlOhxHPurUfMKGQ1wrWVKAEzAIPEE2SAXtg7vr+TKMDBoqB/ICP
         9GsiKZmHVy/IvWVY4JW+gUJrvTFjCjfZL523YiUKpjvEHIdtB5ByvDaeRkm2TZfVBEhF
         s+eQ==
X-Received: by 10.50.138.167 with SMTP id qr7mr884652igb.0.1374931618275; Sat,
 27 Jul 2013 06:26:58 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 27 Jul 2013 06:26:17 -0700 (PDT)
In-Reply-To: <20130727121406.GB4940@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231244>

Fredrik Gustafsson wrote:
> When I hear submodules

The only reason this bug has something to do with submodules is
because of the relative path in the gitfile (although I'm yet to
corner the exact issue).  Otherwise, it doesn't exercise any new code
in submodule.c/ git-submodule.sh.
