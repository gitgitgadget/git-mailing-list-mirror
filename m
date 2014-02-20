From: Christian Jaeger <chrjae@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Thu, 20 Feb 2014 04:09:09 +0000
Message-ID: <CAEjYwfX_vZ1hYC1RKV7JXYhvd2Ru1kLSbNre-kOp_koK-GJMgg@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
 <xmqq4n3warni.fsf@gitster.dls.corp.google.com> <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
 <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com> <CACsJy8DsC9X=13iEpONcT6bw6qTw_O586_vZ2W_3O42ajEPF4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 05:09:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGKx4-0003P2-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 05:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbaBTEJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 23:09:30 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34568 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbaBTEJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 23:09:29 -0500
Received: by mail-ob0-f169.google.com with SMTP id wo20so1550964obc.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 20:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rxEXW6w88V5627Gps3riPM+0HD7D7sdr3Uj/j0KhrHY=;
        b=jElevLA0z0H8bS8wE0w06wV3Rn1ewre7UFi1SQwaG6SUHi0eZlOITwf2H/+hc7995S
         aew9a7MGxmD6OeISLNgz9mN1XU143+1HeSy8VB+CBCnLgSlYJFOaNjxYIj33ML7ZRlka
         0PgutixeJP/TtwjlixKOm/5B3sl9fGwyPt6lKFCVwlBfVk12FoCBXv27HEsjrTa3JkEY
         EC6L6/kvvwM58jKpjR9zRldemKgnzU7bBDT5KDfXJktj/lYkCt/KXDEu79/xrU7ufm33
         t51exUuenhvhIfwMAIGXj9ArLTUWSWYzXVa5p9BYp3D+h4SEAkVjGN166mHJxxqRujZl
         5j/Q==
X-Received: by 10.60.76.38 with SMTP id h6mr3847993oew.79.1392869369475; Wed,
 19 Feb 2014 20:09:29 -0800 (PST)
Received: by 10.76.27.73 with HTTP; Wed, 19 Feb 2014 20:09:09 -0800 (PST)
In-Reply-To: <CACsJy8DsC9X=13iEpONcT6bw6qTw_O586_vZ2W_3O42ajEPF4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242424>

2014-02-19 10:14 GMT+00:00 Duy Nguyen <pclouds@gmail.com>:
> Christian, if you
> want to experiment this, update MAX_DELTA_CACHE in sha1_file.c and
> rebuild.

I don't have the time right now. (Perhaps next week?)
