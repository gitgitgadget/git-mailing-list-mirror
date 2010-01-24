From: "Bernhard R. Link" <brlink@debian.org>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sun, 24 Jan 2010 20:04:24 +0100
Organization: 
Message-ID: <20100124190424.GA30585@pcpool00.mathematik.uni-freiburg.de>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <201001232141.49556.j6t@kdbg.org> <fabb9a1e1001231301o149bb13es236a7150f57ce161@mail.gmail.com> <201001241457.43297.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 24 20:31:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ8Bc-00032n-0l
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 20:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab0AXTbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 14:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900Ab0AXTbs
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 14:31:48 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:48407
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984Ab0AXTbs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jan 2010 14:31:48 -0500
X-Greylist: delayed 1642 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jan 2010 14:31:47 EST
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NZ7l2-0001IO-LC; Sun, 24 Jan 2010 20:04:24 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NZ7l2-0007zA-J7; Sun, 24 Jan 2010 20:04:24 +0100
Content-Disposition: inline
In-Reply-To: <201001241457.43297.trast@student.ethz.ch>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137916>

* Thomas Rast <trast@student.ethz.ch> [100124 14:58]:
> POSIX specifies that multiple slashes must be treated as if they were
> a single slash (except as in the next bullet point).  Leading _double_
> slashes may be treated implementation-dependently. [1]  Non-leading
> double slashes do not seem to be specified.

http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap03.html#tag_03_266

| 3.266 Pathname
|
| A character string that is used to identify a file. In the context of
| IEEE Std 1003.1-2001, a pathname consists of, at most, {PATH_MAX} bytes,
| including the terminating null byte. It has an optional beginning
| slash, followed by zero or more filenames separated by slashes. A
| pathname may optionally contain one or more trailing slashes.
| Multiple successive slashes are considered to be the same as one
| slash.
