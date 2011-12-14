From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCH 1/2] set_ref_status_for_push(): use transport-flags abstraction
Date: Wed, 14 Dec 2011 10:32:17 +0000
Message-ID: <CA+39Oz55Ag5c7pfDYpHixk0=UdwuWfRMc+k3uC40jabUpynDXg@mail.gmail.com>
References: <7vsjkot5nc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 11:32:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ram8c-0005kv-98
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 11:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260Ab1LNKce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 05:32:34 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54834 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab1LNKcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 05:32:33 -0500
Received: by ggdk6 with SMTP id k6so578273ggd.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 02:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=BEy4fUDFeNi8+Zu5v0LhRlTDp/TOv7KGSWCur6HvCNQ=;
        b=LejnFr/FW3//YpxcifRtBEeg5Zo5fErWV9GtHiHO0T6EzvZwCQzmwEh+vrd2hKcD/d
         qr/LUN71cOYJztwLntm5WiL8sCkv6iDjLI2lmIxz1QvhLPbO4ugeKzcr/HVmE6Jl3YYs
         /3Wr0FyVLkIdPk0RUTBa1KiH+OPcGCXyFMy6o=
Received: by 10.182.220.99 with SMTP id pv3mr3934127obc.68.1323858752796; Wed,
 14 Dec 2011 02:32:32 -0800 (PST)
Received: by 10.182.85.70 with HTTP; Wed, 14 Dec 2011 02:32:17 -0800 (PST)
In-Reply-To: <7vsjkot5nc.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: dKDjHH7KPFAS_qjZ5zmFWS2Smvc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187108>

On 13 December 2011 23:26, Junio C Hamano <gitster@pobox.com> wrote:
> It does not make much sense to have separate "int" parameters to
> this function with two callsites (why do we need to to begin with?

This last bit should read:

"Why do we need two to begin with?"

Kindly,

-- Thomas Adam
