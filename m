From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH 1/2] submodule: fix confusing variable name
Date: Sun, 4 Aug 2013 23:29:38 +0200
Message-ID: <20130804212938.GL19369@paksenarrion.iveqy.com>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
 <1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net>
 <20130803181415.GF2893@elie.Belkin>
 <51FE90B8.8030203@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 04 23:26:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V65p7-0007iK-9Y
	for gcvg-git-2@plane.gmane.org; Sun, 04 Aug 2013 23:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab3HDV0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Aug 2013 17:26:38 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:44032 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab3HDV0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Aug 2013 17:26:38 -0400
Received: by mail-lb0-f172.google.com with SMTP id o7so1598535lbv.3
        for <git@vger.kernel.org>; Sun, 04 Aug 2013 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TszXkq7wlhfr7P4acp7gi37b3i//POdupukmrsKQA2g=;
        b=QuQKLicGEDT3fO2qErTPXqnYmYXamWkcrXlF6JwwOuzJQe1KPXbo9QCA0xDe5e2+0c
         XmIbFxlt1mCJBv0SvDjDvRO2A77vm9YY5HDNwMvI+jKQWeMuuMZUh+Zq0GtQy+/4TuPM
         2aPZQPS/ic/eGgMtIKOor5DMgh9WGWb8gKx7XVYnpKQy22srY0hGMjG6aIB3pPcMSl4O
         y+9KicJ3Y4Y0RSmLOMlWaFFpy8zcBTxb67oGC/nBeUudlevT65L7yq91K2Otba9mqwj/
         5xPplxyRtlGZKsV4U2vh4+6pDVKTWf3fMUVga4AkIMOk+BrT0S4Q4LLhsQ+2R8dEYHBE
         uaAw==
X-Received: by 10.112.27.243 with SMTP id w19mr7749245lbg.2.1375651596484;
        Sun, 04 Aug 2013 14:26:36 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id k6sm8015343lae.9.2013.08.04.14.26.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 04 Aug 2013 14:26:35 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V65ru-0008U1-LA; Sun, 04 Aug 2013 23:29:38 +0200
Content-Disposition: inline
In-Reply-To: <51FE90B8.8030203@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231638>

On Sun, Aug 04, 2013 at 07:34:48PM +0200, Jens Lehmann wrote:
> But we'll have to use sm_path here (like everywhere else in the
> submodule script), because we'll run into problems under Windows
> otherwise (see 64394e3ae9 for details). Apart from that the patch
> is fine.

We're still using path=3D in the foreach-script. Or rather, we're setti=
ng
it. From what I can see and from the commit message 64394e3ae9 it could
possible be a problem.

Not sure how to solve it though... Just a simple correction would break
all script depending on that.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
