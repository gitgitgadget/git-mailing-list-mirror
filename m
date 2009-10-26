From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] git checkout --no-guess
Date: Mon, 26 Oct 2009 14:25:31 -0400
Message-ID: <32541b130910261125h7be6631axc4ed1256c606c3bb@mail.gmail.com>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> 
	<7v63adxh9a.fsf_-_@alter.siamese.dyndns.org> <81b0412b0910180540u7030c22br7efcaf7f51df771d@mail.gmail.com> 
	<7v7huspjg0.fsf@alter.siamese.dyndns.org> <32541b130910211029x2f4295c3w40dd13b3cdc7762c@mail.gmail.com> 
	<20091022062145.6117@nanako3.lavabit.com> <7vskdcz973.fsf@alter.siamese.dyndns.org> 
	<7vtyxsxtmp.fsf_-_@alter.siamese.dyndns.org> <32541b130910211551n13e0dd1bha6dcdc82d1d6b4cd@mail.gmail.com> 
	<76718490910261117i60a556ebv7405e945796a3610@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 19:26:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2UGb-0001Go-D3
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 19:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbZJZSZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 14:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbZJZSZr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 14:25:47 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:37774 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbZJZSZq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 14:25:46 -0400
Received: by yxe17 with SMTP id 17so10024732yxe.33
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pnhTHtva0sQnxNNhmDcuV6B3TbxsMUiXsXX/5xabYf8=;
        b=H5unF9A6uj/lHiKWBjU2IFvLwsdSyveXNNaVewzz6nlhv5rkyqKckcc2PgtEiIGkCQ
         n6bJhhdzjMUGKxqWI7RkTBvuxGlQPEpWaK0jrnRjxSfc/YKDlHcLCgx8ojq4dFgSyZHl
         mbo9xX0MyKJy738VBucsuv7cLhMi/R7zmKemo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=THGoqG+OEelfLgRLmdZo5Kt0feUqXK1z9DDthqPJ6PqlQVWPSL0YqYf8zszoWwM67e
         VYZ6rcyONfOR0i+Q5uOXuJf/Jyn51DroDLfzEEgoA17wns/WlMT6f4BEY+8+T1wB4eW7
         cTZvQy/dXQMN+TvDsocku9bLK2NkLgxGq06hg=
Received: by 10.150.44.6 with SMTP id r6mr11730634ybr.244.1256581551094; Mon, 
	26 Oct 2009 11:25:51 -0700 (PDT)
In-Reply-To: <76718490910261117i60a556ebv7405e945796a3610@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131260>

On Mon, Oct 26, 2009 at 2:17 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> On Wed, Oct 21, 2009 at 3:51 PM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> Just curious. =A0(And now wondering how many other wonderful options=
 are
>> in there but undocumented...)
>
> =A0* =A0 PARSE_OPT_HIDDEN: this option is skipped in the default usag=
e, and
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 shown only in the full u=
sage.
>
> Which translates to --help-all:
>
> --help-all
> =A0 =A0 =A0 =A0 =A0 Some git commands take options that are only used=
 for
> plumbing or that are deprecated, and such options are hidden from the
> default usage. This option gives the full list of options.
>
> =A0So git checkout --help-all should show it.

Thanks!  I had no idea about --help-all.

Avery
