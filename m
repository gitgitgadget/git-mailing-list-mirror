From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: patches in context format ?
Date: Mon, 12 Jan 2009 10:53:45 +0100
Message-ID: <46d6db660901120153y23905b9dx6bfd27ffe7bce186@mail.gmail.com>
References: <46d6db660901120100g7f62a0c2k68c96cbfc23dab5@mail.gmail.com>
	 <871vv8rhpz.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:55:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJVn-00041O-5y
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989AbZALJxt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbZALJxr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:53:47 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:58974 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbZALJxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:53:47 -0500
Received: by bwz14 with SMTP id 14so31815396bwz.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=p9cm9WAEH8HzTHHqryGsiHm+pkqKeb2c13xmdsBc5QM=;
        b=mNBwC8esGuxfo5WWMIzBRd6WrDiO8aWPvkLVxRCTpa5/217ev4OzKts5s9XmJcslgR
         yv7vbGOULEqjQNm5X2nrtVonrTR7AIKHPeZQLvYyW5js78UIMt35PI/ZECaBbUHqTJlI
         j3bILv0OhiCbLuJxKzmujFebBzMGkGAabso/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QIPqaTD4RK80M7JFl3XjNnWHqNoHlPRW9RfTAt8YgNspnilpr1+br18ZwQE9wMzLbI
         Ux7kwTlAeNAvo4zEQnfA2eE6JPEPpx/FlqgPQjmZMZURHwAvv5uN4xF3x5qb7oHOOuLt
         QFCB1MTXaBSALqptMVG0/Iwe26oqwxoWR0xgM=
Received: by 10.103.217.5 with SMTP id u5mr6282791muq.118.1231754025193;
        Mon, 12 Jan 2009 01:53:45 -0800 (PST)
Received: by 10.103.118.7 with HTTP; Mon, 12 Jan 2009 01:53:45 -0800 (PST)
In-Reply-To: <871vv8rhpz.fsf@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105320>

On Mon, Jan 12, 2009 at 10:34 AM, Teemu Likonen <tlikonen@iki.fi> wrote:
> Christian MICHON (2009-01-12 10:00 +0100) wrote:
>
>> is there another way to translate from "context" to "unified" format ?
>
> Well, this is not exactly the best solution for a Vim user but this is
> the only way I know. Emacs can convert diffs between the formats. You
> don't even need to launch Emacs, just run it in batch mode:
>
>    $ emacs --batch -Q --file input.diff \
>        --eval '(diff-context->unified (point-min) (point-max))' \
>        --eval '(save-buffer)'
>

you're asking a vim user to use emacs ? ;-)

thanks for the suggestion: I'll try it at least, but I think I'll
stick to interdiff.

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
