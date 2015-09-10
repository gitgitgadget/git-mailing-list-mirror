From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: parse authors file more leniently
Date: Thu, 10 Sep 2015 18:08:10 +0000
Message-ID: <20150910180810.GA22112@dcvr.yhbt.net>
References: <5613050.3arVUQYvEz@granit>
 <03f07c11135aef9e04a26e5b1018d726ba2fab5d.1441887195.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Till =?utf-8?Q?Sch=C3=A4fer?= <till2.schaefer@tu-dortmund.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za6Ge-00065B-0p
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbbIJSIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2015 14:08:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55969 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbbIJSIL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:08:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62601F6F9;
	Thu, 10 Sep 2015 18:08:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <03f07c11135aef9e04a26e5b1018d726ba2fab5d.1441887195.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277620>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Instead, make git svn uses the perl regex
>=20
> /^(.+?|\(no author\))\s*=3D\s*(.+?)\s*<(.*)>\s*$/
>=20
> for parsing the authors file so that the same (slightly more lenient)
> regex is used in both cases.
>=20
> Reported-by: Till Sch=C3=A4fer <till2.schaefer@tu-dortmund.de>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Thanks.
Signed-off-by: Eric Wong <normalperson@yhbt.net>

And pushed to master of git://bogomips.org/git-svn
(commit f7c6de0ea1bd5722a1181c6279676c6831b38a34)

By the way, I also had some other patches sitting around for you.
Did you ever have time to revisit them?  (I haven't)

      t/lib-httpd: load mod_unixd
      t/lib-git-svn: check same httpd module dirs as lib-httpd
