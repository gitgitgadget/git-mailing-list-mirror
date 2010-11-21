From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: showing unmerged changes from branch
Date: Sun, 21 Nov 2010 17:47:46 -0600
Message-ID: <20101121234746.GB24397@burratino>
References: <1290382627024-5761241.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: cmumford <cmumford@cmumford.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 00:48:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKJdh-0000UH-Hj
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 00:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab0KUXsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 18:48:04 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41114 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754648Ab0KUXsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 18:48:01 -0500
Received: by yxf34 with SMTP id 34so3734306yxf.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 15:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9NZXb5ek7LPrdCIeQFpvNA6A1JuYgSdkeCSC7nczVQs=;
        b=JKppLUREg4Dj27agAaht41oxhhXWOhMav4NpiXuvvu936dgIUVsBe4etr/WFommsEu
         V2SU7/LSLugCVLVpe94CP1CLZtS4Vl125q12wBMw5G78HbOmPeEW3p3+YPCQ4J6RbAiV
         voYtbnM/p5ovGgpd/x2Q1eIMbeKBzF4NsgGHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=njfzm03WDoLN14QWDPRtmncuVejTzmFarK5bM2QBSz+2BVYboQK7W624751j9F1NiE
         HLdfwZc5r/ZTdlrve47zpmRsPuyJwbadZ57cZPifOv1bjKAeXq5ScXwUPjC0W2jSlHB6
         iSQ4cSr2D+zB2XonOagOuYAHojEPPkUgudPbU=
Received: by 10.150.182.1 with SMTP id e1mr8150281ybf.59.1290383281224;
        Sun, 21 Nov 2010 15:48:01 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m65sm2812049yha.23.2010.11.21.15.47.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Nov 2010 15:48:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290382627024-5761241.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161876>

Hi Chris,

cmumford wrote:

> And once I identified a change that I want I did this:
> 
> git cherry-pick --no-commit <remote master commit sha1>
> 
> I then build/test the change, and once happy with I'll commit to my local
> branch. My question is now that I've cherry picked one change I want to get
> a list of all unmerged changes - filtering out ones I've already done?

You might like "git cherry".

Hope that helps,
Jonathan
