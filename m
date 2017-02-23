Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 985BE201B0
	for <e@80x24.org>; Thu, 23 Feb 2017 06:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbdBWGEw (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 01:04:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46898 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbdBWGEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 01:04:51 -0500
Received: from localhost (unknown [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB4E56C;
        Thu, 23 Feb 2017 06:04:49 +0000 (UTC)
Date:   Thu, 23 Feb 2017 07:04:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Driver Project <devel@linuxdriverproject.org>
Subject: git email From: parsing (was Re: [GIT PULL] Staging/IIO driver
 patches for 4.11-rc1)
Message-ID: <20170223060444.GA26196@kroah.com>
References: <20170222145613.GA17333@kroah.com>
 <CA+55aFy1JpXmo_PpC7f0zZa0YAP6rz+bztJ+fpDUoWgCz0_FMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFy1JpXmo_PpC7f0zZa0YAP6rz+bztJ+fpDUoWgCz0_FMw@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 22, 2017 at 11:59:01AM -0800, Linus Torvalds wrote:
> On Wed, Feb 22, 2017 at 6:56 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > =?UTF-8?q?Simon=20Sandstr=C3=B6m?= (1):
> >       staging: vt6656: Add missing identifier names
> 
> Wow, your scripts really screwed up that name.
> 
> I'm assuming this is quilt not doing proper character set handling..
> 
> Because if it's git, we need to get that fixed (but I'm pretty sure
> git gets this right - there are various tests for email header
> quoting).
> 
> Alternatively, somebody hand-edited some email and moved the From:
> header to the body without fixing up the RFC 1342 mail header quoting
> (which is very different from how quoting works in the *body* of an
> email).
> 
> Poor Simon Sandström.
> 
> Funnily enough, this only exists for one commit. You've got several
> other commits from Simon that get his name right.
> 
> What happened?

I don't know what happened, I used git for this, I don't use quilt for
"normal" patches accepted into my trees anymore, only for stable kernel
work.

So either the mail is malformed, or git couldn't figure it out, I've
attached the original message below, and cc:ed the git mailing list.

Also, Simon emailed me after this was committed saying something went
wrong, but I couldn't go back and rebase my tree.  Simon, did you ever
figure out if something was odd on your end?

Git developers, any ideas?

thanks,

greg k-h

--2oS5YaxWCcQjTEyO
Content-Type: application/mbox
Content-Disposition: attachment; filename="messy_email.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom simon@nikanor.nu Thu Jan 26 22:29:51 2017=0AReturn-Path: <simon@nika=
nor.nu>=0ADelivered-To: unknown=0ADelivered-To: gregkh@linuxfoundation.org=
=0AReceived: by 10.129.160.73 with SMTP id x70csp394432ywg;=0A        Thu, =
26 Jan 2017 13:29:51 -0800 (PST)=0AX-Received: by 10.46.83.27 with SMTP id =
h27mr1786169ljb.28.1485466190974;=0A        Thu, 26 Jan 2017 13:29:50 -0800=
 (PST)=0AReceived: from mail-lf0-x235.google.com (mail-lf0-x235.google.com.=
 [2a00:1450:4010:c07::235])=0A        by mx.google.com with ESMTPS id e86si=
1676067lji.10.2017.01.26.13.29.50=0A        for <gregkh@linuxfoundation.org=
>=0A        (version=3DTLS1_2 cipher=3DECDHE-RSA-AES128-GCM-SHA256 bits=3D1=
28/128);=0A        Thu, 26 Jan 2017 13:29:50 -0800 (PST)=0AReceived-SPF: ne=
utral (google.com: 2a00:1450:4010:c07::235 is neither permitted nor denied =
by best guess record for domain of simon@nikanor.nu) client-ip=3D2a00:1450:=
4010:c07::235;=0AAuthentication-Results: mx.google.com;=0A       dkim=3Dpas=
s header.i=3D@nikanor-nu.20150623.gappssmtp.com;=0A       spf=3Dneutral (go=
ogle.com: 2a00:1450:4010:c07::235 is neither permitted nor denied by best g=
uess record for domain of simon@nikanor.nu) smtp.mailfrom=3Dsimon@nikanor.n=
u=0AReceived: by mail-lf0-x235.google.com with SMTP id n124so152124581lfd.2=
=0A        for <gregkh@linuxfoundation.org>; Thu, 26 Jan 2017 13:29:50 -080=
0 (PST)=0ADKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;=0A   =
     d=3Dnikanor-nu.20150623.gappssmtp.com; s=3D20150623;=0A        h=3Ddat=
e:from:to:cc:subject:message-id:mime-version:content-disposition=0A        =
 :content-transfer-encoding:user-agent;=0A        bh=3D9C0rvPoWzqLgVVzKWPxc=
ge1xPI9pYicMRrGJwSwgTAo=3D;=0A        b=3DQoMLK5Q+09xfAGkTNn78MRmKbfe/1oks6=
pzh7B704blHPh7hd7AzAdLkjicP142dK8=0A         8x80r3Yb6Tuabf4QMd5uYboV4aBZvh=
ir/0uuCfTLNUkJPgI588LHaO+jmY4jXEgawDbf=0A         8Qgkg8/uMnFxWb9Ztl3Ve9MDh=
dLqrwJy4EgEKWeGRNE1S8bNco51ZDQBVCuoBb6+DUgY=0A         cpP/VAYY5Z91nNc9Uf4/=
VvqSE3EwNWFdriURFpF8d03E7uAR1xDWhB/+14lZNZ8XJ3DG=0A         FikOx1nSLgM9P4w=
Qr/Kzdetp7ZNAZ60EkDD6eQk7cE8nKdgyrh6jg7jCybEd2v9e9Jxo=0A         26tQ=3D=3D=
=0AX-Google-DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;=0A =
       d=3D1e100.net; s=3D20161025;=0A        h=3Dx-gm-message-state:date:f=
rom:to:cc:subject:message-id:mime-version=0A         :content-disposition:c=
ontent-transfer-encoding:user-agent;=0A        bh=3D9C0rvPoWzqLgVVzKWPxcge1=
xPI9pYicMRrGJwSwgTAo=3D;=0A        b=3DIRmb/w2TCZCFmTUxY6JCWuFrTmW/G7CfsIYx=
tQZafikUMYKD/O4FD3w5gwm+PaPSow=0A         QZghegrHurazlc1uD9GFDx3aJ7KefWKl5=
u7I1UyY8F9xgKRyPZmQkRhSWKaszgNYgIeI=0A         7Gvp08bXlOWy2AZWxtrT2WrQVo4y=
FHDMMNsM94eUFutQ69RFtYmRXoMKuaBJsdAuUhhP=0A         Bpm2OGgO8KVr4POcz5boe2m=
diPzKrNvgxjg4YuV0HB718kv78ixLW0GTqECetaarL/4y=0A         6HsHqKcfnODAad07M4=
n7rb6Mlsec/boW77qo2qWJLnY3bwD3dvOKsB60MiunckdyEByO=0A         Cz7Q=3D=3D=0A=
X-Gm-Message-State: AIkVDXKR2bWnJwyCwuY8BMULLHQRii/HUbYeDNdRUDpsoP0fR9yYemW=
55m9qNc9WKxOwyg=3D=3D=0AX-Received: by 10.46.7.26 with SMTP id 26mr1891307l=
jh.60.1485466190448;=0A        Thu, 26 Jan 2017 13:29:50 -0800 (PST)=0ARece=
ived: from localhost (h-129-173.a258.priv.bahnhof.se. [81.170.129.173])=0A =
       by smtp.gmail.com with ESMTPSA id h13sm799302ljh.5.2017.01.26.13.29.=
49=0A        (version=3DTLS1_2 cipher=3DECDHE-RSA-AES128-GCM-SHA256 bits=3D=
128/128);=0A        Thu, 26 Jan 2017 13:29:49 -0800 (PST)=0ADate: Thu, 26 J=
an 2017 22:29:48 +0100=0AFrom: =3D?us-ascii?B?PT9VVEYtOD9xP1NpbW9uPTIwU2FuZ=
HN0cj1DMz1CNm0/PQ=3D=3D?=3D <simon@nikanor.nu>=0ATo: forest@alittletooquiet=
=2Enet=0ACc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,=0A	lin=
ux-kernel@vger.kernel.org=0ASubject: [PATCH] staging: vt6656: Add missing i=
dentifier names=0AMessage-ID: <20170126212948.GA15093@gamma.nikanor.nu>=0AM=
IME-Version: 1.0=0AContent-Type: text/plain; charset=3Diso-8859-1=0AContent=
-Disposition: inline=0AContent-Transfer-Encoding: 8bit=0AUser-Agent: Mutt/1=
=2E5.23 (2014-03-12)=0AX-getmail-retrieved-from-mailbox: INBOX=0AX-GMAIL-TH=
RID: =3D?utf-8?q?1557624196707287078?=3D=0AX-GMAIL-MSGID: =3D?utf-8?q?15576=
24196707287078?=3D=0AStatus: RO=0AContent-Length: 2339=0ALines: 54=0A=0AFix=
 multiple checkpatch.pl warnings:=0Afunction definition argument '...' shou=
ld also have an identifier name=0A=0ASigned-off-by: Simon Sandstr=F6m <simo=
n@nikanor.nu>=0A---=0A drivers/staging/vt6656/card.h | 34 +++++++++++++++++=
+----------------=0A 1 file changed, 18 insertions(+), 16 deletions(-)=0A=
=0Adiff --git a/drivers/staging/vt6656/card.h b/drivers/staging/vt6656/card=
=2Eh=0Aindex c2cde7e92c8f..7f08cda27e2c 100644=0A--- a/drivers/staging/vt66=
56/card.h=0A+++ b/drivers/staging/vt6656/card.h=0A@@ -35,21 +35,23 @@=0A =
=0A struct vnt_private;=0A =0A-void vnt_set_channel(struct vnt_private *, u=
32);=0A-void vnt_set_rspinf(struct vnt_private *, u8);=0A-void vnt_update_i=
fs(struct vnt_private *);=0A-void vnt_update_top_rates(struct vnt_private *=
);=0A-int vnt_ofdm_min_rate(struct vnt_private *);=0A-void vnt_adjust_tsf(s=
truct vnt_private *, u8, u64, u64);=0A-bool vnt_get_current_tsf(struct vnt_=
private *, u64 *);=0A-bool vnt_clear_current_tsf(struct vnt_private *);=0A-=
void vnt_reset_next_tbtt(struct vnt_private *, u16);=0A-void vnt_update_nex=
t_tbtt(struct vnt_private *, u64, u16);=0A-u64 vnt_get_next_tbtt(u64, u16);=
=0A-u64 vnt_get_tsf_offset(u8 byRxRate, u64 qwTSF1, u64 qwTSF2);=0A-int vnt=
_radio_power_off(struct vnt_private *);=0A-int vnt_radio_power_on(struct vn=
t_private *);=0A-u8 vnt_get_pkt_type(struct vnt_private *);=0A-void vnt_set=
_bss_mode(struct vnt_private *);=0A+void vnt_set_channel(struct vnt_private=
 *priv, u32 connection_channel);=0A+void vnt_set_rspinf(struct vnt_private =
*priv, u8 bb_type);=0A+void vnt_update_ifs(struct vnt_private *priv);=0A+vo=
id vnt_update_top_rates(struct vnt_private *priv);=0A+int vnt_ofdm_min_rate=
(struct vnt_private *priv);=0A+void vnt_adjust_tsf(struct vnt_private *priv=
, u8 rx_rate,=0A+		    u64 time_stamp, u64 local_tsf);=0A+bool vnt_get_curr=
ent_tsf(struct vnt_private *priv, u64 *current_tsf);=0A+bool vnt_clear_curr=
ent_tsf(struct vnt_private *priv);=0A+void vnt_reset_next_tbtt(struct vnt_p=
rivate *priv, u16 beacon_interval);=0A+void vnt_update_next_tbtt(struct vnt=
_private *priv, u64 tsf,=0A+			  u16 beacon_interval);=0A+u64 vnt_get_next_=
tbtt(u64 tsf, u16 beacon_interval);=0A+u64 vnt_get_tsf_offset(u8 rx_rate, u=
64 tsf1, u64 tsf2);=0A+int vnt_radio_power_off(struct vnt_private *priv);=
=0A+int vnt_radio_power_on(struct vnt_private *priv);=0A+u8 vnt_get_pkt_typ=
e(struct vnt_private *priv);=0A+void vnt_set_bss_mode(struct vnt_private *p=
riv);=0A =0A #endif /* __CARD_H__ */=0A-- =0A2.11.0=0A=0A
--2oS5YaxWCcQjTEyO--
