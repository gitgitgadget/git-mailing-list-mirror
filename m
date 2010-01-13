From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 20:39:12 +0700
Message-ID: <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:39:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV3RN-0006eo-Jq
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 14:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955Ab0AMNjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 08:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455Ab0AMNjN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 08:39:13 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47963 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0AMNjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 08:39:13 -0500
Received: by pwj9 with SMTP id 9so2836953pwj.21
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 05:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=474wevzLxu8o2NDy+EGQeSXRTL0s8sTLRZhyxsHxGko=;
        b=jZ4mxjjlIoaDQu/UpS5ZQwFAPSbYyaoSVZIWyZuHXAqzZ2yNXh02WrdWFHLNyajbRZ
         5qAJD/VYsdO3PE+TvBESXZAoXdV0zx009ENcAoehfIcYRVfsfnsM2MRAElXD33g8i53i
         SJ35hpM1xmJbAzefAVINuZ/c/EyP+c+y9lrpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=WeVCR0Ys0LAtIPaXd/dzxEN2zLyF2jRmjteRMe3GNDJeNv7GchzPu7Lp4VX3NwFV60
         D7xxKwc99u+1HjFwzvhEITOf90LzNziT1oDktIhd6sD4wrKFhz5/xkE+jpSZC9/F8mxv
         6zL38rfJsycQGQSolZT1XKiL4iKcxt+iJcVzk=
Received: by 10.114.237.28 with SMTP id k28mr1414070wah.98.1263389952674; Wed, 
	13 Jan 2010 05:39:12 -0800 (PST)
In-Reply-To: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136820>

On 1/13/10, Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> This is client-side support for Git-over-TLS (gits://). gits:// is
>  version of git:// protocol layered on top of TLS (Transport Layer
>  Security). If using TLS, it is autenticated transport supporing
>  fetching, pushing and remote archive (plus special commands that
>  have server-dependent meaning).
>
>  Needs GnuTLS, and adds new make option NO_GNUTLS that disables builing
>  this code.
>
>  Supported underlying stream transports include TCP/IP, TCP/IPv6 and
>  Unix domain sockets (including Linux abstract namespace).
>
>  Supported authentication mechanisms include passwords, keypairs and on
>  some platforms Unix authentication if using unix domain sockets. Server
>  is authenticated using keypair (hostkey).
>
>  The patch is split into two parts because it would be otherwise be
>  too large for this list. Included are all the needed client side
>  utilities (some of them run gpg internally).

Can we rely on an external program, like stunnel, to do the job instead?
-- 
Duy
