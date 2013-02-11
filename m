From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 22:15:53 -0800
Message-ID: <20130211061553.GJ15329@elie.Belkin>
References: <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <CAE_TNim2wrL3SWxy_2ugyGmEFDngBJ8+z04y2tJFzMo4N8mUug@mail.gmail.com>
 <20130211060911.GH15329@elie.Belkin>
 <CAE_TNi=fN66+9WfMn86H6J_BVAjFP=xiE8m3JHe_4ANHB2V5wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Ethan Reesor <firelizzard@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 07:16:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mgk-00088s-Gf
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 07:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab3BKGQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 01:16:03 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:52058 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab3BKGQC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 01:16:02 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2637025dak.30
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TKHJkAm1CKMgQkLJQ+rg6HiKT1QmSUpDL2eb+nYoMww=;
        b=E+vwgwN3UF4REy6LfxhpS40ycaRBKoLbJcAdiQv+Gk0+Wmc1Gt17Hjp/rmiESecGHV
         Kmp0VOqd0N8D0Y+VRbmPWsELXAp5/4TJLUO2ytZ45ups7QyMtxkn8s/9l5NwFqKFYZzF
         w5tmzaLgdrJAhSDdjGYm7uvgsZB00vQwwJ8jdQYO0axS3PEGw/FnA7UO7x8Wm867Eb2k
         uBtTRS214rcElJ6hWFQPiMt3IzggvRv5ouih2IvC1m0rIoBLdNPN+LqWqUi4zXIkLXKJ
         ak96qXwu9R8kBUxrMc2c3LoabRisvQXmrj5nzibk3wAuhcCQ1qA8xbu/G2HBhfToSnku
         w1cg==
X-Received: by 10.68.58.2 with SMTP id m2mr15804173pbq.132.1360563361283;
        Sun, 10 Feb 2013 22:16:01 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id io6sm6635977pbc.24.2013.02.10.22.15.58
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 22:16:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAE_TNi=fN66+9WfMn86H6J_BVAjFP=xiE8m3JHe_4ANHB2V5wA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216002>

[administrivia: please don't top-post]
Ethan Reesor wrote:

> Why not have both? That way there is a way to get a customizable
> response that avoids Junio's complaints and there is a way to do what
> you are trying to achieve.

What was Junio's complaint?

Jonathan
