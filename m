From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/6] shallow: add setup_temporary_shallow()
Date: Fri, 16 Aug 2013 19:52:04 -0400
Message-ID: <CAPig+cQxq2B-zJeFP8p=8yb8Po7LX4_ZWsAZy=jJdHF7f5PN8A@mail.gmail.com>
References: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
	<1376646727-22318-1-git-send-email-pclouds@gmail.com>
	<1376646727-22318-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 01:59:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VATvm-0006Rc-FB
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 01:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab3HPX7e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 19:59:34 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:53060 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690Ab3HPX7c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 19:59:32 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so1970662lab.19
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=HzwAmU07N6ebziZeX3fsl3JhbRLzlqeIdT8eVEHdPEs=;
        b=s/bf/N/F1oLxs0fbd/ygRVE+tbNC6PFSzIizlW/6Ac28+uujDrn9gw3ljlzhD2ewAd
         VpWKTPkH+6mIHLhUoo49yOydXRknxfSPJBmv6VC3m8jb8vhmFOxTTwog4CwF5tSwFr9G
         YxbZoVvv3spV6NCE4Ouw8uUKUcvpcBY6GPwXa/9K6ScHJL/+Uj1m6K8PB9hNwkNs27Vm
         UgJYDZq42VrtH8GSXpwRlocRmCD1MLTJZyhBvYR9+89l70CX3TxWUoFSrVLUy/Cf3osX
         SNtqPJbDgq5cyrfXzDTwTDd6ZfioKNVnIfzG9zMGXirZxcqs5aqgtjf6dzdxnRKN6pT6
         XKwQ==
X-Received: by 10.112.26.106 with SMTP id k10mr164122lbg.27.1376697124512;
 Fri, 16 Aug 2013 16:52:04 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 16 Aug 2013 16:52:04 -0700 (PDT)
In-Reply-To: <1376646727-22318-3-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: wm4btltHJhBRcUVJT2kBwse0jjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232446>

On Fri, Aug 16, 2013 at 5:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This function is like setup_alternate_shallow() except that it does
> not lock $GIT_DIR/shallow. It's supposed to be used when a program
> generates temporary shallow for for use by another program, then thro=
w

s/for for/for/

> the shallow file away.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
