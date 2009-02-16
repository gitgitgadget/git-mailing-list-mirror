From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-svn -- out of memory
Date: Mon, 16 Feb 2009 15:57:51 +0100
Message-ID: <bd6139dc0902160657ka970bc6j4067c913d6641ee0@mail.gmail.com>
References: <1234795937.845716.4397.nullmailer@beryx.hq.kred>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, gitster@pobox.com,
	normalperson@yhbt.net, git@vger.kernel.org
To: ams@gnu.org
X-From: git-owner@vger.kernel.org Mon Feb 16 15:59:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ4wO-0002w6-Aw
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 15:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbZBPO54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 09:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbZBPO5z
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 09:57:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:37309 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbZBPO5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 09:57:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so244444fgg.17
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 06:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=fKLalKFqIWC34cqFanQempE2n5dyHEh8wKrpaiG6s/E=;
        b=t9AvxyuGw5zKvznk3RqXl7teRFZ4dRytlBKAB8g2SFX0VNOdrnDBjZDn2ky24t0mR0
         7cvDy7Is0IZGDgTmfE9oIeEhkgWq2VZ5A9Vi3DWHoQAdw51pHE9clH+qEDcznvB2Qof8
         b1YZuLTZSPsKn22hwrmQRt+027a/gdbM9LdFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=sfGyUF9+zIg4lLsLRrSo9lrkz7LSpKYRgEGnjL1PNC1dAqJNhLxLhpLkAxAntKeXB5
         taKV1kEmsJOYA2hWarnqNBS2yvV4Oc9GBMSsj5Xn+Q/okP76DJVxCQFNHSWMprV4L/ob
         V+iR/h71KNKiZFVp4BNykkcwwZV1Muc7ucCec=
Received: by 10.86.51.10 with SMTP id y10mr1481008fgy.51.1234796272037; Mon, 
	16 Feb 2009 06:57:52 -0800 (PST)
In-Reply-To: <1234795937.845716.4397.nullmailer@beryx.hq.kred>
X-Google-Sender-Auth: 3585f56197e0df66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110187>

On Mon, Feb 16, 2009 at 15:52, Alfred M. Szmidt <ams@gnu.org> wrote:
> Added an extra 20G of swap, still the same error.

Silly question, did you have a look at how much memory the git-svn
process is using? If so, does it have anything interesting to tell?

-- 
Cheers,

Sverre Rabbelier
