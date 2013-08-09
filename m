From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH 1/2] submodule: fix confusing variable name
Date: Fri, 9 Aug 2013 19:26:32 +0200
Message-ID: <20130809172632.GB25779@paksenarrion.iveqy.com>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
 <1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net>
 <20130803181415.GF2893@elie.Belkin>
 <51FE90B8.8030203@web.de>
 <20130804212938.GL19369@paksenarrion.iveqy.com>
 <5203D8F6.2020102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, judge.packham@gmail.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 09 19:23:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7qPE-0004yb-8z
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 19:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758322Ab3HIRXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 13:23:07 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61639 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758317Ab3HIRXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 13:23:05 -0400
Received: by mail-lb0-f174.google.com with SMTP id w20so3389147lbh.19
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tvPkRFpBXRyQznxQc53KBdRkZeEL2gtsk2IILrRglu4=;
        b=xUuMzdZuwfmWI1B94idWvdoZQTvl3wD9OocQVIOE2CbCMEsQQL72rJ9Wt204I12uYS
         +t3wtcZmgYoUIxGiXfFr7gmREA524aaW/fJSTQX9f6A86tHN50zM+c0peUF1SfYLpwkq
         neQiaIoVY/1br4Q63IEK9vKTvudzQ2ybzXlQLFeWtSif4JYlXP64HKs2No8QIPKgDbLR
         f0ezriV7Uo5mLslyX72cJ0VJH3j/OeaPEtseh/p59qniItytORf0EU+jv+ZYMzjDis9l
         sXsokZAhrBol0Ed0AN8OvA/bUXzfFJiWCG/IxslflGk6YJaGVa1bWE88SfyalCJTG3Cb
         Bwcw==
X-Received: by 10.152.120.136 with SMTP id lc8mr6215942lab.89.1376068984168;
        Fri, 09 Aug 2013 10:23:04 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id k6sm7039968lae.9.2013.08.09.10.23.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 10:23:03 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V7qSO-00077q-PX; Fri, 09 Aug 2013 19:26:32 +0200
Content-Disposition: inline
In-Reply-To: <5203D8F6.2020102@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231999>

On Thu, Aug 08, 2013 at 06:44:22PM +0100, Ramsay Jones wrote:
> $path is part of the public API, so we can't just remove it. It would
> require a deprecation period, etc,.  (Adding/documenting $sm_path as =
an
> alternative *may* be worth doing. dunno.)

Maybe something for git 2.0? Well, Jens and Junio is the ones who can
make sane decissions about this. I trust they make a good decision. The
state as now is that this is a bug for case insesitive systems.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
