From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] Mark new entries skip-worktree appropriately
Date: Fri, 30 Jul 2010 22:29:02 -0500
Message-ID: <20100731032902.GA1607@burratino>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
 <1280135310-2347-3-git-send-email-pclouds@gmail.com>
 <20100731023219.GB906@burratino>
 <AANLkTikhXy1KjA5=SJ9ZwS_XtV99aHPkeo3XoPXqxeKh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 05:30:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of2mE-0005Cs-IM
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 05:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab0GaDaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 23:30:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45553 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab0GaDaP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 23:30:15 -0400
Received: by iwn7 with SMTP id 7so1953352iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 20:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1aMLLSkGUBtBzw0RAxMShjx339zjnoMRPTw0FD5jdUc=;
        b=DCDz+FBb9VWYv3WaQthJfgvgNFKOeVnVMgTKpCmkPzdoQYJdxccX7LCags6T4JwVh2
         57PwyqHTdnP79cY51mJDQOyU3dZGmGJhc/ybaZ5ZlcHDzFWF7OrmwIh3qhW1iOagA1+p
         5OZar0wIGVgxboaPSsty37atrfhL3PEQ2Q3LA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DIvC15REQeSN5s7E2fwR/MFC2aHva9xUmwuIa5+gyjR+cq9hNLEJyGSyC/+LckOikx
         usoHKjggefPxzfshYVcLLeYNOsxk7gEUoulZw+xpMsJg6/+ZzIdtkpzT8gL87vnskyvS
         z5KMowiu/NW9E3LMxX976SaEUt0SJsucuGITI=
Received: by 10.231.191.74 with SMTP id dl10mr2716624ibb.157.1280547014421;
        Fri, 30 Jul 2010 20:30:14 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm2594810ibb.2.2010.07.30.20.30.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 20:30:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikhXy1KjA5=SJ9ZwS_XtV99aHPkeo3XoPXqxeKh@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152296>

Nguyen Thai Ngoc Duy wrote:
> 2010/7/31 Jonathan Nieder <jrnieder@gmail.com>:

>> Do I understand correctly?
>
> Yes.

Ah, good.

This is fun code to play with.  Thanks for putting it together.
