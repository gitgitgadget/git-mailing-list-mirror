From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 20:32:47 -0800
Message-ID: <20130211043247.GD15329@elie.Belkin>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:33:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4l4w-0002VM-MV
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 05:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab3BKEc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 23:32:56 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:59135 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab3BKEcz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 23:32:55 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so2927388pab.36
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 20:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bI2HEsuU4WrYYTchSP/zTX1wfZM5weJzm0ajeyrehgM=;
        b=JatysJuobijz+Ir61wdcB6PMK4eYjvzBnWGQubZYlO1O4im+1ELyfHCbvLuXZ5aW9H
         JjEMomU3hwhFKpKvFjuRtsxTCCFyZTjfLjsTEqcQxGEp+UreZoZIyUl+R+X9tT4wmJHa
         YW9DGhpsMZkpiFKy0oQwsA78yZI3QU+7uHoVm30MLaBDl94uEU6eZmDQHNksxZ21Rdlx
         N29BJlZcg/bk69KuGz2LoXhMxdPcEF4unNCYIZMRNO9OVm5vMdL2SIPutkBMfrKUyeAH
         s5hbddOFEXEek2LUs/fhNyxA/3N8np2Tbvcs0pDvQ9cEh80niW7JOfX5Rowj2NKeQMk7
         TZ4Q==
X-Received: by 10.68.175.68 with SMTP id by4mr15724053pbc.126.1360557174740;
        Sun, 10 Feb 2013 20:32:54 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id z6sm39581419pav.3.2013.02.10.20.32.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 20:32:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vwqufpj50.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215988>

Junio C Hamano wrote:

>               Are you shooting for customizability?

Yes, and the ability to generate the message dynamically.
