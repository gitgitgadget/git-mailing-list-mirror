From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: Skip over AUTHOR/COMMIT_DATE when searching all
 fields
Date: Sat, 20 Mar 2010 01:42:48 -0500
Message-ID: <20100320064248.GA26648@progeny.tock>
References: <1268607549-3440-1-git-send-email-fbriere@fbriere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Mar 20 07:42:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NssNs-00081g-2n
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 07:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab0CTGmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 02:42:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57179 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab0CTGl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 02:41:59 -0400
Received: by gyg8 with SMTP id 8so1869599gyg.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 23:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mZgKnisk9Id6wRUnvhGkSLHz7Bu81o+mOQICKZMfQ40=;
        b=D0IQC2KqDFHMoUtVrN5IvCVHrkWklKVwKACzxMlah+VkpFW4Xe4x9fmeRuRwiHc8Nn
         Wt5bNUVpERK3gM4EepiXYRMd/AOsaDm7GN0SccDLOyNMpVarYddy/apiKBX5LzY9OXtv
         Mj8IJKK9Y8zNo1kNotr6rgl2984o2v3/NMgUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ABbZyWSSMDr2aJHwukHcEi3BCwxzPa07qWAwbqbhLHLJgCvt0KS7X1qEZy9RZP1cWq
         Zrtr0hbXHxgHHz50Ju1kWTdS8t1q0WouKCdyITlqamjwjqPtuQ0gSIjEgsGHmfAiHNfg
         K98L7ZGgDWEIUZ8ACOAtbNBpRw0mvEktBRGOM=
Received: by 10.101.124.4 with SMTP id b4mr317296ann.194.1269067317908;
        Fri, 19 Mar 2010 23:41:57 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm41572iwn.13.2010.03.19.23.41.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 23:41:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1268607549-3440-1-git-send-email-fbriere@fbriere.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142693>

=46r=C3=A9d=C3=A9ric Bri=C3=A8re wrote:

> This prevents searches on "All Fields" from matching against the
> author/commit timestamps.  Not only are these timestamps not searchab=
le
> by themselves, but the displayed format will not match the query stri=
ng
> anyway.
>=20
> Signed-off-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>

Reviewed-and-tested-by: Jonathan Nieder <jrnieder@gmail.com>

There=E2=80=99s a follow-up patch to remove the duplicated code this to=
uches
(no functional changes) at <http://bugs.debian.org/465776>.

Thanks again.
Jonathan
