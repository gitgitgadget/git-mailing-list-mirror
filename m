From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Documentation/remote-helpers: Clarify "curl" family 
	of remote helpers
Date: Mon, 29 Mar 2010 12:44:43 +0530
Message-ID: <f3271551003290014t6fa8ce57s4ecda041c8a00a61@mail.gmail.com>
References: <f3271551003282104m1c273450pacc5d5c84125fa54@mail.gmail.com> 
	<7vy6hb8vpv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 09:15:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw9Bu-0005WP-3i
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 09:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120Ab0C2HPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 03:15:07 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35770 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998Ab0C2HPF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 03:15:05 -0400
Received: by gwaa18 with SMTP id a18so3885238gwa.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GsqLBV7xsH1tFQsep42bBbMbUvvZJeuSfGMDjSzQSsI=;
        b=sR3M7nVONjFljzPPFziPuKtVynhj0TR9zk7InhRA3zMfMmDW2vtQeF7OWuDh+3q6vh
         t6MWKn49k1OLK/EWmkRsAVdYrDUlHiEMvevnU+l8ZIKqj9/57A5D+Uq4sG+n6mEsexP8
         mEhahTn2uLBBCDbp8pJpJg814A+dxapFPtlQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EdJsRPOoaq8w+5geWh3hGIh7v+q39qOLPyQoP751s1vIp+9s7R3qNL3TwGqcFySJrj
         dKK2x5CdQeWRUMK7ZhyIIQISo7xC7aFmvLInUAK8/TFbtbN4ZvM+A5KvnQWYubLs/sEb
         9uwCL7u2M3w1gNTjCdNGRy2sJbiUOjbybDUy4=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 00:14:43 -0700 (PDT)
In-Reply-To: <7vy6hb8vpv.fsf@alter.siamese.dyndns.org>
Received: by 10.90.23.37 with SMTP id 37mr516690agw.75.1269846903117; Mon, 29 
	Mar 2010 00:15:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143446>

Hi,

> I don't see anything wrong with "curl family". =A0Individually they m=
ay be
> http, https, etc. remote helper, but if you need a name to collective=
ly
> call them, you would want to say "curl family of helpers"; "curl help=
ers"
> simply doesn't make sense.

Okay. Since this depends on the corresponding PATCH 1/2, which is
currently under debate, I suggest that we drop this patch. Yes, the
older version of the paragraph slightly confusing as Tay pointed out,
but I don't know how to make it any clearer without getting into
invocation details.

-- Ram
