From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Sun, 26 Oct 2008 11:05:21 -0400
Message-ID: <ee2a733e0810260805n35c3a637v4739dda938a22518@mail.gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <m3r663h276.fsf@localhost.localdomain>
	 <e15351d00810260730t1552e04cqb057993581514f3b@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, mercurial@selenic.com,
	git@vger.kernel.org
To: "Maxim Vuets" <maxim.vuets@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 16:06:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku7CP-0006Qs-VM
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 16:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbYJZPFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 11:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbYJZPFY
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 11:05:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:55613 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYJZPFX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 11:05:23 -0400
Received: by nf-out-0910.google.com with SMTP id d3so530959nfc.21
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nXcUFtVljT3Xy1nEXT3KhhPoRGMspe+p0w5COk86ros=;
        b=w2fs/6G5MH9/bgFKQCfyC4dEzsqZ00LNC7Tb2kfTjhnpHXkOTSmJjc75UgW7U0es9U
         3LjRCSta5aEM+Z312Ralc2+dH3i7E5QuEbf5dfCIpBDKhXv0OgAhG8vNRmBT8f4Yh11T
         bDZ71JKdpSGcZkIWttS5bYwcljTd/zDQ9ADXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Htd6Fc5z/Y0kVcpYahIwh5vqz6qiR6JwyzrH0GWpkSPIrqptKwAX51b6UfMpSrdXPE
         U5sRP5pfFo9d0BpucRA1uTuoCim96hj8cx8cXTfWV1jcc7qsBknGAjIm3wRkDMWyK3Pc
         TcQ3x+W3UDWRL2+j7H6Okjwv3ztMNwG6arj8g=
Received: by 10.187.203.16 with SMTP id f16mr416531faq.34.1225033521675;
        Sun, 26 Oct 2008 08:05:21 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Sun, 26 Oct 2008 08:05:21 -0700 (PDT)
In-Reply-To: <e15351d00810260730t1552e04cqb057993581514f3b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99166>

On 10/26/08, Maxim Vuets <maxim.vuets@gmail.com> wrote:
> On 26 Oct 2008 15:15:57 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
>  > 1. Documentation and ease of use.
>  >
>  >    Mercurial is supposedly better documented and easier to use; I
>  >    think this descends from the early days of Git, where it was not
>  >    very user friendly. IMHO Git has much improved since.  Mercurial
>  >    had 'hgbook' from the beginning; Git User's Manual is more recent.
>
>
> Also, there is http://book.git-scm.com/ that is similar to hgbook, I think.
>
>  Thanks for the comprarision!

I have been using Mercurial for about two years and am very
comfortable with it.  Here are some cons and pros

Mercurial PROS:
* Easier and more consistent UI. Newbie friendly.
* Better documentation. IMHO, hgbook is by far better than
http://book.git-scm.com/
* Windows support (personally, I do not care)

Mercurial CONS:
* Less potential than git. Once Ted Tso even said that "git has more
legs than mercurial", see
http://thunk.org/tytso/blog/2007/03/24/git-and-hg/
* Hg is strictly an SCM system while GIT is a content addressable file
system that can be used in other ways, hence the name Global
Information Tracker (GIT)
* Recently, Hg development seems to have somewhat slowed down. To
simply put it, there is not enough room in the world for several
similar SCM systems. With git's pace and momentum the other SCMs
including Hg are fighting an uphill battle.

Just my two cents.
--Leo--
