From: Jello huang <ruifeihuang@gmail.com>
Subject: Re: cannot fetch arm git tree
Date: Mon, 17 Jan 2011 09:49:28 +0800
Message-ID: <AANLkTi=VPj2JVnkjv-ja48OUwJZR3zhDYcvSeps1X8x1@mail.gmail.com>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
	<20110116092315.GA27542@n2100.arm.linux.org.uk>
	<20110116110819.GG6917@pengutronix.de>
	<AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
	<20110116134248.GD27542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1965341816=="
Cc: git@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-From: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org Sat Jan 22 22:19:40 2011
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Envelope-to: linux-arm-kernel@m.gmane.org
Received: from bombadil.infradead.org ([18.85.46.34])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>)
	id 1Pgkry-0007dz-Gd
	for linux-arm-kernel@m.gmane.org; Sat, 22 Jan 2011 22:19:38 +0100
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PgkrA-0003aO-T9; Sat, 22 Jan 2011 21:18:49 +0000
Received: from localhost ([127.0.0.1] helo=canuck.infradead.org)
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Pgkr9-00041G-17; Sat, 22 Jan 2011 21:18:47 +0000
Received: from mail-fx0-f49.google.com ([209.85.161.49])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PeeDp-0004t7-Jg for linux-arm-kernel@lists.infradead.org;
	Mon, 17 Jan 2011 01:49:31 +0000
Received: by fxm19 with SMTP id 19so5376351fxm.36
	for <linux-arm-kernel@lists.infradead.org>;
	Sun, 16 Jan 2011 17:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=wCKUNFSdyFnWgfqxv1nbsbrqSslK9Lbvom3WB6oVh0U=;
	b=E4qeewoSy9RpoMHFgo3O51lOXgxJkJLCfO+37deHaQXQHna9/JGdMicsMp20TuFHf5
	OsMqTlbvSgsSluPgtSRNSMCxP/8SyDjAwk8UL6GwQkK2j3XkCXAwjV92XEOYTwu6m67/
	9CO0tB4PIWp9IOISf/mbLe1X5NfN4m77Gt7pI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	b=OP6NTmtO+HyMQLws+jzCIEcdqFxObfjSYIG0tDeoL5w54SGbyceXH+gwpMsWZOAB6f
	MZ2IjpDdlnUSkn8dY+bU+QbMfXxX1O+FgPcaY9k7KWiH7UuDIHIYhXVR8e0UZ71zQ9VL
	VaD5bWoFvrxjiHlVcdtityDpJdSyU5U4QNJ88=
Received: by 10.223.53.68 with SMTP id l4mr4103880fag.44.1295228968121; Sun,
	16 Jan 2011 17:49:28 -0800 (PST)
Received: by 10.223.86.13 with HTTP; Sun, 16 Jan 2011 17:49:28 -0800 (PST)
In-Reply-To: <20110116134248.GD27542@n2100.arm.linux.org.uk>
X-CRM114-Version: 20090807-BlameThorstenAndJenny ( TRE 0.7.6 (BSD) )
	MR-646709E3 
X-CRM114-CacheID: sfid-20110116_204930_129597_6505CD19 
X-CRM114-Status: GOOD (  22.83  )
X-Spam-Score: -0.8 (/)
X-Spam-Report: SpamAssassin version 3.3.1 on canuck.infradead.org summary:
	Content analysis details:   (-0.8 points)
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
	0.0 FREEMAIL_FROM Sender email is freemail (ruifeihuang[at]gmail.com)
	-0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at http://www.dnswl.org/,
	low trust [209.85.161.49 listed in list.dnswl.org]
	0.0 HTML_MESSAGE           BODY: HTML included in message
	-0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
	author's domain
	0.1 DKIM_SIGNED            Message has a DKIM or DK signature,
	not necessarily valid
	-0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Mailman-Approved-At: Sat, 22 Jan 2011 16:18:43 -0500
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165416>

--===============1965341816==
Content-Type: multipart/alternative; boundary=0015174796488c36ba049a00fe49

--0015174796488c36ba049a00fe49
Content-Type: text/plain; charset=ISO-8859-1

Russell,thanks for your reply so elaborate and i have gotten the idea now.

On 16 January 2011 21:42, Russell King - ARM Linux
<linux@arm.linux.org.uk>wrote:

