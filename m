From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: linkify author/committer names with search
Date: Tue, 13 Oct 2009 11:39:06 -0700
Message-ID: <4AD4C94A.9010909@gmail.com>
References: <1255328340-28449-1-git-send-email-bebarino@gmail.com> <1255429615-4402-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 20:42:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxmK6-0007GK-2z
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 20:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933997AbZJMSlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 14:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760885AbZJMSlA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 14:41:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:32207 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760884AbZJMSlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 14:41:00 -0400
Received: by fg-out-1718.google.com with SMTP id 16so959692fgg.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=cKsFlV7DUAA64X5EKCr13ELGd39/ouRSNvu355msXQA=;
        b=QmwVifxPRjQHAY2y4umjLu5qWqloaU55C03QBU0cKI/ZoJXVAoT99PF9+ksfWjsVUu
         B8xo7jbPrM2L9t1OWApYMULUQzVeHBg8yEGVoBkGQNPNKT1DHHrYMnBMmulC6yO5mvDl
         JCP2j2YouaFfaCssup6Do2VF4vl3nt2JVF8NU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=Zl8wiLjEXX7/sYzYxHjT2TxEQbmIV07Mv1vCSgCQ3AI5faVMQTXmQqzjDyaN8Qck7J
         HaVNaypDou//AW43FBEUFideZUGL5QbWawGKGZlizSFxSn6ZaXvBHs1DVjeOQBZYlBAx
         N0KonScol7yohoAubTKruANFfhtMvVASxEz88=
Received: by 10.86.195.29 with SMTP id s29mr2743890fgf.73.1255459152387;
        Tue, 13 Oct 2009 11:39:12 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 4sm181717fge.22.2009.10.13.11.39.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 11:39:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <1255429615-4402-1-git-send-email-giuseppe.bilotta@gmail.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130182>

Giuseppe Bilotta wrote:
> On Monday 12 October 2009 08:19, Stephen Boyd wrote:
>> The problem is I can't get it to work with UTF-8 characters. I'm not sure
>> if it's my system or not, so I'm just posting here to see if others
>> experience the same problem and if there's interest.
>
> Does it work if you use CGI::escape() on the author names when filling
> the searchtext?

This doesn't seem to work. Now I get %25 in front of the escaped
characters. For example, a space is now %25%20.

Can you reproduce my problem locally?
