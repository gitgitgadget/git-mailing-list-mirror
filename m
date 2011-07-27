From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/18] revert: Don't create invalid replay_opts in
 parse_args
Date: Wed, 27 Jul 2011 06:46:51 +0200
Message-ID: <20110727044651.GF18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-11-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 06:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlw1W-0000LS-Sj
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 06:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088Ab1G0ErD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 00:47:03 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50230 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1G0ErB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 00:47:01 -0400
Received: by ewy4 with SMTP id 4so1030413ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 21:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SVW/q+UacIuHKN6zK08FOUs+AwZtJJBTb3zvqoAjanA=;
        b=jGbB8Mnp2m4F1jhbArXSeV0AZtfgYoi5MXcwljO0soQ0Ufwr10HkijFCvE6JyNKyUY
         jPB4bnPCftct35cdJcenIVqO+5Cpgp514HyENxa1pwmsSIdTydJaNZzR0FOFoIbtefIG
         40GCftz7l1Ou/4Hc3z9d/Cr0/Ic1xYIf+Lk4s=
Received: by 10.213.20.214 with SMTP id g22mr1277983ebb.111.1311742020396;
        Tue, 26 Jul 2011 21:47:00 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id h49sm821389eeh.8.2011.07.26.21.46.58
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 21:46:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-11-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177928>

Ramkumar Ramachandra wrote:

> To futureproof
> the code and catch these errors in one place, make sure that an
> invalid replay_opts structure is not created by parse_args in the
> first place.

FWIW, patches 8-10 all have reasonable goals and look like they
address them in a sane way from a quick glance.
