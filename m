From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: improve 'git --exec-path' completion
Date: Fri, 13 Apr 2012 18:37:06 -0500
Message-ID: <20120413233706.GD13995@burratino>
References: <1334274603-3277-1-git-send-email-felipe.contreras@gmail.com>
 <1334274603-3277-5-git-send-email-felipe.contreras@gmail.com>
 <20120413060845.GA15610@burratino>
 <20120413180436.GA2387@burratino>
 <20120413183048.GB2387@burratino>
 <CAMP44s0R7imiem4uoBggkjjJ4z5+MXVYUroe_23JE8McMCk2sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 01:37:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIq3L-0000Zj-AU
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 01:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329Ab2DMXhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 19:37:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45277 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab2DMXhL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 19:37:11 -0400
Received: by iagz16 with SMTP id z16so4899725iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D0LdLMlteG4g7x8e8/7+Z732yNdKVASNgUw2DSsvUSk=;
        b=u82nQql8q/rbkXDaA+PO6YiMZVg0V7c37vjh2j0nbjj/QCF/iWA7i697cv+PwRbSlM
         hqziFa4zfXJRHu+A4DY4Gy6fygLk0zhMd9ut6hxz5AQoFjOQlsD2PjQX5SHpmAnTy5Jc
         AcmkerZj/j5OObSHPTjAJndzEG11jDWCVCtdyLqf7RLLhFyqhynJ+lWeL7iJO+DV+tbB
         0a/LYLl5G1UjKZUD6HHdIiin0zpvnWGKkJ4Ly4DydZCWHEvLpCGFcRa01mlIMfUbkthD
         Z0Ht7KayHK3kfm17LJAEPVxdrI3i9KJQEvv/6XBz/GleZK7eWgjNorISK4kuXrQr9YZm
         y3DA==
Received: by 10.50.192.168 with SMTP id hh8mr56421igc.13.1334360230610;
        Fri, 13 Apr 2012 16:37:10 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id i7sm148406igq.11.2012.04.13.16.37.09
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 16:37:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0R7imiem4uoBggkjjJ4z5+MXVYUroe_23JE8McMCk2sQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195457>

Felipe Contreras wrote:

> I don't understand, the commit message doesn't match what the patch
> actually does.

Try it, I guess?  At least for me,

	git --exec-p<TAB>

completes to

	git --exec-path <cursor here>

before the patch, and to

	git --exec-path<cursor here>

after the patch.  Which is different from your original patch.

Cheers,
Jonathan
