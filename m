From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: [ANNOUNCE] Git v1.7.12-rc0
Date: Tue, 24 Jul 2012 07:18:57 +0000
Message-ID: <1343114337-ner-233@calvin>
References: <7vwr1thhjz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jul 24 09:19:22 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1StZOo-0006C5-5D
	for glk-linux-kernel-3@plane.gmane.org; Tue, 24 Jul 2012 09:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab2GXHTN (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 24 Jul 2012 03:19:13 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:60871 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831Ab2GXHTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jul 2012 03:19:12 -0400
Received: by ghrr11 with SMTP id r11so6332093ghr.19
        for <multiple recipients>; Tue, 24 Jul 2012 00:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=KDDh14cutR2aUkN6HeNU3sYK15antPQ9l6df9Ciifbk=;
        b=mRCPvMmvMP8T0QyKKkhh/8eMN9TtMXAhcXgngHan6ufNYjrnbhqGh4ak5JbunadgdG
         4jdL27gJQRTFVkVFKUohHz5YDE/eaDzQ2NceMs8W1XBscf1fbTXC2AxAPT1Qqo9ey8hd
         88KYc8j1U2L/5Xi9xGAhFClLYzEKiehGgICEvPBVI+xFxXL/jQ6tsb+4X71C2k95BWD6
         27znS0QXx68FwCiEnSelhW+tTDoGdldStg/+XFLX5V6OqSwXfPeF9ev5l0fdpN0y+Q3D
         K/6MJKMXgJtVv0DEiG8GR1JQ7uExK3huIefvAs9QnIY1Ue76frb3RR5lh6Cbd06ys4fD
         rNAQ==
Received: by 10.236.141.42 with SMTP id f30mr17601084yhj.120.1343114351721;
        Tue, 24 Jul 2012 00:19:11 -0700 (PDT)
Received: from calvin.caurea.org (cl-52.zrh-02.ch.sixxs.net. [2001:1620:f00:33::2])
        by mx.google.com with ESMTPS id y10sm28381869yhd.6.2012.07.24.00.19.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 00:19:10 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 2E7814AEF78; Tue, 24 Jul 2012 07:18:57 +0000 (UTC)
In-Reply-To: <7vwr1thhjz.fsf@alter.siamese.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202018>

On Mon, 23 Jul 2012 22:08:48 -0700, Junio C Hamano <gitster@pobox.com> wrote:
>  * The value of core.attributesfile and core.excludesfile default to
>    $HOME/.config/attributes and $HOME/.config/ignore respectively when
>    these files exist.

$HOME/.config/git/attributes ..
