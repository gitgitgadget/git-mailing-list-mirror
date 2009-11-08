From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Strange behavior (possible bug) using bash command subsitution 
	with "git branch"
Date: Sun, 8 Nov 2009 23:46:33 +0100
Message-ID: <fabb9a1e0911081446o7793eef1kcbad964c9a73edda@mail.gmail.com>
References: <C71C822C.22429%kate@ning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Kate Ebneter <kate@ning.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 23:47:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7GXK-0000JL-6k
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 23:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbZKHWqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 17:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755626AbZKHWqt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 17:46:49 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:37074 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606AbZKHWqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 17:46:48 -0500
Received: by ewy3 with SMTP id 3so2639894ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 14:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=0+l7mO+Xh2ZMRNDJopcL4M9md4XQ24I7DR7hWID3ZbQ=;
        b=rSu8QQSpuiWK2iNslXYuHlhj2cgExNzKFpziFZr6F+TR14YxyuABNiQp25gyl79FLs
         3SMOYt01+09PHqhGTaxFMwpY5le2+8qo5z1xTNomkEOMCIQCQbEiikNfBP0+M/wq2ciE
         pXjtEpuxzpDsA8nDK1C6Iv0p/wC433FPyye/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dfBZFWMDs6mq2KsiA1EcxlpTgmsV1zHPT5X/naKpjIzCOTlGZZQb7epT/JpZUBleGO
         GLZ5Iu1aDWyl1Zi9f7nbjZNN7uoJlUsoUHSjAVSlipVfCjONIw6g5R9f99SoN6E7mWQb
         kAdSGLsF/VZeY3wyRRtWUDEz9++eAWqxZ+kCE=
Received: by 10.216.87.3 with SMTP id x3mr5211wee.132.1257720413127; Sun, 08 
	Nov 2009 14:46:53 -0800 (PST)
In-Reply-To: <C71C822C.22429%kate@ning.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132424>

Heya

On Sun, Nov 8, 2009 at 23:11, Kate Ebneter <kate@ning.com> wrote:
> That is, if you run 'git branch' inside $() or ``, it lists the directories,
> too. I can't imagine that this is intended behavior, but perhaps I'm wrong.

Try enclosing it in quotes ;).

That is, compare:
$ echo "`git branch`"
with
$ echo `git branch`

The kicker is that there's a * in the output of git branch, which your
shell helpfully substitutes with the contents of your current
directory :).

-- 
Cheers,

Sverre Rabbelier
