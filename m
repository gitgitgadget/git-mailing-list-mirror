From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Thu, 1 Dec 2011 00:33:15 +0000
Message-ID: <CAOpHH-U3PF0v7EPqnO0FNxNKh+uF1GH=cnA_MA09SaQTxo0cDA@mail.gmail.com>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
 <loom.20111130T155409-599@post.gmane.org> <4ED6809A.9020703@diamand.org> <20111130225813.GA11544@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 01:33:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVub2-00064s-I5
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 01:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab1LAAds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Nov 2011 19:33:48 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33667 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753001Ab1LAAdr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 19:33:47 -0500
Received: by lagw12 with SMTP id w12so360980lag.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 16:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=0mPcV2+c+bGdqKkh5czNktpeLodqhlCO1yiaLoUsAaQ=;
        b=XBcS3snAxR1Ph5p41Y6u7zhAkQelM5Nj1GRBC8R3CN2fYKmctpBh6mNlxEOefJHfb4
         1x6uxTZawI3aAx5APuOFHShluRulXXkmHxHDFaSR6rb3dbBT5fns/yDT/pbvx/MF3FaP
         LG4zQnsRXlwlb+VO4Km7c1iHGMtlZHosTLqMc=
Received: by 10.152.144.202 with SMTP id so10mr3110040lab.9.1322699626314;
 Wed, 30 Nov 2011 16:33:46 -0800 (PST)
Received: by 10.152.5.105 with HTTP; Wed, 30 Nov 2011 16:33:15 -0800 (PST)
In-Reply-To: <20111130225813.GA11544@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186152>

On Wed, Nov 30, 2011 at 10:58 PM, Pete Wyckoff <pw@padd.com> wrote:
> This is another fundamental disconnect between p4 and git.
> Reading
>
> http://www.perforce.com/perforce/doc.current/manuals/p4guide/07_label=
s.html
>
> it is clear that labels are supposed to be used exactly where
> tags cannot: =A0to specify a collection of files as they existed
> at _different_ points in the commit history.

Check the "Use Tag Fixup Branches" section in fast-import manual, it
might help on this. The basic concept is to create a special branch
that puts all files in the same state the P4 label would put them and
then tag it in git.

Tried to use this for my branch stuff, but with no success.

> Thus I think supporting labels is kind of pointless. =A0But in the
> restricted use case that perforce docs tell us not to do, namely
> using labels to identify change numbers, git can reflect that
> with tags.

I still use labels as simple tags. Telling that we should use
changelists instead of labels is the same as saying that we should use
IP addresses instead of host names. It works, but I doubt you will
ever remember it unless you write it down somewhere.

--=20
Vitor Antunes
