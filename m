From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 6/3] fast-import: Allow cat requests at arbitrary points
 in stream
Date: Tue, 7 Sep 2010 22:38:33 -0500
Message-ID: <AANLkTinU6TtFgLuQf54aZNE7-E3fDYLcmp25uiGRFgrV@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino> <20100908032736.GC23409@capella.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 05:39:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtBV2-0000oE-11
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 05:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058Ab0IHDiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 23:38:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42896 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882Ab0IHDiy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 23:38:54 -0400
Received: by gxk23 with SMTP id 23so2219028gxk.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 20:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=AtDniQSmTgRllPaD7xi6WWP1JXZYP7sIvFmxPVwsdqQ=;
        b=mURuqsioaqpd+npC+L06YzHQcGdJ9ZnfzKMVe/WWi+G3Tm271nmy1iZqHQsR8KG3x9
         GpA1yTayjh45fsL63D7DK/5FFws+A4WvHYGDjhvB0fnqf43Hdv5gCLnMEuknPkCDapZ9
         zu12ZBR5k/FbXHbvxJl85MAlrOjBWQyEoL5FY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=T2GLxznoJOV/mNPT0dvh8WEh2J/vnFtFwaOC2I5A2z780e4qXgzenfLgWoqcCRrgNn
         t+NV0lnDE/RaMrC4/8/an7ulxO2qUehz5PwGLt/cNucpmdYUyocCSKEzRNO8UGaBS1KZ
         DQXL7iLy7XRrAb/2228ZHq21K4Epi2SMe1OF8=
Received: by 10.150.68.4 with SMTP id q4mr831283yba.261.1283917133373; Tue, 07
 Sep 2010 20:38:53 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Tue, 7 Sep 2010 20:38:33 -0700 (PDT)
In-Reply-To: <20100908032736.GC23409@capella.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155762>

Heya,

On Tue, Sep 7, 2010 at 22:27, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Rather than planning in advance and saving up a bunch of objects
> before a "commit" command, frontends might want to wait until the
> middle of a commit and request objects then.

I'm not sure I understand the justification of this patch. Is the
purpose of this patch to save you from having to loop over everything
you want to commit in the next commit and cat-ing that in advance?

-- 
Cheers,

Sverre Rabbelier
