From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Extend project_index file format by project
 description
Date: Sat, 21 Jun 2008 17:29:58 +0200
Message-ID: <485D1E76.6090709@gmail.com>
References: <200806211540.58929.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 17:31:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA53O-0000fH-Gx
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 17:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbYFUPaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 11:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbYFUPaF
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 11:30:05 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:2650 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbYFUPaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 11:30:03 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1663769fkq.5
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=ZhVvP0+kkHIVy6/fB6VSnTibjIsOYyftpsBlEXd1wg8=;
        b=D6Kt/ZpiNwNnZ76r5i0QNNVapUDs86i2bcV2PIO1Q8yoSohbIpDLxlONxwneFXsIla
         aSCnx7UqUvK00MQlkaQjfhQCgq+sV7GtZgn19SWBxNATFNrZL60mYE+QWsyafGU0oI2Q
         rCCOOv/0MS15/nPqb/13loqgpgxlTix5r/bOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=hEfGwlmuu+ya7xQTvxeoyH4QJ6S/+KHAoqXMeg0HTZAutQqdy/YA8dWSHtaOYwjenJ
         mkFb/nrjctYgPyqdqd/XLgOD28wTvZFHh1gA6uzuCBx0dyvlQ7dbGzUZg+2r4TSHtu2m
         W8kMLJ9qiy6/KwXHezDDzDSlVJ9UjSZhKNsQs=
Received: by 10.78.148.15 with SMTP id v15mr2027125hud.37.1214062198852;
        Sat, 21 Jun 2008 08:29:58 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.251.200])
        by mx.google.com with ESMTPS id 35sm4751960huc.37.2008.06.21.08.29.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 21 Jun 2008 08:29:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806211540.58929.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85710>

Jakub Narebski wrote:
> This is an RFC mainly because I don't know if it wouldn't conflict
> with Lea Wiemann work on adding caching support to gitweb;

If you're talking about merge conflicts, it applies fine on my current 
working copy.  (There's trailing whitespace on the "@pr_info =" line, by 
the way.)

> The goal is to first, improve performance; and second, to be possible
> to have single place for all info (well, amost all info) needed to
> generate projects list.

I'm not sure if I understand your objective correctly.  If this is 
exclusively about performance, may I suggest you wait with this till I 
have implemented caching?  Regenerating the project list might end up 
being fast enough that it won't matter at all; so no reason to 
complicate the code.

If it's about the convenience of maintaining project descriptions in a 
central place, sure, that's fine.

-- Lea
