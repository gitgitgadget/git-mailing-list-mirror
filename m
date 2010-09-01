From: Shivdas Gujare <shivdas.tech@gmail.com>
Subject: Re: html page display via cgit
Date: Wed, 1 Sep 2010 17:49:05 +0530
Message-ID: <AANLkTimucGi-7QdxbP5iLs0h5=VWW55GCxug51V584UA@mail.gmail.com>
References: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com>
	<4C7E29A1.8020304@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 14:19:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqmHa-0003ND-5I
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 14:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab0IAMTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 08:19:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59188 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab0IAMTH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 08:19:07 -0400
Received: by vws3 with SMTP id 3so6424227vws.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=8P8/7tvoLSauggvYXhzdqLf/s4qiDfJ7bYZEP7pifEg=;
        b=oU18cUZkaUBrw2X+Hl0SN0Bbh94UIkPJr2AzAVKoSsVaiC59s0HBYqa3ItK2zory0L
         zDXi9DKPaQdwo7XmfVZ4vdMIPmV76UzKjzk2mv62Bb8xzmnlMWlLyKfKF/U1eAjBUniC
         7s4t8LeS5lV6BPftshdhSb000HBEZEU90NZdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hXqeXnye+vgMWYzP8KNtuGjtmkrt5cqK3OaIr+0TcIMZRLZPzSGwXB0IkOXicQ6vhJ
         uvV1tmN+D6HmkGfZFTUPGqKF/IOO811E2COKow4Kh671JZbouAvl+kCIBApVPvY5zKKk
         G4P3mif1uK/8Uuj92XT+qtwsF3yEhWUa9BSXQ=
Received: by 10.220.171.211 with SMTP id i19mr5110633vcz.112.1283343545605;
 Wed, 01 Sep 2010 05:19:05 -0700 (PDT)
Received: by 10.220.177.141 with HTTP; Wed, 1 Sep 2010 05:19:05 -0700 (PDT)
In-Reply-To: <4C7E29A1.8020304@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155040>

Hi Stefan & All,

Thanks for your replies.

On Wed, Sep 1, 2010 at 3:53 PM, Stefan Naewe
<stefan.naewe@atlas-elektronik.com> wrote:
> On 9/1/2010 11:32 AM, Shivdas Gujare wrote:
>> Hi All,
>>
>> I hope, this is the right mailing list for cgit as well.
>> I am trying to add some "html logs" inside cgit, but I can't open
>> these logs via cgit inside firefox, i.e. cgit open every files in
>> "plain" format,
>> would like to know if it is possible to open "html" pages inside cgit
>> so that if I click on html page added into git, it opens in html and
>> not in plain format.
>
> Set this in /etc/cgitrc
>
> mimetype.gif=image/gif
> mimetype.html=text/html
> mimetype.jpg=image/jpeg
> mimetype.jpeg=image/jpeg
> mimetype.pdf=application/pdf
> mimetype.png=image/png
> mimetype.svg=image/svg+xml
>

I did tried this, but it didn't made any difference on showing html
pages. Does this work like adding a line "
mimetype.pdf=application/pdf" to /etc/cgitrc allows me
to open a pdf via cgit interface in browser?

Thanks and Regards,
Shivdas Gujare




> HTH
>
> Stefan
> --
> ----------------------------------------------------------------
> /dev/random says: Don't stop posting, a good laugh breaks up my day nicely
>
