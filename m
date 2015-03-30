From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Renaming "git rebase --onto"
Date: Mon, 30 Mar 2015 14:03:19 -0700
Message-ID: <20150330210319.GC22844@google.com>
References: <05D9209E-FAA2-44C8-9B98-B00997AF5779@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 23:03:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcgqG-0001bs-WA
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 23:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbbC3VDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2015 17:03:24 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35506 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbbC3VDX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 17:03:23 -0400
Received: by igcau2 with SMTP id au2so1058909igc.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SdmycLmpo0ZMP6t/aGJWLL0XxDkeZk99PGu9qxAGtdc=;
        b=j09qjOI864G+8Qr8yVJbBHc4wnxtZFfeQnt8vcuAclbivFhetpWgq0W5mrl+0AkMgU
         aC8OXon6NpdG2N/SXa6b3PlcV0ckByFu1LY4l8uM+rzHAMW5Lp4MzH1g0PzqOFjjCZBx
         qS2HI1BF5MaIqQ/XdUGyBKYd0oCKfqh95l71s+O5ak44Sbd0OeZ2D72SEJJZxZuOHysj
         w8317Vqi5oA6w5LD+OaSQPzCEGHfgaAAZ6LyX7/JSrI9OnxUwYF1Zjj8Z8+hsvDTqFjH
         y871hsmKlHwa/POUllzpU68cShujXjvGnVyckaxWN7Ah5/NojdcRmJ41nqUQvVUBXH2l
         k9Sg==
X-Received: by 10.50.43.138 with SMTP id w10mr20519933igl.19.1427749402006;
        Mon, 30 Mar 2015 14:03:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b8c3:e0dc:7bee:9947])
        by mx.google.com with ESMTPSA id ir10sm9628141igb.2.2015.03.30.14.03.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 14:03:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <05D9209E-FAA2-44C8-9B98-B00997AF5779@JonathonMah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266475>

Jonathon Mah wrote:

> Personally, I understand =E2=80=9Cgit-rebase --onto new-base old-base=
=E2=80=9D as
> meaning =E2=80=9Crebase from old-base to new-base=E2=80=9D. Some prep=
ositions that
> might make this clearer:
>
> $ git rebase --from old-base new-base  # =E2=80=9CRebase HEAD onto ne=
w-base, from old-base"

Would having an option name for the old-base argument help?

=46or example:

	git rebase --old-base=3D<old-base> --onto=3D<new-base> <branch>

?

Thanks,
Jonathan