> On Sun, Jan 16, 2011 at 09:10:17PM +0800, Jello huang wrote:
> > yes,git doesn't  handle that case and i rename the pack name,but there is
> > also the similar error.Now i just delet the git tree and  clone it again
> > tonight .
>
> _Always_ without fail fetch Linus' tree before pulling my tree.
>
> My tree is a rsync clone of the objects and pack files in Linus' tree,
> plus whatever git decided to build on top of that - for local commits
> that's individual object files.  For remote pulls, that's probably a few
> small pack files.
>
> There is *no* repacking of my tree.  So the only times it gets 'repacked'
> is when Linus repacks his tree.
>
> Let's say you already have a copy of my tree from a month ago, and Linus
> has pulled some work from me into his tree, and repacked his tree into one
> single pack file.  At the moment, the largest pack file from Linus is
> 400MB plus a 50MB index.
>
> You already have most of the contents of that 400MB pack file, but if
> you're missing even _one_ object which is contained within it, git will
> have to download the _entire_ 400MB pack file and index file to retrieve
> it.
>
> However, if you first fetch Linus' tree via the git protocol, it can just
> request the objects it doesn't have from the git server.  That will mean
> you'll have all the objects in the large pack files before you start trying
> to pull my tree, and git won't have to download 400MB for the sake of
> retrieving just maybe 10k that you didn't have.
>
> This isn't something special with my tree - it's a side effect of the
> http protocol git uses.  So, before you fetch _any_ http-based git tree,
> first make sure you're up to date with Linus'.
>
> (I update my tree from Linus' in rsync mode to make http-based stuff a
> lot more friendly to people using it - some of whom are stuck behind
> firewalls which can only do http.  Fetching a constantly repacked git
> tree via http results in hundreds of megabytes needing to be fetched
> every time.)
>
> So please, whenever possible, always fetch Linus' latest tree _first_
> and then mine.  Same goes for any other http based tree which doesn't
> auto-repack.
>



-- 
JUST DO IT,NOTHING IS IMPOSSIBLE

--0015174796488c36ba049a00fe49
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Russell,thanks for your reply so elaborate and i have gotten the idea now.<=
br><br><div class=3D"gmail_quote">On 16 January 2011 21:42, Russell King - =
ARM Linux <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@arm.linux.org.uk">l=
inux@arm.linux.org.uk</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Sun, Jan 16, 2011 at 0=
9:10:17PM +0800, Jello huang wrote:<br>
&gt; yes,git doesn&#39;t =A0handle that case and i rename the pack name,but=
 there is<br>
&gt; also the similar error.Now i just delet the git tree and =A0clone it a=
gain<br>
&gt; tonight .<br>
<br>
</div>_Always_ without fail fetch Linus&#39; tree before pulling my tree.<b=
r>
<br>
My tree is a rsync clone of the objects and pack files in Linus&#39; tree,<=
br>
plus whatever git decided to build on top of that - for local commits<br>
that&#39;s individual object files. =A0For remote pulls, that&#39;s probabl=
y a few<br>
small pack files.<br>
<br>
There is *no* repacking of my tree. =A0So the only times it gets &#39;repac=
ked&#39;<br>
is when Linus repacks his tree.<br>
<br>
Let&#39;s say you already have a copy of my tree from a month ago, and Linu=
s<br>
has pulled some work from me into his tree, and repacked his tree into one<=
br>
single pack file. =A0At the moment, the largest pack file from Linus is<br>
400MB plus a 50MB index.<br>
<br>
You already have most of the contents of that 400MB pack file, but if<br>
you&#39;re missing even _one_ object which is contained within it, git will=
<br>
have to download the _entire_ 400MB pack file and index file to retrieve<br=
>
it.<br>
<br>
However, if you first fetch Linus&#39; tree via the git protocol, it can ju=
st<br>
request the objects it doesn&#39;t have from the git server. =A0That will m=
ean<br>
you&#39;ll have all the objects in the large pack files before you start tr=
ying<br>
to pull my tree, and git won&#39;t have to download 400MB for the sake of<b=
r>
retrieving just maybe 10k that you didn&#39;t have.<br>
<br>
This isn&#39;t something special with my tree - it&#39;s a side effect of t=
he<br>
http protocol git uses. =A0So, before you fetch _any_ http-based git tree,<=
br>
first make sure you&#39;re up to date with Linus&#39;.<br>
<br>
(I update my tree from Linus&#39; in rsync mode to make http-based stuff a<=
br>
lot more friendly to people using it - some of whom are stuck behind<br>
firewalls which can only do http. =A0Fetching a constantly repacked git<br>
tree via http results in hundreds of megabytes needing to be fetched<br>
every time.)<br>
<br>
So please, whenever possible, always fetch Linus&#39; latest tree _first_<b=
r>
and then mine. =A0Same goes for any other http based tree which doesn&#39;t=
<br>
auto-repack.<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>JUST DO IT,NOTHING IS I=
MPOSSIBLE<br>

--0015174796488c36ba049a00fe49--


--===============1965341816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1965341816==--
