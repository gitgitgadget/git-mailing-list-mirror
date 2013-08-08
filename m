From: gitml.jexpert@recursor.net
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
 (gitml: message 5 of 20)
Date: Thu, 08 Aug 2013 15:43:36 +0200
Message-ID: <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net> <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr> <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> <vpqfvukfgr5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 15:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7QVE-0002hF-62
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 15:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757835Ab3HHNnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 09:43:40 -0400
Received: from gourmet7.spamgourmet.com ([216.75.62.102]:48221 "EHLO
	gourmet8.spamgourmet.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751797Ab3HHNnj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 09:43:39 -0400
Received: from spamgourmet by gourmet7.spamgourmet.com with local (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7QV9-0002OC-1W
	for git@vger.kernel.org; Thu, 08 Aug 2013 13:43:39 +0000
Received: from mail.exxcellent.de ([217.6.238.198])
	by gourmet7.spamgourmet.com with esmtp (Exim 4.80)
	(envelope-from <gitml.jexpert@recursor.net>)
	id 1V7QV8-0002NF-Gp; Thu, 08 Aug 2013 13:43:38 +0000
In-Reply-To: <vpqfvukfgr5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231887>

> Using
> 
>   addr2line -e ~/projects/git.git/git-fsck
> 
> on these addresses may help a little, but not sure it's going to be
> sufficient :-(.


I'm still trying to reproduce this issue using gdb.
Also I'm trying to reproduce this issue with my git repo on another machine.

ben@n179 /tmp $ addr2line -e ~/projects/git.git/git-fsck
0x51e401
0x51e53c
0x51ecc3
0x4e707b
0x4e7485
0x43d433
0x405158
0x4052ee
0x4054ba
/home/ben/projects/git.git/sha1_file.c:1901
/home/ben/projects/git.git/sha1_file.c:1928
/home/ben/projects/git.git/sha1_file.c:2096
/home/ben/projects/git.git/pack-check.c:119
/home/ben/projects/git.git/pack-check.c:177
/home/ben/projects/git.git/builtin/fsck.c:678
/home/ben/projects/git.git/git.c:291
/home/ben/projects/git.git/git.c:453
/home/ben/projects/git.git/git.c:543
