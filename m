From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t9001: use older Getopt::Long boolean prefix '--no'	rather
 than '--no-'
Date: Fri, 10 Oct 2008 19:44:36 -0500
Message-ID: <h06qyD79DtpYDO2W32USeygrtpn8V6dBogiNd6y5wtPVgMNDGwbl4A@cipher.nrlssc.navy.mil>
References: <zAKaSrh5XLrzXloxZrj-A1EletXL_wuSGpTQgLXMT3MZYK_o3tUBfA@cipher.nrlssc.navy.mil> <20081011002431.GK8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 02:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoScM-0002z6-OO
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 02:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbYJKAom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 20:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbYJKAom
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 20:44:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41693 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbYJKAol (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 20:44:41 -0400
Received: by mail.nrlssc.navy.mil id m9B0ibQP024309; Fri, 10 Oct 2008 19:44:39 -0500
In-Reply-To: <20081011002431.GK8203@spearce.org>
X-OriginalArrivalTime: 11 Oct 2008 00:44:37.0279 (UTC) FILETIME=[89901AF0:01C92B3A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97960>

Shawn O. Pearce wrote:
> Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> Since dbf5e1e9, the '--no-validate' option is a Getopt::Long boolean
>> option. The '--no-' prefix (as in --no-validate) for boolean options
>> is not supported in Getopt::Long version 2.32 which was released with
>> Perl 5.8.0. This version only supports '--no' as in '--novalidate'.
>> More recent versions of Getopt::Long, such as version 2.34, support
>> either prefix. So use the older form in the tests.
> 
> Ouch.
> 
> Should we update our docs?
> 
> Actually, if 2.32 doesn't support the --no-validate syntax than
> this is a regression in Git.  Even if it is what many would call a
> bug in Getopt::Long in Perl, I think Git 1.6.1 should still honor
> --no-validate like it did in Git 1.6.0.

If it makes any difference, none of the other boolean options would
work in the documented '--no-' form either, such as --no-thread,
--no-signed-off-by-cc, etc.  '--no-validate' is probably the only one
that used to work.


Update the docs?

---[no-]validate::
+--[no-|no]validate::

hmm. not sure.

-brandon
