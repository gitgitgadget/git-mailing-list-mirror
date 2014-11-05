From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [Opinions] Integrated tickets
Date: Wed, 5 Nov 2014 13:44:29 +0100
Message-ID: <20141105124429.GF15384@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 13:38:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xlzqw-0000no-3r
	for gcvg-git-2@plane.gmane.org; Wed, 05 Nov 2014 13:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbaKEMiR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Nov 2014 07:38:17 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45348 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbaKEMiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 07:38:13 -0500
Received: by mail-lb0-f174.google.com with SMTP id p9so556589lbv.19
        for <git@vger.kernel.org>; Wed, 05 Nov 2014 04:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=xBt/srdT+ZZVUbJe1c6TkiZa8eGNCEh9xuJFMJkoW48=;
        b=z6FOnL/a4bakfAlwVflqL/igNIeQKVi0vGm3ae8F9K6OcX76JzGVDHaURAD2qyV1/U
         cll/ZnYs6JP4ISpDB4fs7vCo8AAbLFZuxtKo4cA2sKNKlhqnmV6wSiTtNvjoKnhKJSVW
         8SwmMA9pTK3GT2SE4HD6NvJ5OS+1rvLikW7lmaC3giGE1IjksZqAxZzSp+KeUnGSinHh
         cEV0drqWM0eZ/K1cai7kcArN5VXJl07ChMvLqbujEiAsowb+iEl6AkiwNkyeyswV+8Ns
         AkciYyHh/SsMEFJxydjyzFrntaxAZXJFCgpL0Oh+vJ5bzRC+4I3KqrNDZuzWo9LEiJF8
         OLnQ==
X-Received: by 10.152.204.99 with SMTP id kx3mr464334lac.53.1415191091690;
        Wed, 05 Nov 2014 04:38:11 -0800 (PST)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id an6sm1269493lac.18.2014.11.05.04.38.10
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Nov 2014 04:38:11 -0800 (PST)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Xlzwr-0008Kn-JV
	for git@vger.kernel.org; Wed, 05 Nov 2014 13:44:29 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
many developers rely on ticket systems (githubs issues, trac, bugzilla,
etc.). To me a ticket often has a relation to one or more commits.

Hence, even if git is functional in an offline enviroment, I can't work
fully since none of the ticket systems above is distributed.

This can be solved with a distributed ticket system. Fossil SCM is one
example of an integrated ticket system into a scm (although please don'=
t
think about this is something that must be web-based).

So my question is:

what's your opinions on building an integrated ticket system on top of =
git?

and (maybe mostly for Junio)

Would such system possible be included in git.git?

TL;DR;
Is an integrated ticket system something for git?
--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
