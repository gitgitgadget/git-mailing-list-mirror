From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Extend project_index file format by project description
Date: Sat, 21 Jun 2008 18:09:07 +0200
Message-ID: <200806211809.07763.jnareb@gmail.com>
References: <200806211540.58929.jnareb@gmail.com> <485D1E76.6090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 18:10:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA5fL-0003ad-Me
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 18:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbYFUQJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 12:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbYFUQJU
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 12:09:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:5884 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbYFUQJT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 12:09:19 -0400
Received: by ug-out-1314.google.com with SMTP id h2so186524ugf.16
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 09:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iTmzX39xB7/btqstEVEmE5tV0Ikoy6yno6P4sHBEL8o=;
        b=rI7EiNLn/sEK5Jh/GYlMwfNlCUHaAWkOtUu40q8lWyatmxqYRlZfG+QJofY8mrl9fs
         SSqXPwSPB7y/I7uz6Nj6ZVQsK0gwg7DVu6XpN3scOU/Fj+7xZq2sOZqQ5SpfgVsECErp
         lohGiZGd7G0mCBE90RxvJNFFWMC8zAZu5gn0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PUWp3Pn/K1UCyq47MxsMwUMusvt3w1MX9zmhwbGKxI2Czpnlqr+57whcugXsQvO68v
         Ov4m198vegh5ld3kMCGZYR21+BuUO/DckvEP0WS51PurbR4ZsNU/0vFz4rtJ6ykDgMam
         8/PwLBbBf+B6dCa5/yz82dzrLNGF1GIJaVSrQ=
Received: by 10.67.19.13 with SMTP id w13mr698782ugi.84.1214064556992;
        Sat, 21 Jun 2008 09:09:16 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.245.230])
        by mx.google.com with ESMTPS id 31sm24602107ugg.25.2008.06.21.09.09.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Jun 2008 09:09:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <485D1E76.6090709@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85712>

Lea Wiemann wrote:
> Jakub Narebski wrote:
>> 
>> The goal is to first, improve performance; and second, to be possible
>> to have single place for all info (well, amost all info) needed to
>> generate projects list.
> 
> I'm not sure if I understand your objective correctly.  If this is 
> exclusively about performance, may I suggest you wait with this till I 
> have implemented caching?  Regenerating the project list might end up 
> being fast enough that it won't matter at all; so no reason to 
> complicate the code.
> 
> If it's about the convenience of maintaining project descriptions in a 
> central place, sure, that's fine.

It is about both, but I think mainly about convenience of maintaining 
(having) all static data about project in one place (well, almost all: 
there is README.html, but it is not visible in projects list page).

What we gain in performance generating projects list (when caching is 
disabled for some reason, like limited quota or/and not installed 
memcached), we might lose when generating project pages (with project 
description).

-- 
Jakub Narebski
Poland
