From: Ping Yin <pkufranky@gmail.com>
Subject: Re: A question about using 'add -p' to split the patch
Date: Mon, 15 Jun 2009 16:56:40 +0800
Message-ID: <46dff0320906150156mf9ac4dek99c94a6cc59e1db@mail.gmail.com>
References: <46dff0320906142008v4f278d3ek3eebfa36f7fcf06a@mail.gmail.com>
	 <20090615061211.GA53136@gmail.com>
	 <46dff0320906142324i191e50d5v1e89ba6311377a47@mail.gmail.com>
	 <20090615073635.GA53643@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:57:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG7zr-0004AQ-Im
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 10:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbZFOI4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 04:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbZFOI4o
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 04:56:44 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:59373 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbZFOI4n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 04:56:43 -0400
Received: by gxk10 with SMTP id 10so6274962gxk.13
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GWemgluAhY5vjKRzq7Fy2L47GpWCmlvhNjhYz+WV2+E=;
        b=SY1e9pRAl/ZYufpRGoYXrp3AfatkVrx9Sndpyvjxdq8C+6aIU5rY65VQ4z4Kd7DwSj
         /WD3TRCgABu0mK7h1pJ/mbARpJEcq4kQVQQRHx4SbAiFVKeN27HMUTyBEYMrt4eI1woe
         TCqfHXV1JUBZ/Jhlll7PYuQWWKrwFCgGeha0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L+HnbJI7yq/S/9Px+GwkuxDtlEmgGXdKfcVYO+0e33JMNo619Otk8k18KDw+7cJg8K
         FvkxwCOJwQsFVDXRHdI92pqUScr3aU3SHuNosj51vFvkawNmnsKwKBvCjoTuHPsUbNi4
         jEySVqCDpNnXW2i4TXEVJRVU36Wpag0zCApDU=
Received: by 10.90.56.17 with SMTP id e17mr6083368aga.4.1245056205544; Mon, 15 
	Jun 2009 01:56:45 -0700 (PDT)
In-Reply-To: <20090615073635.GA53643@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121594>

>
> For add -e I got it to work by editing the patch to;
>
> +function bt_move($path, $pos) {
> + =C2=A0return;
> +}
> =C2=A0function bt_add($path) {
> =C2=A0 =C2=A0return;
> =C2=A0}
>
> The reason it's hard to get right is that you have to
> reconstruct the context of the original content for the
> adds/removes and remember to add the space before the
> reconstructed bt_add($path).
>

Thanks very much, i forgot the space before the reconstructed bt_add($p=
ath) :-)
