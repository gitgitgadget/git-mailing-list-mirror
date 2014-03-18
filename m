From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 18 Mar 2014 21:27:19 +0700
Message-ID: <20140318142719.GA9393@lanh>
References: <20140311014945.GB12033@sigill.intra.peff.net>
 <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
 <20140311200513.GB29102@sigill.intra.peff.net>
 <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
 <20140311203650.GA31173@sigill.intra.peff.net>
 <CACsJy8AZ0CfqHRYDrnQD+z0ibVQnsFuSzktEHKRhCVwaXPQryg@mail.gmail.com>
 <CAJo=hJvy6KKMNT9iyZAnKy18Pa+rQkKPQtfqT1e+ddXoVwX0yg@mail.gmail.com>
 <CACsJy8DtuCCYmmsEFB_m-YPHOOQ4FuchvnYQeuv75-vcSMej_w@mail.gmail.com>
 <CAJo=hJuGBgkseQ_mvbxFnYbkFDDWEuassf2+ttj_F53AMzU_Nw@mail.gmail.com>
 <20140318041739.GA7252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 15:26:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPuya-0002pB-Dt
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 15:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbaCRO0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 10:26:39 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:41532 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbaCRO0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 10:26:38 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so7097089pdj.26
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=thZOR5R6aDtnCbwT33JSmDzF03sm2pmPvJQA/TdcIqw=;
        b=WenQJ3aWqi48sDX2XgClv5iDNqRP8tQoQIp/DeQc7WYWvlRdOv6Oglz3tbND9LG3pq
         ymS6jqO3PYMtARcynJKSljQ2fSAlhwXOWyA6bLizfVsrsAuBZitF2ITxiWAtV6TEzv6t
         hY2baBrtaTsNZIxVSqNHkuFbVm0y/QfYUqGVc0M0VyekRT4jd4TpJZ86bwBXUzcmPDrF
         p9f58D1dnPkISDcL7ia3MLMeJkOzlFJTzSl+wsgx+mOqapo5AjWdJ3RQGWkYb5JhavgF
         4B2uqym2hKf2z4OXLYahVoOJn1Ne8PWK2jTw8hWWR5q40W5ANbEtsD15T8HJ9A8fVlD4
         x8qA==
X-Received: by 10.66.252.135 with SMTP id zs7mr33845335pac.13.1395152797646;
        Tue, 18 Mar 2014 07:26:37 -0700 (PDT)
Received: from lanh ([115.73.237.95])
        by mx.google.com with ESMTPSA id qw8sm53178245pbb.27.2014.03.18.07.26.32
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Mar 2014 07:26:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Mar 2014 21:27:19 +0700
Content-Disposition: inline
In-Reply-To: <20140318041739.GA7252@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244356>

On Tue, Mar 18, 2014 at 12:17:39AM -0400, Jeff King wrote:
> On Fri, Mar 14, 2014 at 05:09:45PM -0700, Shawn Pearce wrote:
> 
> > On Fri, Mar 14, 2014 at 4:30 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > > On Fri, Mar 14, 2014 at 11:45 PM, Shawn Pearce <spearce@spearce.org> wrote:
> > >>
> > >> You missed the SSH case. It doesn't have this slot to hide the data into.
> > >
> > > Right now we run this for ssh case: "ssh <host> git-upload-pack
> > > <repo-path>". New client can do this instead
> > >
> > > ssh <host> git-upload-pack <repo-path> <client capability flags>
> > 
> > Older servers will fail on this command, and the client must reconnect
> > over SSH, which may mean supplying their password/passphrase again.
> > But its remembered that the uploadPack2 didn't work so this can be
> > blacklisted and not retried for a while.
> 
> I wonder if we could use the environment for optional values. E.g., can
> we run:
> 
>   ssh host GIT_CAPABILITIES=... git-upload-pack <repo-path>
> 
> That will not work everywhere, of course. Sites with git-shell will
> fail, as will sites with custom ssh handler (GitHub, for example, and I
> imagine Gerrit sites, if they support ssh). So we'd still need some
> fallback, but it would work out-of-the-box in a reasonable number of
> cases (and it is really not that different than the http case, which is
> just stuffing the values into $QUERY_STRING anyway :) ).

Aggressively gc'ing linux-2.6 takes forever (and it's being timed so I
can't really do any heavy lifting), so I outlined what the new
protocol would be instead.

Note that at least for upload-pack client capabilities can be
advertised twice: the first time at transport connection level, the
second time in the first "want", like in v1. I think this will keep
the code change down when we have to support both protocols. Moving
all capabilities to the first negotiation may touch many places, but
that's for now a baseless guess.

The new capability negotiation is also added for push. We didn't pay
much attention to it so far.

