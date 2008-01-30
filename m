From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Thu, 31 Jan 2008 09:22:48 +1300
Message-ID: <47A0DC98.9080406@vilain.net>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org> <20080130042201.GO24004@spearce.org> <47A01162.7070503@vilain.net> <20080130083528.GC8698@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 21:22:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKJSC-0003gp-7U
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 21:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932850AbYA3UVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 15:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933738AbYA3UVm
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 15:21:42 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:56395 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932914AbYA3UVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 15:21:40 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id D8A7421D152; Thu, 31 Jan 2008 09:21:37 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 7F22121D116;
	Thu, 31 Jan 2008 09:21:32 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080130083528.GC8698@artemis.madism.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72064>

Pierre Habouzit wrote:
>> The Perl Crypt::OpenPGP module doesn't suffer from this problem (and is
>> performant), though it suffers from a dependency stack that will hurt
>> everyone except Debian users ;-).
> 
>   Actually, if it's engineered like libgpgme (gpg made easy) is, well,
> it basically wraps calls to gpg, a thing that we can do ourselves easily
> usually :)

It's nothing like gpgme - it brings together all of the Perl modules
that together implement PGP completely.  It doesn't use gpg.

Sam.
