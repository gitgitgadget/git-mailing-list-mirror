From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] po/hi.po: Add Hindi Translation
Date: Wed, 8 Sep 2010 20:31:56 +0530
Message-ID: <20100908150137.GA9021@kytes>
References: <1283711267-27679-1-git-send-email-artagnon@gmail.com>
 <AANLkTinbbzZWTZcJMTP52Vf0wHixOSE8vYcOCqTQv832@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 17:04:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtMBv-0003SK-10
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 17:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab0IHPD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 11:03:58 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62537 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0IHPD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 11:03:57 -0400
Received: by pvg2 with SMTP id 2so60379pvg.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZcuP4YO+ulPhkiRFspSzMSZorXox+V6V2O3tv5c3u1I=;
        b=rEDOLL6CcSM4/rrSGv0MHqZ7doeTOqY95DH5zqLzgWCS418UW0yadUdeUN/AjJkJbB
         BDfLjdi95DG68iW5OTSdRvD9QYF8LLQsIa7HleTM1W/VOoJFmDXA9KlqShsow3Cl+PZT
         PBmKZLJ0weHtTvxQXMf2DiVjC+OgsSiUH03Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZbjUaxE3bPS8R0W8IDEo/lfs0YAmVWSx0mOXETdGKeFozduuOexiCbretrlP2Y5s2K
         etgaFw40rbiCKHkOD/crl9p31vA4pZPq6vYrWb3WZzGqgBUWb+2bsL+HxghDRI835Oss
         mHpcecTKVo/9xMSVY+ePmNCKbqt0yiMQM3Egg=
Received: by 10.114.24.3 with SMTP id 3mr85547wax.31.1283958236018;
        Wed, 08 Sep 2010 08:03:56 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d2sm209385wam.14.2010.09.08.08.03.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 08:03:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinbbzZWTZcJMTP52Vf0wHixOSE8vYcOCqTQv832@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155791>

Hi Thiago,

[+cc: list, because I think others will find it useful as well]

Thiago Farina writes:
> How did you do this translation? I would like to do the Portuguese
> Brazilian translation. I have tried the poedit, but I couldn't make i=
t
> work yet.

Here's a quick tutorial to get started:
1. Get =C6var's fork of git.git from [1] and checkout the `ab/i18n-all`
   branch.
2. Read the instructions in po/README to create the actual .po file.
3. Get an editor that has transliteration support. For example, for
   Emacs and Hindi, execute (set-input-method devanagari-itrans) and
   use C-\ to switch between the input methods.=20
4. If you're not able to find a suitable editor or otherwise, use
   Google Transliterate [2].
5. Optionally, copy out some additional headers from `po/is.po` etc.
6. Translate and send the patch to the list.

Hope that helps.

-- Ram

[1]: git://github.com/avar/git.git
[2]: http://google.com/transliterate
