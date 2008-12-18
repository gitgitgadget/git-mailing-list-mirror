From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 2/3] gitweb: add patches view
Date: Thu, 18 Dec 2008 20:57:43 +0100
Message-ID: <cb7bb73a0812181157r20b0cbc3t290e32454a435b0c@mail.gmail.com>
References: <1229422290-6213-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1229422290-6213-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <7v4p12hv5q.fsf@gitster.siamese.dyndns.org>
	 <200812181915.48556.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 20:59:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDP1U-0003Eq-7K
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 20:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYLRT5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 14:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbYLRT5q
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 14:57:46 -0500
Received: from ik-out-1112.google.com ([66.249.90.183]:53053 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbYLRT5p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 14:57:45 -0500
Received: by ik-out-1112.google.com with SMTP id c29so134634ika.5
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 11:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=RJ+oiiJw7KpMjdP7eusn3sEXQepgeJBSes0MGIoaaz4=;
        b=OcPq0rWerEuvDG/lfi2gkbJ4X2dqvIOvM8RALOv0zZGODSoK8UYU5O5k0o4d/OFmIi
         r+TA+Lk0H5HXmSabR0yqIVbOJ77rlgzgJmtIaTc2Xcmv4sho3Ryr57Je9hGIjT7cIxU0
         wOA1PN5K7ypCmw2RweM2gV1aTzNSM5/J0XKec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fYjkVWg5FSQr2pLpKuJsPjuqcxrWria9DOse6S/WbS+rKBxEb+nyorZ2w1xHI8A+gK
         ZzSxDOMd6jFVN0KpTvePBoFkZFz0Ual5C9CXzQEFZCf6YKZzUutsZcD2rDlkM5gr0G39
         CCYkDzuLlJaxexnXbZR5RS5rclXzNTqTdOjG8=
Received: by 10.210.24.12 with SMTP id 12mr2784054ebx.34.1229630263915;
        Thu, 18 Dec 2008 11:57:43 -0800 (PST)
Received: by 10.210.136.4 with HTTP; Thu, 18 Dec 2008 11:57:43 -0800 (PST)
In-Reply-To: <200812181915.48556.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103487>

On Thu, Dec 18, 2008 at 7:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> Just a though, but does it really take much sense to have "patch" and
> "patches" views handled in git_commitdiff? I can understand in the
> first version, where it was more about better 'commitdiff_plain', but
> I wonder about now, where patch(es) view is something between git show
> and log_plain format... Wouldn't it be simpler to use separate
> subroutine, for example git_format_patch or something?

I don't feel like much has changed since the beginning when IYO it
made sense to have it part of commitdiff, honestly

-- 
Giuseppe "Oblomov" Bilotta
