From: "rae l" <crquan@gmail.com>
Subject: Re: [PATCH 3/3] log/show/whatchanged: introduce format.pretty configuration
Date: Mon, 3 Mar 2008 01:12:28 +0800
Message-ID: <91b13c310803020912u44dea924ked9684e3e3537111@mail.gmail.com>
References: <7vr6etvlgm.fsf@gitster.siamese.dyndns.org>
	 <1204448753-4471-1-git-send-email-crquan@gmail.com>
	 <1204448753-4471-2-git-send-email-crquan@gmail.com>
	 <1204448753-4471-3-git-send-email-crquan@gmail.com>
	 <7vir05oybp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:13:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrkM-0006nL-Mr
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbYCBRMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754637AbYCBRMe
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:12:34 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:40153 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbYCBRMd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:12:33 -0500
Received: by ti-out-0910.google.com with SMTP id 28so5162901tif.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 09:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A/DBNIkNoh3MULyg62uzJauV6N/jnjmoi3ljiFh57Jw=;
        b=W2kFHXXSM/yekk5d3SUxwlA+ZYuiKQIbwgMHQRITA64kW6mtraaIoc9D566TxQQLVBxg3Ar5eOB6w4Zs8/jTbwNCQshNHvn0teemdpCL7UWogeSuC5dwNTpuQkiHbFhV0ozactLmQq35NjF/TrINpoZaNiX2Fq9NgnBHLazDM8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xim/3tw3BJYUCfDpelDodbDkemHl2VG6P8baX7MgZ7yBan3NCHFg8xN4abtEqtndd8MFhuq5gax2le3OkoYl8Kfhg/b1bcxAJ8/JaEzp5qKxXUhwwFMtto8/Ag10hHnnlBYUZcE2hPjaJAkzRlW97GnieRFTPUouH2oqDgmpeeE=
Received: by 10.150.215.16 with SMTP id n16mr4167637ybg.16.1204477948469;
        Sun, 02 Mar 2008 09:12:28 -0800 (PST)
Received: by 10.150.186.4 with HTTP; Sun, 2 Mar 2008 09:12:28 -0800 (PST)
In-Reply-To: <7vir05oybp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75813>

On Mon, Mar 3, 2008 at 1:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  I see you pretty much copied my suggested commit log messages except that
>  you dropped the warning about the need to adjust out-of-tree scripts by
>  end users from this one.  I however think that was the most important
>  part.  We need to warn our users fairly aggressively in Release Notes
>  about possible compatibility issues, and commit log messages are one of
>  the most important sources for that.
>
>  Incidentally, I noticed only one when I wrote the above but now we have
>  more, so "the only in-tree caller that runs" part is totally bogus.
>
>  No need to resend anything, as I can manage with these three messages.
Thanks. :-)
