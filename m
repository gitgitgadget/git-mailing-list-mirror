From: David Turner <dturner@twopensource.com>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Fri, 04 Jul 2014 18:58:22 -0700
Organization: Twitter
Message-ID: <1404525502.3109.25.camel@stross>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
	 <1404505370.3109.15.camel@stross>
	 <CAA787rmf36V1=Sd8TZrc7DboTkeJDYKuEGgCe90mZLLKSp6=tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=D8yvind?= "A. Holm" <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Sat Jul 05 03:58:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3FFe-0005l3-P9
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 03:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbaGEB6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2014 21:58:42 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36754 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbaGEB6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 21:58:42 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so2583822pde.3
        for <git@vger.kernel.org>; Fri, 04 Jul 2014 18:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=Fu/HPv4uQ8wIICG7XRmViPcmFKzjj8b3jFdmBrMZCaU=;
        b=A/qaT0GPXZxRQbbVzJdKT37gcXX1el58JAlkW3fAIBURBC41Gu+FQtP0h9zvDS7CEe
         PAgz+XlkhHDI4i3jg7bT3nYx4CApp4GFVTV6/XpuVx83foGI0ZQwFiDPserrL22IMZBn
         DwZwXKtu9FuhKodcc5YCnOr7DDhPwSMewjpKPV+UTDHviLni7FadkOrEjl73Vqnmu+nU
         YG0/g1viMV2OysI9KOqRpx5hOb04FEXxp7Ec1VegwdpGS0zckK4YD9typXGe0cDKjt/k
         a6ZsQPRUWWtZqdlRDUBWQ0XxgHk86r/jgpbdgw5NtYP6sb29QVkyIrZxt2rteQlvCI2t
         s6oA==
X-Gm-Message-State: ALoCoQmTYQniwZNYlC9VFPmUE0ohAHrF5GnhXee2IZdB0v0GybvPOwUhXXozPlb62JbHk0qo5o76
X-Received: by 10.66.152.35 with SMTP id uv3mr13858765pab.74.1404525521361;
        Fri, 04 Jul 2014 18:58:41 -0700 (PDT)
Received: from [10.0.14.220] (50-206-59-106-static.hfc.comcastbusiness.net. [50.206.59.106])
        by mx.google.com with ESMTPSA id oo3sm10502130pdb.19.2014.07.04.18.58.39
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 04 Jul 2014 18:58:40 -0700 (PDT)
In-Reply-To: <CAA787rmf36V1=Sd8TZrc7DboTkeJDYKuEGgCe90mZLLKSp6=tw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252913>

On Sat, 2014-07-05 at 02:09 +0200, =C3=98yvind A. Holm wrote:
<snip>
> The test works. Seems as there's something fishy about the use of
> --prefix in this specific commit (v2.0.1-472-g6f92e5f).

Ok, now I can reproduce on my linode box (haven't tried it locally yet)=
=2E
I'll try to get a fix up once I figure out what's up.

Thanks for the report.
