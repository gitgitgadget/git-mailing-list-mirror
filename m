From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-archive and submodules
Date: Mon, 20 Jul 2009 13:33:09 -0400
Message-ID: <32541b130907201033r68da33f7tba3b0f0200212724@mail.gmail.com>
References: <41ceb5540907200922r5decb047h75e723a1809b587e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Woody Gilk <woody.gilk@kohanaphp.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:33:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSwk7-0005iw-CV
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbZGTRdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbZGTRda
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:33:30 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:45037 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZGTRd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:33:29 -0400
Received: by gxk9 with SMTP id 9so4205620gxk.13
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FNcrp4Yj7PK3qjdsqgKs6TVpDPdbqbJ5kRw0KtdETKM=;
        b=sRw5DZW5lEqjRNYRg2jDcWr4JDzqyr7EqQYi7yAYqE58boRWlROQDeHj8VgW5mQPVW
         Bmi4y0w/eCsfw3a3z5SD5cCbg/wXJBcX751fI2BUEWstPlinF4o+lCFGFVM/1LyVnhSO
         twyc4vnbCLxGu/K0Gc35+WISjdMHOKDMfih7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PtiH9fH0rKVRqgahTR66kZiFQzjekk8Bk2+Jn4BV05TwAjOfzvDNQMYAmp0rN3f9Nk
         1fBlhVLrnJKBvo1amM7q/y3PZIwK1zxiua58OhA5mC4GEecLed2aRc26fS5BPf9XLwBe
         NcagzSvIjMGDDVRVFIAifHwlOIj+0KYeEJmKs=
Received: by 10.150.226.14 with SMTP id y14mr6106572ybg.3.1248111209089; Mon, 
	20 Jul 2009 10:33:29 -0700 (PDT)
In-Reply-To: <41ceb5540907200922r5decb047h75e723a1809b587e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123621>

On Mon, Jul 20, 2009 at 12:22 PM, Woody Gilk<woody.gilk@kohanaphp.com> wrote:
> I would find it hugely valuable if git-archive would support
> submodules, rather than leaving empty files in the place of
> submodules. Supporting submodules is critical to packaging releases
> (combined with signed tags). With git-archive not support submodules,
> it means that I have to manually package and sign each release, rather
> than using git-tag.

<shameless-plug> This works already today if you use git-subtree[1]
instead of submodules. </shameless-plug>

Have fun,

Avery

[1] http://github.com/apenwarr/git-subtree