I thought about "GIT_CAPABILITIES= git-upload-pack ..." (and actually
added it in pack-protocol.txt then deleted). The thing is, if you want
to new upload-pack, you would need new git-upload-pack at the remote
end that must understand "git-upload-pack <repo> <caps>"
already. Making it aware about GIT_CAPABILITIES is extra cost for
nothing. And we have to update git-shell to support it eventually.

Well, the "must understand" part is not entirely true. If you make
git-daemon pass the early capabilities via GIT_CAPABILITIES too,
upload-pack does not have to support "<repo> <caps>" syntax. The
upside is if old git-upload-pack ignores this GIT_CAPABILITIES, it'll
break the protocol (see below) and can print friendly error
messages. git-daemon has no way of printing friendly messages because
it can't negotiate side-band.

I'm still not sure. But we should support either way, not both. Anyway
the text for new protocols:

-- 8< --
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 79e5768..c329eb1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2084,6 +2084,16 @@ remote.pushdefault::
 	`branch.<name>.remote` for all branches, and is overridden by
 	`branch.<name>.pushremote` for specific branches.
 
+remote.useUploadPack2::
+	Set to "always" to use only upload-pack version 2, "never" to
+	always use the original "upload-pack", "auto" to use the
+	original protocol, but if the remote claims it support version
+	2, then set "remote.<name>.useUploadPack2" to
+	"always". Default to "auto".
+
+remote.<name>.useUploadPack2::
+	Override remote.useUploadPack2 per remote.
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 39c6410..3db4219 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -40,15 +40,22 @@ hostname parameter, terminated by a NUL byte.
 
    0032git-upload-pack /project.git\0host=myserver.com\0
 
+Some service may accept an extra argument (e.g. upload-pack version
+2). The extra argument must follow "host".
+
+   0042git-upload-pack /project.git\0host=myserver.com\0flags=someflags\0
+
 --
-   git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
+   git-proto-request = request-command SP pathname NUL
+		       [ host-parameter NUL [ flags-parameter NUL ] ]
    request-command   = "git-upload-pack" / "git-receive-pack" /
 		       "git-upload-archive"   ; case sensitive
    pathname          = *( %x01-ff ) ; exclude NUL
    host-parameter    = "host=" hostname [ ":" port ]
+   flags-parameter   = "flags=" *( %x01-ff ) ; exclude NULL
 --
 
-Only host-parameter is allowed in the git-proto-request. Clients
+No other parameters are allowed in the git-proto-request. Clients
 MUST NOT attempt to send additional parameters. It is used for the
 git-daemon name based virtual hosting.  See --interpolated-path
 option to git daemon, with the %H/%CH format characters.
@@ -77,6 +84,11 @@ It is basically equivalent to running this:
 
    $ ssh git.example.com "git-upload-pack '/project.git'"
 
+Some service may accept an extra argument (e.g. upload-pack version
+2). The extra argument is appended, e.g.
+
+   $ ssh git.example.com "git-upload-pack '/project.git' 'extra-flags'"
+
 For a server to support Git pushing and pulling for a given user over
 SSH, that user needs to be able to execute one or both of those
 commands via the SSH shell that they are provided on login.  On some
@@ -124,6 +136,20 @@ has, the first can 'fetch' from the second.  This operation determines
 what data the server has that the client does not then streams that
 data down to the client in packfile format.
 
+Initial capability negotiation
+------------------------------
+
+When the client connects to the server with the extra argument,
+upload-pack version 2 is used. Otherwise the original version is
+used. Unless explicitly stated, the original version is implied.
+
+When the client initially connects to the server using upload-pack
+version 2, the server MUST reply with one pkt-line describing its
+capabilities. Capabilities that are recognized by both ends are
+immediately effective.
+
+By default, upload-pack version 1's reference discovery will follow
+unless some capability makes it different.
 
 Reference Discovery
 -------------------
@@ -447,9 +473,14 @@ Reference Discovery
 
 The reference discovery phase is done nearly the same way as it is in the
 fetching protocol. Each reference obj-id and name on the server is sent
-in packet-line format to the client, followed by a flush-pkt.  The only
-real difference is that the capability listing is different - the only
-possible values are 'report-status', 'delete-refs' and 'ofs-delta'.
+in packet-line format to the client, followed by a flush-pkt. Or with
+receive-pack version 2, a separate pkt-line containing capabilities is
+sent back, then followed by reference discovery unless some capability
+changes it.
+
+The only real difference is that the capability listing is different -
+the only possible values are 'report-status', 'delete-refs' and
+'ofs-delta'.
 
 Reference Update Request and Packfile Transfer
 ----------------------------------------------
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index e174343..a165286 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -250,3 +250,8 @@ allow-tip-sha1-in-want
 If the upload-pack server advertises this capability, fetch-pack may
 send "want" lines with SHA-1s that exist at the server but are not
 advertised by upload-pack.
+
+uploadpack2
+-----------
+
+upload-pack version 2 is supported.
-- 8< --
