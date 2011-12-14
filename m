From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test: errors preparing for a test are not special
Date: Wed, 14 Dec 2011 03:00:26 -0600
Message-ID: <20111214090026.GB19424@elie.hsd1.il.comcast.net>
References: <1323815706-10560-1-git-send-email-jratt0@gmail.com>
 <1323815706-10560-2-git-send-email-jratt0@gmail.com>
 <4EE853C0.20505@viscovery.net>
 <20111214082203.GB13166@elie.hsd1.il.comcast.net>
 <4EE863AF.2070606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 14 10:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RakhY-0001aO-Io
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 10:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab1LNJAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 04:00:31 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60369 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab1LNJAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 04:00:31 -0500
Received: by yhr47 with SMTP id 47so1140576yhr.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 01:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hlqNQGcSe+6ZK6/A7iOnOATsShWojpfnN7x5bKNM3jk=;
        b=FclPn9zHrIbgKn6thkfqxZW1/xgqU7RazYEMNaaAMPR3YYJij9/O4ub5SrVyVyznCX
         DWbRrgeaEAcR7VcXkLKhDs+eQDMQbjpL0w0lSAIGsAwBpOk8uFkIYunnl+mkgrEqX3h1
         UPvSRarakkKDG2ukIV6T22XNkcBZz+Hn4kjYI=
Received: by 10.236.79.137 with SMTP id i9mr10222739yhe.73.1323853230512;
        Wed, 14 Dec 2011 01:00:30 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q52sm3088736yhh.3.2011.12.14.01.00.29
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 01:00:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EE863AF.2070606@viscovery.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187104>

Johannes Sixt wrote:

> At any rate, your patch makes the code much more comprehensible.

Thanks for the reminder and sanity-check.
