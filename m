From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Getting started contributing.
Date: Sun, 3 Feb 2013 16:54:57 +0700
Message-ID: <CACsJy8AYOAwLKufQ34brk1agyFAX9xjgAE9_LAcRx=RGxcEZzg@mail.gmail.com>
References: <1359872508519-7576834.post@n2.nabble.com> <7vd2whalax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: adamfraser <adamfraser0@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 10:59:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1wMZ-0002Ee-0E
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 10:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993Ab3BCJza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 04:55:30 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:51765 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab3BCJz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 04:55:28 -0500
Received: by mail-oa0-f47.google.com with SMTP id o17so4015843oag.20
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 01:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rCpfJN0sKtU+1xnk/10CA04HC+eSQC8ejOceNQpp1LU=;
        b=F7BuG+CNrZfbbhyDYuxFQ+J6b5PB1+iGPgbqB9Z7GQnk05Rpg7L93btUs7p2DN9jrI
         3SNsJqxGYpgC3qWVB3NGyYxn8ysKq4fUbrkZeiIJSk94jpu/hWcRaw2LGwIWSG7WFmPj
         O3jCgO47ZGwKM7ZQwX/rPqi8yE6xax7J9xmMD8hbL92x4Qio02hz5rXArvsRwSVfcZd+
         fVWrdr+Bm+1ZI5m52HmB5cDxOIXA+iQLBB6SUn2cXLuLFiVYoPwYiL+MWfmAv/Wd1wx8
         AsD4WWGdMTuh+5zZrQyU3NOA35Iu1IDZWh3BsSn0E8FBH7dk/erB4jI6DCB3c36KUBVF
         C/CA==
X-Received: by 10.60.154.169 with SMTP id vp9mr13752365oeb.109.1359885327892;
 Sun, 03 Feb 2013 01:55:27 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Sun, 3 Feb 2013 01:54:57 -0800 (PST)
In-Reply-To: <7vd2whalax.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215305>

On Sun, Feb 3, 2013 at 2:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On the other hand, there probably still are many loose ends.

A few other things

 - Mark more strings for translation (not as easy as it sounds, some
strings can't be translated)
 - Color more in the output where it makes sense
 - Stop/Warn the user from updating HEAD (e.g. checkout another
branch) while in the middle of a rebase (some makes sense, most is by
mistake)

PS. You are welcome to improve my two patches Junio mentioned. I don't
think it overlaps much with "git rebase --status" though. Printing the
remaining steps, or what patch being applied is not going to be done
by "git status".
-- 
Duy
