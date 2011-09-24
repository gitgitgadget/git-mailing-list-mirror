From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: SSL certificate password storage?
Date: Fri, 23 Sep 2011 21:04:53 -0400
Message-ID: <CAG+J_DzhM-Nr8P7WyuYv47uNQc6p64k6P031Ec=DmmvKz0zS3Q@mail.gmail.com>
References: <CAEsSSh2MDPgcFtrwYJ7uCDHBHPEfo35deE4dsWrb7Ukp7b310A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: James B <coderer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 03:05:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Gfw-0000ED-Vj
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 03:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab1IXBEy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 21:04:54 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52252 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab1IXBEx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 21:04:53 -0400
Received: by gwb15 with SMTP id 15so4119420gwb.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4y4wzVRvvKJdXsm0IpfVdpyiynIOK8i1fQwET73Tmiw=;
        b=TZR3u2HMg1TAbpKgIf+BGYhf3lplxAFZdtF1+qJiG2Y62OGmeXwl8r6KMI+AFoohn1
         d1aKbx/U9r1dCWsrCAJS4q1BcV4kUWfdlaN3hZLcyf5Yn+cexowIfDmLNn8JU0myy/Kt
         Qd/E3C4hGDcLi9RtnIpxknN4nF7MHhdZ1YfWk=
Received: by 10.147.154.12 with SMTP id g12mr3888384yao.36.1316826293249; Fri,
 23 Sep 2011 18:04:53 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Fri, 23 Sep 2011 18:04:53 -0700 (PDT)
In-Reply-To: <CAEsSSh2MDPgcFtrwYJ7uCDHBHPEfo35deE4dsWrb7Ukp7b310A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182015>

On Fri, Sep 23, 2011 at 6:41 PM, James B <coderer@gmail.com> wrote:
> I'm accessing a Git repository over an HTTPS transport, where client
> certificates are required. =C2=A0My certificate requires a password t=
o use,
> and Git prompts me for this every time I use it -- it's starting to
> get a little old. =C2=A0I've got Subversion set up to use Gnome-Keyri=
ng for
> credentials, so I only have to unlock that once per session. =C2=A0Is=
 there
> something similar for Git? =C2=A0Is it planned? =C2=A0If not, is ther=
e a good
> place to make feature requests?

It's being worked on -
http://www.google.com/search?q=3Dgit+credential+helper+site:gmane.org

j.
