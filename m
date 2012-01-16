From: Yves Goergen <nospam.list@unclassified.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Mon, 16 Jan 2012 19:50:51 +0100
Message-ID: <4F14718B.80209@unclassified.de>
References: <loom.20120112T193624-86@post.gmane.org> <4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de> <4F1085EC.9010708@ira.uka.de> <4F128AD0.5020101@unclassified.de> <4F1404E7.9040805@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?B?Q2FybG9zIE1h?= =?UTF-8?B?cnTDrW4gTmlldG8=?= 
	<cmn@elego.de>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 19:51:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmrem-0001t4-Om
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 19:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313Ab2APSvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 13:51:08 -0500
Received: from dotforward.de ([178.63.102.138]:42587 "EHLO dotforward.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755951Ab2APSvF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 13:51:05 -0500
Received: from dsl01.212.114.235.128.ip-pool.nefkom.net ([212.114.235.128] helo=[192.168.1.13])
	by dotforward.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <nospam.list@unclassified.de>)
	id 1Rmrdr-0004nZ-Ki; Mon, 16 Jan 2012 19:50:51 +0100
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F1404E7.9040805@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188639>

It's getting more weird. I believe that (msys)Git doesn't really know
how the filesystem on its operating system works. I have made some more
changes now and want to commit them. TortoiseGit reports the files
Form1.Designer.cs and Form1.designer.cs (note the case difference) as
modified and ready to commit. How is that supposed to work? On Windows,
file names are case-insensitive (as on MacOS X) and both names refer to
the absolute same file. 'git status' has the very same listing with that
same file twice.

What else is now broken in my repository?

If the index is such a problem child, how can I safely delete it
completely and maybe have it regenerated if Git can't live without it?

-- 
Yves Goergen "LonelyPixel" <nospam.list@unclassified.de>
Visit my web laboratory at http://beta.unclassified.de
