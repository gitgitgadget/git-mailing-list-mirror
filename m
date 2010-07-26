From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list 
	available repositories
Date: Mon, 26 Jul 2010 22:54:28 +0000
Message-ID: <AANLkTilSqePFPkteFd7DBgmdhqJHfUDuW_qhkbWVVb3Y@mail.gmail.com>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
	<AANLkTin+EMYHrr11Dba9Mob+b_Dar_cedWmTsDF=AHFt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: j.sixt@viscovery.net, gitster@pobox.com, jrnieder@gmail.com,
	git@vger.kernel.org
To: Greg Brockman <gdb@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 27 00:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdWZA-00071k-IE
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 00:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab0GZWya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 18:54:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38727 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab0GZWy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 18:54:29 -0400
Received: by iwn7 with SMTP id 7so3118437iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=KF0WMPV2lcC/WZ62nHodxYybT8GVODbGuJPrHrbQBtI=;
        b=lrEg16E+zYP+7qpioA+Mbc3UPpw/htZ7vd9hi0nnolX2TjYJfeYR6fQ0VeQAgwJMzH
         rtsshqeVRtBo+TlV9MWr1gNtWTAGSj68dIfiLfQvFSG8WdqKbnHyO377kUrNEkNW8mVV
         HFdxcv4+zmgUp5y2mp5KmZAS/PlD8CQtOwl6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=h9/3j+3nDSLShPbGjU9+y3uNbvXRbj6oMJlu97l9v0lvGaasJMHYhbNHyFUikgfrFO
         mg3Rt9ZVJTJITp9P2XnRTjEKnaY0qvOdnDxXlpd9NTXmQJp4mVYL2q6ay9VNUmo9aAnl
         XFVlecIPdBQZTuKZ0v0agDfsn2gA8VXTI6BfM=
Received: by 10.231.185.142 with SMTP id co14mr8258099ibb.97.1280184868951; 
	Mon, 26 Jul 2010 15:54:28 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 15:54:28 -0700 (PDT)
In-Reply-To: <AANLkTin+EMYHrr11Dba9Mob+b_Dar_cedWmTsDF=AHFt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151901>

On Mon, Jul 26, 2010 at 22:32, Greg Brockman <gdb@mit.edu> wrote:
> Just sending a reminder about this patch series--I haven't seen any
> comments on it yet, so I assume it's gotten lost in the flurry of
> other list activity.

It would probably help if you re-send the entire thing again. It also
seems to have an unaddressed comment
(<7vlj96m4mc.fsf@alter.siamese.dyndns.org> from Junio).

It's also less confusing if the version of your patch series (see
--subject-prefix in git-format-patch) matches your series. I went
looking for v2-v3 on the list, but found that you were just counting
the two RFC's as v1-v2.

Things quickly fall from the end of the list archive around
here. Don't be afraid to resend. It's also easier to review if some
mails in the old series have subsequent fixup mails.
