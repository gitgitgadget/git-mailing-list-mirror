From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: [PATCH] Documentation: setup-git-server-over-http: Mention davfs2
Date: Mon, 18 Aug 2008 17:25:18 -0400
Message-ID: <48A9E8BE.9040807@gmail.com>
References: <1219093513-11248-1-git-send-email-gafunchal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	git@wingding.demon.nl, Matthieu.Moy@imag.fr
To: Giovanni Funchal <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 23:27:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVCFF-0004VP-UE
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 23:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbYHRVZ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2008 17:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbYHRVZ1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 17:25:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:41517 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbYHRVZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 17:25:26 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2257883wri.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=JRC3TrWVvjmbKXMUKQaJeI9Zmd9yD/C9cePIezE1aVI=;
        b=eUrbnU0LvN11CaaY7b4vYRmqDLqm/t9mTQFxHs691BfV8kxWHAm7042FWJvkcaUx1m
         MDdu5esWu2EM3ozi7lEbfY2jaxi/BmrNndqHX/PZBsMS2fCsftEw2GC92JaK1+5POq9A
         C+CoFQxZBlSqWH0gn3wFNoOH1JuTyhJTXfEbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=u5sneQ796ZQltFFJqgbKd8X0GuElaLzXT3N2wgWJ3JQVERSkw7huxYcBEWvyugU7eB
         +TztLvhQrGCvETAJL4mVLvKFsd8H/JcK9sbonR87JDk0TSCNMS2XkZF720cbBfXLBl3u
         qokpRT1zBeds02dATD7r62vfmCWuQ3gLr3/cw=
Received: by 10.90.80.19 with SMTP id d19mr8446958agb.73.1219094724452;
        Mon, 18 Aug 2008 14:25:24 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 26sm1202852wra.15.2008.08.18.14.25.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 14:25:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <1219093513-11248-1-git-send-email-gafunchal@gmail.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92741>

Giovanni Funchal wrote:
> +++ b/Documentation/howto/setup-git-server-over-http.txt
> @@ -164,6 +164,10 @@ Now go to http://<username>@<servername>/my-new-=
repo.git in your
> +
> +Step 2 1/2: testing your WebDAD server
> +--------------------------------------
> +

Typo? (s/WebDAD/WebDAV/)

> @@ -173,9 +177,18 @@ On Debian:
> +An alternative is to use davfs2, a driver that allows monting a WebD=
AV
> +resource into the system tree. This requires root access and kernel
> +support (probably your kernel includes this).

s/monting/mounting/

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
