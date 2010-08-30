From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Mon, 30 Aug 2010 22:17:07 +0100
Message-ID: <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: cdahlin@redhat.com
X-From: git-owner@vger.kernel.org Mon Aug 30 23:17:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBj8-0001AT-Ta
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab0H3VRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 17:17:09 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37101 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab0H3VRI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:17:08 -0400
Received: by qwh6 with SMTP id 6so5278738qwh.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=IwzHrvzGuilVlTcSNNUPvquP9SNgajAh7avhChvAnIw=;
        b=dpXiKeQrYTzd2c595L485hff1iJ1xW5dGZMePOVXmwTAR4abnByk0RofvYIel/M7o9
         aXaYpaqFj1UDEnzzEtRpSurYPkmMQMxcwR2tJhd7NehNenad96Rh+Izlfm2v6ac5Qkb2
         MejR92rBkCzN/YZVQHK6hgp4yXdsL70wk4jAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EzMoRlL3dvPdmCPjFpYp2jGQHRQaRvrmYM0DlNwDKupo5AaE8A/T+fqWEf0/gUWp83
         QksUvHUDlsVsiLHNn6y3gi9mqNYOUdLCN29hLMhHhz8qBVCeQLO70npHTHbLgkxOxtR8
         Kg0UimgPbQRo/P1pdFAnKDrHjVu/a37fhev/k=
Received: by 10.220.58.1 with SMTP id e1mr2550283vch.166.1283203027113; Mon,
 30 Aug 2010 14:17:07 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Mon, 30 Aug 2010 14:17:07 -0700 (PDT)
In-Reply-To: <1283198367-11440-1-git-send-email-cdahlin@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154846>

On Mon, Aug 30, 2010 at 8:59 PM,  <cdahlin@redhat.com> wrote:
> From: Casey Dahlin <cdahlin@redhat.com>
>
> This isn't really what I'd normally call ready for public consumption, but
> since there's been some minimal list chatter on a similar subject I figured I'd
> put this out there early.
>
> git-hive is a peer to peer service for exchanging branches. When started it
> runs a small daemon to publish your repository on a random (or specified) port.
> Two hive daemons connected to oneanother can exchange branch lists and
> introduce eachother to more hive daemons to widen the network.

 p.s. is there any location where, in diagrammatic form, the
protocol's described?
