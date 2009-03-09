From: Daniel Cheng <j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PoC PATCH JGIT 0/2] Proof of concept code for
	Git Freenet transport
Date: Mon, 9 Mar 2009 13:58:57 +0800
Message-ID: <ff6a9c820903082258q24fd6cefh4bc528e79cecedf3@mail.gmail.com>
References: <1236569765-8882-1-git-send-email-j16sdiz+freenet@gmail.com>
Reply-To: Discussion of development issues <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org Mon Mar 09 07:00:42 2009
Return-path: <devl-bounces-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>
Envelope-to: gcfd-devl-602-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from emu.freenetproject.org ([89.16.176.201] helo=freenetproject.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgYXO-0005I7-O5
	for gcfd-devl-602-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Mar 2009 07:00:30 +0100
Received: by freenetproject.org (Postfix, from userid 108)
	id 71A2A47872B; Mon,  9 Mar 2009 05:59:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	emu.dh.bytemark.co.uk
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=AWL,BAYES_00,SPF_PASS 
	autolearn=unavailable version=3.1.7-deb3
Received: from emu.dh.bytemark.co.uk (localhost.localdomain [127.0.0.1])
	by freenetproject.org (Postfix) with ESMTP id 101EE478698;
	Mon,  9 Mar 2009 05:59:05 +0000 (UTC)
X-Original-To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Delivered-To: devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org
Received: by freenetproject.org (Postfix, from userid 108)
	id 6E5E647871B; Mon,  9 Mar 2009 05:59:02 +0000 (UTC)
Received-SPF: pass (emu.dh.bytemark.co.uk: domain of j16sdiz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
	designates 209.85.146.176 as permitted sender)
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by freenetproject.org (Postfix) with ESMTP id 603A54785AB
	for <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>; Mon,  9 Mar 2009 05:58:59 +0000 (UTC)
Received: by wa-out-1112.google.com with SMTP id j32so852924waf.6
	for <devl-RdDMkVZAZeuJnvDnx1genB2eb7JE58TQ@public.gmane.org>; Sun, 08 Mar 2009 22:58:57 -0700 (PDT)
Received: by 10.114.197.10 with SMTP id u10mr3304011waf.174.1236578337543; 
	Sun, 08 Mar 2009 22:58:57 -0700 (PDT)
In-Reply-To: <1236569765-8882-1-git-send-email-j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-Google-Sender-Auth: 9ad76130066fd666
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112678>

On Mon, Mar 9, 2009 at 11:36 AM, Daniel Cheng (aka SDiZ)
<j16sdiz+freenet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi JGit / Freenet community,
>
> Here is some proof-of-concept code for Git-over-Freenet.
> I am sending this to see the feedback from communities.

Sorry, all. The code I have posted wasn't work.
(the pack file is missing on push, only idx files are pushed)

The new, fixed code is now available at http://github.com/j16sdiz/egit-free=
net/
Please use this repository if you want to actually try it.

>
> The code need some more cleanups, so it it is not ready for apply (yet).
>
> This is a real-life example
>
> Push:
> =A0 $ git remote add fcp fcp://SSK@[my public key]^[my private key]/test.=
git
> =A0 $ ./jgit push fcp refs/remotes/origin/stable:refs/heads/master
>
> =A0/ALTERNATIVLY/
>
> =A0 Insert a bare repository under USK@<.....>/test.git/-1/
>
> Pull:
> =A0$ ./jgit clone fcp://SSK@[my public key]^[my private key]/test.git
>
>
> To workaround the metadata update problem, this client translate the
> path seperator to "-", that means:
>
> On push:
> =A0 objects/aa/bbbbbbbb =A0 --> USK@..../test.git-objects-aa-bbbbbbb/-1/
> =A0 refs/heads/xxx =A0 =A0 =A0 =A0--> USK@..../test.git-objects-ref-heads=
-xxx/-1/
>
> On pull:
> =A0 To support uploading from jSite,
> =A0 =A0when we load the info/refs we first check USK@..../test.git-info-r=
efs/-1/
> =A0 =A0if it is unavailiable, we would use USK@..../test.git/-1/info/refs
>
> =A0 The "traditional" type (USK@..../test.git/-1/objects) repository is
> =A0 always added as an alternative objects database. No other info/altern=
atives
> =A0 are supported
>
> FIXME:
> =A0- How to store the private key of repository?
> =A0 Currently, we use URI of form fcp://SSK@<public key>^<private key>/so=
me-id
> =A0 This is quite ugly. Could we use a per remote Config ? How can I get =
remote
> =A0 name from transport?
>
> =A0- Make pushing async, could we?
>
>
>
