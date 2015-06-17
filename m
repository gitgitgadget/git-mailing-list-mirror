From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: 'git status -z' missing separators on OSX
Date: Wed, 17 Jun 2015 17:32:34 -0400
Message-ID: <CAPig+cQtHjF=KiK0V3+t6bnULVeOOkyhovto=CPfmvNPVkxGLA@mail.gmail.com>
References: <5580AF94.6090801@platymuus.com>
	<20150617033211.GA24673@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Tad Hardesty <tad@platymuus.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 23:32:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Kwq-000466-7s
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 23:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757481AbbFQVcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 17:32:36 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:34660 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685AbbFQVcf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 17:32:35 -0400
Received: by yhnv31 with SMTP id v31so17482862yhn.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=2OxxdFcwBRU0HGjpV7qb4eTQTOzLA0zS/Wni1ghQrjc=;
        b=AXNG0MKv0oKm/mEEdSbP9TJWBo/TrKQDg/3cibQAjXRxxh6oH/vdjH7zPGaVC7Jgqv
         iGtpPhJHHQgNnfQagHMzFhKsr6jGWyUonH3rR898NSTKYLF3qdvm7sw+fre5T8wi6SGZ
         E91Gw4EYtlOJibUtvScFh7ek/XURhAeC3wij7ef7Og3P8fdDvhTzesPNkScnqKh+VpRN
         GRfdGw7/JJ3tDmkVLq089pXTMHpBnPgDQpg6rGhln1MNoKH7woGDykWvMzqXmSSfBZqG
         IChdMnUyu/Zmk0Hcd/rBKAudfYLU2W24WITkMVdxBdwzUkSYclfbLgdnP66nCCsGuPaQ
         oKaA==
X-Received: by 10.170.97.9 with SMTP id o9mr9630145yka.84.1434576754344; Wed,
 17 Jun 2015 14:32:34 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Wed, 17 Jun 2015 14:32:34 -0700 (PDT)
In-Reply-To: <20150617033211.GA24673@peff.net>
X-Google-Sender-Auth: wRoxUEFbJX-3YwHsLpyg6sbLj8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271917>

On Tue, Jun 16, 2015 at 11:32 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 16, 2015 at 06:21:56PM -0500, Tad Hardesty wrote:
>> ~/test (master #)$ git status -z | hexdump -C
>> 00000000  41 20 20 61 41 20 20 62                           |A  aA  b|
>> 00000008
>
> That's really weird. I don't have a Yosemite box available, but I can't
> reproduce on the Mavericks box I have access to. Still, I'd suspect
> something weird in your config (e.g., something that is inserting itself
> on the output pipe of "git status").

I also am unable to reproduce this behavior (using Yosemite).

