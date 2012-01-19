From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Thu, 19 Jan 2012 11:24:07 +0100
Message-ID: <87k44oat2w.fsf@thomas.inf.ethz.ch>
References: <loom.20120112T193624-86@post.gmane.org>
	<4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de>
	<4F1085EC.9010708@ira.uka.de> <4F128AD0.5020101@unclassified.de>
	<4F1404E7.9040805@ira.uka.de> <4F14718B.80209@unclassified.de>
	<87r4yzzcci.fsf@thomas.inf.ethz.ch> <4F152767.9010104@unclassified.de>
	<87ipkaogyj.fsf@thomas.inf.ethz.ch> <4F15B65A.8070009@unclassified.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, Jeff King <peff@peff.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	<git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Thu Jan 19 11:24:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnpAQ-000478-35
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 11:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab2ASKYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 05:24:20 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:5169 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab2ASKYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 05:24:11 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 11:24:08 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Jan
 2012 11:24:08 +0100
In-Reply-To: <4F15B65A.8070009@unclassified.de> (Yves Goergen's message of
	"Tue, 17 Jan 2012 18:56:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188806>

Glad that you could fix your repository.

Yves Goergen <nospam.list@unclassified.de> writes:

> Just like that stupid autocrlf that causes more issues than it solves. I
> regularly see files with all lines changed and the diff says that both
> files only differ in line endings. But I have no sure observation on
> whether that value was set or unset in those cases. I'll have to look
> after that, too.

Just please remember what I tried to teach you in this thread: copy and
paste actual command invocations and outputs, and let us do the
interpretation.  With CRLF problems, it may in addition help to pipe
through a utility that shows the presence or absence of \r, such as 'cat
-v'.

> These two config settings are not cloned with the repository, are they?

Neither config nor hooks are cloned.

> Also, TortoiseGit already sets ignorecase = true. So maybe the Visual
> Studio provider does the init on its own and is missing that. Or I have
> at some time cloned the repository and the setting wasn't copied over.

git-clone also autodetects the setting as part of initializing the
clone.  (Copying over the repository from a case-sensitive medium using
a case-sensitive OS would of course leave it unset.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
