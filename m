X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 2 Nov 2006 13:39:26 +0100
Message-ID: <8aa486160611020439r255bcdb1q6e7ece46c77de11c@mail.gmail.com>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>
	 <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>
	 <4549CE2A.3010808@xs4all.nl>
	 <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
	 <4549D4B4.4030601@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 2 Nov 2006 12:39:36 +0000 (UTC)
Cc: hanwen@xs4all.nl, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hJTffaPI3XxkMCiOqVlRr/+Wfwf7fqj4VjSZEg026DPJf2O0QAow67M1R4T4Qhbbm8HI9aEJweoYFrdDpxOYNQ7f2V6MMws81pgHSAEizerh51YlPHZa1ttfTJpnxyzLmD95SqlX2v7iBgqVuANJ4SMYBcBw1Ulh8EYrzLmoaSI=
In-Reply-To: <4549D4B4.4030601@shadowen.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30742>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfbr1-00029V-SE for gcvg-git@gmane.org; Thu, 02 Nov
 2006 13:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752301AbWKBMj1 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006 07:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbWKBMj1
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 07:39:27 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:60781 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1752301AbWKBMj1
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006
 07:39:27 -0500
Received: by wx-out-0506.google.com with SMTP id s14so109299wxc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 04:39:26 -0800 (PST)
Received: by 10.70.11.1 with SMTP id 1mr764596wxk.1162471166235; Thu, 02 Nov
 2006 04:39:26 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Thu, 2 Nov 2006 04:39:26 -0800 (PST)
To: "Andy Whitcroft" <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

On 11/2/06, Andy Whitcroft <apw@shadowen.org> wrote:
> Santi B=E9jar wrote:
> > One problem I see with this scheme (either 'g', 'git' of '+') is th=
at
> > it does not provide an increasing version number, even for
> > fast-forwarding commits. Then it is not useful as a package version
> > number (deb or rpm). I've already seen deb packages with
> > version+git20061010. One possibility could be to add the number of
> > commits between the tag and the commit as:
> >
> > v1.4.3.3-git12g1e1f76e
> >
> > to provide a weak ordering for fast-forwarding commits. What do you=
 thing?
>
> I think you'll restart the 1.2.3.4 versioning is better 'debate' agai=
n!

Sorry, I don't undestand this.

> Surly if things are being pushed into a .deb or .rpm we should be usi=
ng
> a real release version.  We should be tagging that.  If the project i=
s
> not providing release number, there is nothing stopping you from tagg=
ing
> them yourself in your copy of the repository and using your tag.  you
> could use like 'unofficial-N' where N increments in the way you want.

And where do you store this tag? It is an upstream commit and you just
refer to this. With the unofficial-N there is no way to know which
upstream commit you are refering without having access to the git
repository of the packager  .

