From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [FEATURE] difftool to provide meaningful names for temporary files
Date: Wed, 18 May 2011 17:54:02 -0400
Message-ID: <BANLkTimn4sYCFrLdPWOypwVNUBR5kMVqxg@mail.gmail.com>
References: <BANLkTikC6MhvEiw=7JKscN5iOPFzVGxJzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 23:54:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMoh1-0004B5-MS
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 23:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab1ERVyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 17:54:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41993 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab1ERVyD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 17:54:03 -0400
Received: by wya21 with SMTP id 21so1537105wya.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 14:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=tmHP08DpalMTZwDY0t2SzfetKvZIm1bktLEZyr9W4xo=;
        b=epyIlYN5h7XHdFMWpO5bz/MiBdMHC9uSdBLYlk2cGYlZOMM8AGavVFlhtDr0m5K3PX
         hCP0DbQSPwt/W2PudjmhdwxPGjPaXUXi2PuxzTC5+hvQ4rPbwzMNFRfdFJVbjC0rMO1C
         h0++w/UWqFFuipAQ9nwQJvw/NdSE1W60Zp2dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=v/5xonkLqyyvqdhIYWYoZ6csfeW6PX8h+HyWGOCv7UVj6kKIBmzClAKHewMo25DiFk
         DHncPi52drzJ4Gcphy+Wmjj9z/VSxYj1+NI/6vr87WW2Sp+9OqJsxqCd6DCNKsHs6tc9
         FwD5DdvNBLznZ/Wrm/cPYNJE5tbrcKwBWwtIc=
Received: by 10.227.164.202 with SMTP id f10mr2413861wby.92.1305755642507;
 Wed, 18 May 2011 14:54:02 -0700 (PDT)
Received: by 10.227.12.209 with HTTP; Wed, 18 May 2011 14:54:02 -0700 (PDT)
In-Reply-To: <BANLkTikC6MhvEiw=7JKscN5iOPFzVGxJzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173906>

Hi,

I noticed many times already that it is at times confusing to
determine for new users which file versions are shown where in the
graphical told like gvimdiff or kompare.

The problem is that when difftool machinery creates a temporary files
to show in the editor it is creating them with some random hashes in
the beginning of the file name.

Is it possible to make the difftool and mergetool smarter to have them
to create those temporary files with meaningful names, f.e.:

If I specify:
Git difftool master dev
It will create the files with master and dev prefixes correspondingly,
it will take the two points names and use them in temp file names.
Master_file.txt vs dev_file.txt

If I specify:
Git difftool
It could take HEAD and local as name prefixes

Same for mergetool where it could use HEAD and incoming branch name as
prefixes or something like that.

Does it make sense?

Thanks,
Eugene
