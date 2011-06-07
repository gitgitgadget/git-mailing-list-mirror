From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 4/8] t5800: document some non-functional parts of remote helpers
Date: Tue, 7 Jun 2011 19:25:49 +0200
Message-ID: <BANLkTinx0F7nfpmqx7AWChab3g-4MNnswQ@mail.gmail.com>
References: <20110607171838.GA21685@sigill.intra.peff.net> <20110607172030.GC22111@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:26:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU032-0003j1-C5
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069Ab1FGR0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:26:31 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47341 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456Ab1FGR0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:26:30 -0400
Received: by qyk7 with SMTP id 7so1474011qyk.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=rxRuSs/zcdIj0dMlP/Ce2xX64ZxOxI5FLMuDq8LZ5XU=;
        b=nCDuPto2Xj5bb3/oLboDaUyoVxQW5GjgJ09M+GTjCCTOyHoW3iOXQnHUSypg7lu1WH
         r6rw+ds0omBXUE6y+czntSJHCbqRSw6kz+h3OpW6sM28Pa3OaPwtZcT8bEfbp266Eb7T
         q05yQ9RYVaSPZUkhHyzBJfyxQPNXzQT85u2aU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=G55PLed9G873ml9KHPfBKJmjqgo+IXvG1/DlvRbkjYa7JPP1zA2GuXWfELyOI+3yrE
         2TXZBKzZAyQe69GUHbbBCILb7UiH24adO77U37mQHt2EaxxqQcK4sGd9wWiWgNHf6YnV
         IuX7bLTOrn1tXMJEa0hBfZTfg2dqiFpdjdVv8=
Received: by 10.229.135.12 with SMTP id l12mr4787170qct.53.1307467589294; Tue,
 07 Jun 2011 10:26:29 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Tue, 7 Jun 2011 10:25:49 -0700 (PDT)
In-Reply-To: <20110607172030.GC22111@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175229>

Heya,

On Tue, Jun 7, 2011 at 19:20, Jeff King <peff@peff.net> wrote:
> There are two possible solutions:

3. As mentioned in a different series, I feel it would be preferable
if fast-import/fast-export did not actually modify any refs, rather
the remote-helper should specify which refs should be updated to what
value explicitly. I think the same should/could apply in this case.
Does that make sense?

-- 
Cheers,

Sverre Rabbelier
