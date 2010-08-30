From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Sun, 29 Aug 2010 21:40:20 -0500
Message-ID: <20100830024020.GB4010@burratino>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
 <20100830023812.GA4010@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 04:42:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpuK3-000805-9O
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 04:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343Ab0H3CmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 22:42:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44795 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab0H3CmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 22:42:05 -0400
Received: by gyd8 with SMTP id 8so1819423gyd.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 19:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OnLwY6VBPm7DcSfWI/QHQa4bQ/RiQDX0tP/bMs2cVRU=;
        b=sJwBTDiRiyLhSQisJYNyBhguENJfKUtlZdJNxGR/D/Cq31mists8ox8C/AKXhivlOx
         xFxFaUpRkVUaGb6nuwNl8pAfhrVsFrbdwaHUtkHXqvvZspf5vmXPAu8jSOM9l0X8Tqbo
         STThdK+fkEIyu480APfOZDa1ZEhyj8qfCNPRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aextjy91cl/l+gAiXP4fbSZ41o+cxiKeNT7+mvz4Ym/2iJMqv727arp640QsP0R8Mr
         dhk2YWINb/XQyt2uwDshLKmypJ41PpmZUaiHXQBPz8XZJZj+TLbqGnHvZtNtWT/cyTlV
         NWQy775ryHJdht3G5GFRjjtunv9uaXYdjkenc=
Received: by 10.100.232.7 with SMTP id e7mr3811126anh.133.1283136124221;
        Sun, 29 Aug 2010 19:42:04 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c7sm11732643ana.38.2010.08.29.19.42.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 19:42:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100830023812.GA4010@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154754>

Jonathan Nieder wrote:
> Thiago Farina wrote:
>
>> Promote cmd_version to a builtin, by moving it to its own file
>> in builtin/version.c
[...]
> What does this make easier?

To answer my own question: it moves the code to the builtin/
subdirectory.

 $ git grep -F -e cmd_version -- builtin;	# before
 $ git grep -F -e cmd_version -- builtin;	# after
 builtin/version.c:int cmd_version(int argc, const char **argv, const char *prefix)

So for what it's worth,

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
