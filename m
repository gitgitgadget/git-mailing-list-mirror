From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 4/4 v3] Add cat-blob report fifo from fast-import to remote-helper.
Date: Sat, 21 Jul 2012 17:24:45 +0200
Message-ID: <3246520.u1PcGtbf0N@flobuntu>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <2448876.O3MA5kWbuX@flobuntu> <20120721144834.GB19860@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:25:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsbY8-0005PM-Th
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab2GUPYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 11:24:51 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33748 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab2GUPYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:24:51 -0400
Received: by bkwj10 with SMTP id j10so4150751bkw.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=yglttpKxzDuFcf+62DRBED+YcDvFGyF87JGHry2xIsI=;
        b=xYwcdUdKc2k20jwANAoXNxXx+5YK+ln2WAbMTpAEjqV/dC4UiRIwLZSxvkoXjG4T3Z
         SHuN+5Xd80R6bS6mwFgkXSefpnMNUcApVaaJteQwnNKGikP3uwFpwgcq7vujxSxI6fxq
         v9lbr4BdkOjL9gBONYMzQIfKNQc1TcjUKa5KynrVN8EvmLecZmT0MZrm4r87s7h9EFg5
         QTyspUg6im33QrekMcuYSZWuWW277nq+s/2KMR7n+bPW7k0VMA9hE3fQ8k8xAblq4OV6
         hnWhIKJmfHO3DSpIPQ1UBhSe4VpDiz4nzc9Vdh3aOHkjzctNLko09YU8tJ+XROpk7YQn
         Uvdw==
Received: by 10.204.130.146 with SMTP id t18mr4848608bks.65.1342884289659;
        Sat, 21 Jul 2012 08:24:49 -0700 (PDT)
Received: from flobuntu.localnet (93-82-157-153.adsl.highway.telekom.at. [93.82.157.153])
        by mx.google.com with ESMTPS id hg13sm4207956bkc.7.2012.07.21.08.24.47
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 08:24:48 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120721144834.GB19860@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201811>

On Saturday 21 July 2012 09:48:34 Jonathan Nieder wrote:
> To sum up: I think we should just stick to pipes --- why all this fifo
> complication?

People didn't like pipe variant (prexec_cb not being compatible to windows' 
process creation model), so I learned about fifos and implemented a (basic) fifo 
variant. *shrug*

-- 
Florian
