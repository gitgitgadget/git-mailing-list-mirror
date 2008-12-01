From: dhruva <dhruvakm@gmail.com>
Subject: Re: git build on msys fails (and fix)
Date: Mon, 1 Dec 2008 17:18:16 +0530
Message-ID: <e3f230850812010348w793e17c2q6ab92cf9b2c04972@mail.gmail.com>
References: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com>
	 <4933A922.7080300@viscovery.net>
	 <e3f230850812010132g48fcdf2fm46310b601990e51d@mail.gmail.com>
	 <e3f230850812010252i67d9846cg439b5951485ee7fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 12:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77HT-0002SZ-Jh
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 12:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbYLALsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 06:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752343AbYLALsS
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 06:48:18 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:23928 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbYLALsR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 06:48:17 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2629072wfd.4
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 03:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FDRgRZ4eZTuERPpDRI13P+Ow/ISthd3uag5fl90RvrQ=;
        b=SwSOIve1vcYqO2s8dN4ddytHBuJz5N5eXeE6rt98WoGnb8jVovtZU2oqHeWWXG8g9K
         J0YbDpfGAPFLJCO3tCtj/TBgcF7R/lcepAEiV8sLCQYo+iHxhjqZet4A+iJoEKtUnxd6
         qvNnmHlFU0TVNjyl/hP/eD+wksNC6WcKSxr+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lbr41HlKfSavVk2AAe9rh4/jb9E4YCGhfW/GV1QmFKfz2rCqP+ggPh+pk/AxDtiT19
         pynq91QuDlnNThDlGDCDlF7nMOy7Vfj6/TvHoidLfvts6vVRBKadamqwY/SfejXwH/fk
         1BX8CSp46FM1BLFl5I4zUBUpZDw8P3vVQ6t0E=
Received: by 10.142.103.11 with SMTP id a11mr4473606wfc.208.1228132096644;
        Mon, 01 Dec 2008 03:48:16 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Mon, 1 Dec 2008 03:48:16 -0800 (PST)
In-Reply-To: <e3f230850812010252i67d9846cg439b5951485ee7fe@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102023>

Hi,
 I got the mob branch and I fail to see the Makefile. I decided to
just add the pthread related files and push so that someone could
build, I get authentication failures. I had tried to push perl
sometime back when I had a gcc compiler perl (before strawberry perl)
and had similar problems. I am fairly certain I am doing something
wrong but cannot figure it out!

I have kept the minimum pthread files needed to build in the following location:
http://dhruvakm.googlepages.com/pthread.tar.gz (40kb)
You need to modify Makefile to add for MinGW:
THREADED_DELTA_SEARCH = YesPlease

-dhruva

-- 
Contents reflect my personal views only!
