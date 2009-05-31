From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: inconsistency with --abbrev=0
Date: Sun, 31 May 2009 19:46:31 +0200
Message-ID: <fabb9a1e0905311046t1cd45b2cj4f889313c7781b38@mail.gmail.com>
References: <200905311748.00782.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun May 31 19:50:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MApBH-0000Hs-6A
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 19:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbZEaRqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 13:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbZEaRqv
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 13:46:51 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:50303 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbZEaRqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 13:46:51 -0400
Received: by ewy24 with SMTP id 24so7360610ewy.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 10:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TToYqczOS/QhhGUqFWkNUble5fL7yiIsaNS7ueyBvxo=;
        b=q5dijRzVSqMxSixmUn2/OpQtuBpD8TttVttrl3+S8JHJQYTyIyBZnAhmEdXBbhcJoB
         gOMyFWiwESfLoiF2DUvZknsyU1H45bVIOruYGe/oNQ2K2O/cOSmzU6j6MCksKbuxWkxM
         dGh2ynUxAf+wJ/tAoDRSzWePrPxq/coKUVNEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AzoP8B6hrRrt/R4HTU4fcYoLV1Fu/UvqcVwvQuAkNlE/0SzfCXHvyplyXUhg+hVLph
         a8y31W/osstoC4Ekm3/Kpw/mYK/EEOGkHSSzMzLxSdgm8LdrXLw9MbG9Af3LVFcX4FAx
         HNWEflZzUOzYjN5fcNVjSmyf8QFxS1BISRA/U=
Received: by 10.216.3.195 with SMTP id 45mr1592024weh.8.1243792011238; Sun, 31 
	May 2009 10:46:51 -0700 (PDT)
In-Reply-To: <200905311748.00782.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120423>

Heya,

On Sun, May 31, 2009 at 17:48, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> What should --abbrev=0 behave like?

If the minimum is 4, then --abbrev=n with n < 4 should give an error
saying that it should be >= 4, no?

-- 
Cheers,

Sverre Rabbelier
