From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 18:07:14 +0000
Message-ID: <32541b130908191107v2ab6752awb43f521f805b5f1a@mail.gmail.com>
References: <4a8c373f@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo Brueckl <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 20:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdpZZ-0006rK-At
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 20:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbZHSSHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 14:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbZHSSHg
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 14:07:36 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:38922 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZHSSHg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 14:07:36 -0400
Received: by gxk1 with SMTP id 1so6213492gxk.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=h0N9toQzrS6mIUUYmjr1mUSkyr0cToqyiWCHZY0fatg=;
        b=xe848W0tElZ4XlJf0WSBMufMK/bntl2gWTDthc7z3D3SrUGdezD1ek8TkFrHbQTR96
         vnesusT32pQ3vAty+evdwd70rj2uhpP6siGrvZf0/Fq1cWvpDd/N++6yQKktlfuIznKE
         AopM3FSUaxLFg3L2B74BTR1OiMb3Kt6He4YSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AbbHUuSB6u6behSpscO+cYfEwp5+HmU5q2j9lAyaoFjRIO0s91lTv10TOSb+cV+CRV
         PkxdwbGmcbV0KxtQo6czUawUt5hlh3cEg17ZGGkxwSpg+wI4bpR0LOs3s/2omO/sA+H7
         SLPZqJgS7W3pj4iGUgSjSz8hoZ4G1LKsne9Do=
Received: by 10.150.210.5 with SMTP id i5mr10939642ybg.121.1250705254677; Wed, 
	19 Aug 2009 11:07:34 -0700 (PDT)
In-Reply-To: <4a8c373f@wupperonline.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126570>

On Wed, Aug 19, 2009 at 5:33 PM, Ingo Brueckl<ib@wupperonline.de> wrote=
:
> Within a git repository, I do:
>
> =A0git branch test
> =A0git checkout test
> =A0# edit foo.bar
> =A0git checkout master
>
> I'd expect that master is in the exactly same unchanged state it was =
at
> branching time, but what a surprise, foo.bar is modified here, too!

You seem to have forgotten the "git commit" step before switching back
to master.  You have a modified file in your repository; what did you
*want* to happen when you switched branches?  (Many people find the
current behaviour very convenient.)

You might also want to look at the "git stash" command.

Avery
