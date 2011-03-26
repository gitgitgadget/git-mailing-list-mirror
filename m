From: Sam Vilain <sam@vilain.net>
Subject: Re: start of git2 (based on libgit2)
Date: Sat, 26 Mar 2011 19:33:19 +1300
Message-ID: <4D8D88AF.9010306@vilain.net>
References: <20110325231203.GA7961@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TW90aWVqdXMgSmFrxaF0eXM=?= <desired.mta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 07:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3N3x-0004zj-9L
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 07:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab1CZGdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2011 02:33:23 -0400
Received: from vilain.net ([60.234.254.246]:58161 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab1CZGdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 02:33:22 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 134C42E0AB; Sat, 26 Mar 2011 19:33:21 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on naos.lan
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
Received: from [192.168.1.83] (arcturus.local [192.168.1.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 032482E0A6;
	Sat, 26 Mar 2011 19:33:20 +1300 (NZDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20110325231203.GA7961@jakstys.lt>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170040>

On 26/03/11 12:12, Motiejus Jak=C5=A1tys wrote:
> Build tool. Currently libgit2 uses waf. I am not against it (I've cho=
sen
> waf for one of my own C++ projects), However, it's too clumsy for me.=
 Is
> it me who lacks experience? Scons looks much easier for me. Moreover,=
 we
> do not need automatic configuration, so it makes waf "overfeatured".

Another one you might like to look at is "ccanlint" - it wraps a whole
bunch of things that make for exceptional quality code, such as code
coverage by the test suite, documentation coverage, compilable examples=
,
even cranks it up using valgrind to check that it's right.

As far as your question about how much to implement or bring across fro=
m
git - try to do it feature by feature, with reference to the test suite
and make sure each feature has a test.  It's a very bad idea IMHO to
port across untested features.  I'd much rather have a core set of
commands which are well tested and stable, than a handful of
fully-implemented but buggy commands.

Sam
