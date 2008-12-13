From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: support hiding projects from user-visible lists
Date: Sat, 13 Dec 2008 14:05:46 -0800 (PST)
Message-ID: <m3hc57g28b.fsf@localhost.localdomain>
References: <4ba6b6c3fc183002407f322663d7ab53c1c28a91.1229202740.git.matt@mattmccutchen.net>
	<1229203007.31181.6.camel@mattlaptop2.local>
	<m3ljujg2eh.fsf@localhost.localdomain>
Mime-Version: 1.0
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 23:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBcdf-0002NX-2H
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 23:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbYLMWFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 17:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbYLMWFt
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 17:05:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:22788 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYLMWFt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 17:05:49 -0500
Received: by ug-out-1314.google.com with SMTP id 39so69715ugf.37
        for <git@vger.kernel.org>; Sat, 13 Dec 2008 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version;
        bh=GsINrOu2lrFu6bhSWqJqv1c9lPFthAY1MQ8CgePhfXs=;
        b=GNVHXmOh8PjVVVeUMaaomJByh/9iezDMT/MFBcOt3FNY2iGxXkR+H2o/wMbPk6T3sH
         KTSWLAO4AYACwYu1IKll5dU1KNToPSXAfSVh9g6Vl7OaE+fwL/sZzut1cieoOKbeasmY
         Q62SE6OcqLyYBbWUs7y2s2K2+vN2ZVn1Zxjeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version;
        b=TB+67ZJtEvkFQVihXSlg1tBxIQAg04VqbaYPZ/RB/WyE74uCAVvnyYpqE07427H2uy
         1kFQPGf2SeKh5TWtPU/EFa0gDC3BfodD94G6O1VQ+KX02O9/KosgeWvCtMDj+USYbbqc
         bpsa0LsTqf/nbDFByB3gZeSwejW+D9PvYEwMg=
Received: by 10.66.234.13 with SMTP id g13mr782145ugh.65.1229205947266;
        Sat, 13 Dec 2008 14:05:47 -0800 (PST)
Received: from localhost.localdomain (abvz56.neoplus.adsl.tpnet.pl [83.8.223.56])
        by mx.google.com with ESMTPS id d38sm372868ugf.11.2008.12.13.14.05.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Dec 2008 14:05:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBDM5hrC011706;
	Sat, 13 Dec 2008 23:05:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBDM5erk011703;
	Sat, 13 Dec 2008 23:05:40 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m3ljujg2eh.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103027>


By the way, your message [PATCH 2/2] should be threaded, i.e. be
response to [PATCH 1/2] (or to cover letter [PATCH 0/2]), to not
mistake it with other [PATCH 2/2] patches.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
