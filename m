From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn clone fails
Date: Wed, 2 Sep 2015 02:27:57 +0000
Message-ID: <20150902022757.GA7143@dcvr.yhbt.net>
References: <mpa8th$m80$1@ger.gmane.org>
 <mppsku$h97$1@ger.gmane.org>
 <mqk6mb$qi8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?SsO2cmc=?= Schaible <joerg.schaible@swisspost.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 04:33:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWxrQ-0004vc-1w
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 04:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbbIBCdL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 22:33:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36089 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751970AbbIBCdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 22:33:10 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2015 22:33:10 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103C81FAAF;
	Wed,  2 Sep 2015 02:27:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <mqk6mb$qi8$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277074>

J=C3=B6rg Schaible <joerg.schaible@swisspost.com> wrote:
> Is there really no other place for a bug report? This will simply van=
ish in=20
> the list's noise ...

These messages do get seen and read.  (And I would not have seen this
message if it were posted anywhere else).

But I don't have much time or motivation to work on git svn since it's
mostly made itself obsolete for me.

--preserve-empty-dirs probably hasn't seen much real-world use and
(IIRC) not something that could always be 100% reliable.

Regardless of options, git svn does log empty directories, so there's
also an obscure, probably equally-unused "git svn mkdirs" command which
processes the unhandled.log files inside $GIT_DIR to recreate empty
directories.  You could give that a try.
