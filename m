X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: =?ISO-8859-1?Q?Re:_[PATCH_1/3]_make_index-p=E2?= =?ISO-8859-1?Q?ck_able_to_complete_thin_packs?=
Date: Thu, 26 Oct 2006 12:57:50 +0100
Message-ID: <b0943d9e0610260457m780dd7d4t95fe36130cbdf551@mail.gmail.com>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home>
	 <7vr6wvr1ca.fsf@assigned-by-dhcp.cox.net> <ehppbg$phq$1@sea.gmane.org>
	 <20061026091925.GD13780@diana.vm.bytemark.co.uk>
	 <tnxac3j4c6c.fsf@arm.com>
	 <20061026105841.GB16372@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 11:58:16 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hk1u/Q/c4phr1WrVsyUXFw2zZcHrRmYJHOA3RiESHXw7rw4WPUCti8wfpetPfP1Qob9pdYPRzco2rGWDgKkwvvzTPGtzr19zNyjTv6KqlB1Zv+vrXwtkzsz+QDT9Q9YwCVtO++qCyk+FNt4iNomkxaUdNP+/6p3MKdRsmFrXq6s=
In-Reply-To: <20061026105841.GB16372@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30197>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd3rz-0000fi-In for gcvg-git@gmane.org; Thu, 26 Oct
 2006 13:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423276AbWJZL54 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 07:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423295AbWJZL54
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 07:57:56 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:40485 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1423276AbWJZL5z
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 07:57:55 -0400
Received: by py-out-1112.google.com with SMTP id z74so312931pyg for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 04:57:55 -0700 (PDT)
Received: by 10.35.99.17 with SMTP id b17mr3158629pym; Thu, 26 Oct 2006
 04:57:50 -0700 (PDT)
Received: by 10.35.103.18 with HTTP; Thu, 26 Oct 2006 04:57:50 -0700 (PDT)
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 26/10/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2006-10-26 11:13:47 +0100, Catalin Marinas wrote:
> > Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > > On 2006-10-26 09:50:48 +0200, Jakub Narebski wrote:
> > > > That said, git-am should understand QP with coding in mail
> > > > headers.
> > >
> > > I really hope it does, since I just patched StGIT to generate suc=
h
> > > headers. (Out of pure vanity -- I don't want my name mangled!)
> >
> > It looks like it does, that's how I applied some of your patches
> > ('stg import' doesn't understand them).
>
> Hmm. So now I know why you haven't taken my "stg email" patches. I
> guess I'll have to fix 'stg import' then. :-)

That's one of the reasons (and I didn't have time to document myself
before giving a proper reply). The other is that Gnus (and gmail)
doesn't display the messages properly - it shows a lot of "=3D20". Is i=
t
possible not to affect the body (or make it optional)? People only
using "patch" to apply the diffs would have problems with this
encoding.

--=20
