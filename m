From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] fast-import: notemodify (N) command
Date: Mon, 31 Jan 2011 13:01:28 -0600
Message-ID: <20110131190128.GC32374@burratino>
References: <1255083738-23263-1-git-send-email-johan@herland.net>
 <1255083738-23263-8-git-send-email-johan@herland.net>
 <20110131183350.GB31826@burratino>
 <AANLkTi=3P0xc3mJj5Tsg_P26SAXmgVfCk1VeYQ=k2UtT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vcs-fast-import-devs@lists.launchpad.net, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, sam@vilain.net,
	Johannes.Schindelin@gmx.de, trast@student.ethz.ch,
	Johan Herland <johan@herland.net>, gitster@pobox.com,
	git@vger.kernel.org, Augie Fackler <durin42@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 20:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjz0c-0004xm-4k
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 20:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab1AaTBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 14:01:49 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42715 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab1AaTBs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 14:01:48 -0500
Received: by vws16 with SMTP id 16so2082175vws.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6OSWjaBAvU6lbzBEDbmzelyq1gVSJe2J/dd0zswBJQ0=;
        b=u3yKFBiectfEv9rJat1+UV+l/KUqArIVouQqYOdUeNc6K7oaLXHKZoFDdibszNOTSI
         d8n8Go7xPdpQj1P51eIFpiVxxUoe9x/sxiVHqG9oQk0XDA3nMViVHGFDnvdAxApYf3uU
         Dg9sDekGr9aqLaoPx30l8/z6BeOf2BDnmFNmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RB1PixSvv8Yp7Uw8lY1q9iGrjPfyyg/yqXt/u9mfAdf06PZA0TmKwi8oaWxe/bwHvt
         FeY8OMIkYZG7j8OwZbB/FjE63Fl2QCBl0TnIQsHQ5FfIEhu4CP0WV38ng5vwVon6eGpT
         H/LBwt5WyxE38cVba5kCybBwJnYRLjHIAX74Y=
Received: by 10.220.199.77 with SMTP id er13mr1789376vcb.44.1296500505241;
        Mon, 31 Jan 2011 11:01:45 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id y15sm7154724vch.29.2011.01.31.11.01.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 Jan 2011 11:01:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=3P0xc3mJj5Tsg_P26SAXmgVfCk1VeYQ=k2UtT@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165741>

Sverre Rabbelier wrote:
> I talked with Augie Fackler (from hg) about this on IM and he says:

>> We don't support anything like that at present (no demand, when we check
>> nobody really seems to use git notes for anything)
>> so it doesn't seem relevant in fast-export
>
> So at least HG doesn't (currently) have any functionality that they
> could use to implement the importing of such a stream.

Thanks, good to know.  I suppose this definitely needs a feature name,
then (I'll send a patch to make it "feature notes").

Jonathan

[Aside: I suspect part of the reason "git notes" adoption is not so
great is the lack of git notes fetch/git notes push.  Sample size
of 1: I use notes heavily as a consumer, to dig up mailing list
threads[1], but have put off sharing my own annotations until I can
figure out how to make it convenient for others to use.]

[1] http://thread.gmane.org/gmane.comp.version-control.git/109074/focus=109542
