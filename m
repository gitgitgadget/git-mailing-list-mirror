From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Mon, 30 Nov 2009 09:09:22 +0100
Message-ID: <fabb9a1e0911300009j1574c06cy500dde75fc68662f@mail.gmail.com>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org> <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com> 
	<7vhbsfi4bz.fsf@alter.siamese.dyndns.org> <36ca99e90911280408v186777f1h22254744fb61bf1f@mail.gmail.com> 
	<36ca99e90911292307w769913fdn1f610eeb065b41e@mail.gmail.com> 
	<7v4ooczdoe.fsf@alter.siamese.dyndns.org> <36ca99e90911292341o524840ebo47d79f06b1588d5c@mail.gmail.com> 
	<7vtywcwj1o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:09:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1KO-0004Rw-7R
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbZK3IJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 03:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbZK3IJg
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:09:36 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:61280 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbZK3IJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:09:36 -0500
Received: by vws35 with SMTP id 35so986334vws.4
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 00:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=TxJtVlSEFJrIvJp8Z/m28brhUQleDRISV9OzEEu12KQ=;
        b=tKzVD27oNQ8+4FJ2zLvpAxRWBKR9Q2KQOwPo+YzoXPE6a6lFsP7294N1DuMa+y74dY
         P710YzU4OeoAhRCm1z1jytOkwJzYwUxnrf6f8/72mgSpIowE+f7+n9VuUStXpP1Qh6O4
         E2LgCnq9zy3H4sGfQqShfvBdBOv2ulIJYEVNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=U0goWM2QqBQQQ64+bJXcPUmZpRAsMndTo5wMCHiu5r90u2VZB27QJv7m6xn72T7ZZ/
         MlRmPf+YO6hm6u+mp3Af5VKOtGiT1MzFXDkkWcc71PEH66YCAXR8x7/2sackmqf31k8M
         XVVAHwZ9i0gHB8rHVgAqIf474Udspjr3kBjtI=
Received: by 10.220.126.150 with SMTP id c22mr4836555vcs.6.1259568582077; Mon, 
	30 Nov 2009 00:09:42 -0800 (PST)
In-Reply-To: <7vtywcwj1o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134078>

Heya,

On Mon, Nov 30, 2009 at 08:47, Junio C Hamano <gitster@pobox.com> wrote:
> I'll merge the updated (i.e. rewound and then rebuilt) tip
> of the topic branch when the topic graduates to the master (hopefully
> before 1.6.6-rc1), so we won't see the botched one in the end result.

I'm curious how you do this. Do you keep a list of replacements, that
is "when merging branch foo from next to master, instead merge bar",
or is it something the original author should remind you of when it's
time to merge to master?

-- 
Cheers,

Sverre Rabbelier
