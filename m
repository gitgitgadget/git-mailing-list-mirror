From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: Warn if LICENSE or COPYING file lacking and !clone.skiplicensecheck
Date: Sun, 22 Mar 2015 16:45:19 +0700
Message-ID: <CACsJy8DxUjfJ8DZ4g5bspeHARCVs9nwt9fC4wySUy0rtsCL++A@mail.gmail.com>
References: <E1YZTZI-0002QE-3r@rmm6prod02.runbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: dwheeler@dwheeler.com
X-From: git-owner@vger.kernel.org Sun Mar 22 10:46:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZcSJ-0007ZG-3V
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 10:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbbCVJpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 05:45:51 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33448 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbbCVJpu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 05:45:50 -0400
Received: by iecvj10 with SMTP id vj10so17470976iec.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iyUJu+IvEYvr1Grt086RnTY3jtY+k918KmkY7vCQFKE=;
        b=dJrlE07wRndTf9syPJAVtGzL9zEaM1IrzouIz+ZrrjINpryeImfJHzMpa/Fc2HLTm7
         oa8g/1y/SKQtOtFLq6+ij4UUSeXVPafJFg7rt/t7GqjrZmZEg15VKC29gNndgLrwRCKa
         XkV6aJKWVIUfMHhqY/Kt27Y63mHAW0HeIqxVZIJD3LBFUMzNQovAtmqrFU6bmGJTaFYg
         Fmty9BCtFGH7ndwGEhxlVrRq+zBQaBAPYdy8BO5oFsdR325pXXb5fNr/LOaIkQ6xLxhL
         asJ4NVtPAbDVRDQIa/XOP5LOoRERHgLtF4XsVN+3g6GUFVoKJhKgskQX1uL13yzEPQXb
         zKXw==
X-Received: by 10.107.155.131 with SMTP id d125mr160484080ioe.17.1427017549738;
 Sun, 22 Mar 2015 02:45:49 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sun, 22 Mar 2015 02:45:19 -0700 (PDT)
In-Reply-To: <E1YZTZI-0002QE-3r@rmm6prod02.runbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266057>

On Sun, Mar 22, 2015 at 7:16 AM, David A. Wheeler <dwheeler@dwheeler.com> wrote:
> Warn cloners if there is no LICENSE* or COPYING* file that makes
> the license clear.  This is a useful warning, because if there is
> no license somewhere, then local copyright laws (which forbid many uses)
> and terms of service apply - and the cloner may not be expecting that.
> Many projects accidentally omit a license, so this is common enough to note.
>
> You can disable this warning by setting "clone.skiplicensecheck" to "true".

Perhaps make this a hook and maybe install by default on new clones,
e.g. templates/hooks--post-checkout.sample?
-- 
Duy
