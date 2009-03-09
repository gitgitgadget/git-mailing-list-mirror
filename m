From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PoC PATCH JGIT 0/2] Proof of concept code for Git
	Freenet transport
Date: Mon,  9 Mar 2009 11:36:03 +0800
Message-ID: <1236569765-8882-1-git-send-email-j16sdiz+freenet@gmail.com>
Reply-To: Discussion of development issues <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org,
	git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org Mon Mar 09 04:37:46 2009
Return-path: <devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
Envelope-to: gcfd-devl-602-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from emu.freenetproject.org ([89.16.176.201] helo=freenetproject.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgWJF-0005hK-Sw
	for gcfd-devl-602-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Mar 2009 04:37:45 +0100
Received: by freenetproject.org (Postfix, from userid 108)
	id B3025478727; Mon,  9 Mar 2009 03:36:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	emu.dh.bytemark.co.uk
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=5.0 tests=AWL,BAYES_00,
	FORGED_RCVD_HELO,SPF_PASS autolearn=ham version=3.1.7-deb3
Received: from emu.dh.bytemark.co.uk (localhost.localdomain [127.0.0.1])
	by freenetproject.org (Postfix) with ESMTP id 0B2EA478702;
	Mon,  9 Mar 2009 03:36:19 +0000 (UTC)
X-Original-To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Delivered-To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Received: by freenetproject.org (Postfix, from userid 108)
	id E47A747871B; Mon,  9 Mar 2009 03:36:15 +0000 (UTC)
Received-SPF: pass (emu.dh.bytemark.co.uk: domain of j16sdiz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
	designates 209.85.200.169 as permitted sender)
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by freenetproject.org (Postfix) with ESMTP id 5EC3547867B
	for <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>; Mon,  9 Mar 2009 03:36:12 +0000 (UTC)
Received: by wf-out-1314.google.com with SMTP id 27so1796865wfd.22
	for <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>; Sun, 08 Mar 2009 20:36:11 -0700 (PDT)
Received: by 10.142.113.19 with SMTP id l19mr2334060wfc.10.1236569771605;
	Sun, 08 Mar 2009 20:36:11 -0700 (PDT)
Received: from localhost.localdomain (n058153086094.netvigator.com
	[58.153.86.94])
	by mx.google.com with ESMTPS id 29sm7732622wfg.53.2009.03.08.20.36.10
	(version=TLSv1/SSLv3 cipher=RC4-MD5);
	Sun, 08 Mar 2009 20:36:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.rc2
X-BeenThere: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussion of development issues <devl.freenetproject.org>
List-Unsubscribe: <http://emu.freenetproject.org/cgi-bin/mailman/listinfo/devl>, 
	<mailto:devl-request-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://emu.freenetproject.org/pipermail/devl>
List-Post: <mailto:devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
List-Help: <mailto:devl-request-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org?subject=help>
List-Subscribe: <http://emu.freenetproject.org/cgi-bin/mailman/listinfo/devl>, 
	<mailto:devl-request-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org?subject=subscribe>
Sender: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Errors-To: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112673>

Hi JGit / Freenet community,

Here is some proof-of-concept code for Git-over-Freenet.
I am sending this to see the feedback from communities.

The code need some more cleanups, so it it is not ready for apply (yet).

This is a real-life example

Push:
   $ git remote add fcp fcp://SSK@[my public key]^[my private key]/test.git
   $ ./jgit push fcp refs/remotes/origin/stable:refs/heads/master
 
 /ALTERNATIVLY/

   Insert a bare repository under USK@<.....>/test.git/-1/

Pull:
 $ ./jgit clone fcp://SSK@[my public key]^[my private key]/test.git


To workaround the metadata update problem, this client translate the
path seperator to "-", that means:

On push:
   objects/aa/bbbbbbbb   --> USK@..../test.git-objects-aa-bbbbbbb/-1/
   refs/heads/xxx        --> USK@..../test.git-objects-ref-heads-xxx/-1/

On pull:
   To support uploading from jSite, 
    when we load the info/refs we first check USK@..../test.git-info-refs/-1/
    if it is unavailiable, we would use USK@..../test.git/-1/info/refs

   The "traditional" type (USK@..../test.git/-1/objects) repository is
   always added as an alternative objects database. No other info/alternatives 
   are supported

FIXME:
 - How to store the private key of repository?
   Currently, we use URI of form fcp://SSK@<public key>^<private key>/some-id
   This is quite ugly. Could we use a per remote Config ? How can I get remote
   name from transport?

 - Make pushing async, could we?
