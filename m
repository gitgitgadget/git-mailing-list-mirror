From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH en/and-cascade-tests 0/7] avoid repository access during "git
 <foo> -h"
Date: Fri, 22 Oct 2010 01:55:22 -0500
Message-ID: <20101022065522.GA3402@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:59:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Bau-0005P7-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab0JVG7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 02:59:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40001 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab0JVG7K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:59:10 -0400
Received: by yxn35 with SMTP id 35so365196yxn.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=E9YRLPT2yGHXH3IHxmlFOeiJTJUoKgqh9fFY3g7UxMI=;
        b=JA/IGHtDOp/XJnqh5JBwxpRwMNm+bmgeTRmm1ifM2WdsFw4/UAl/ojCjPe6J4npQ6V
         Vw+b/zMuP1J1tnQqnyBhH4N4EEJD+7KphDyeJ7iTkItVmjtIuwRAald8hpM4x7hVOoNx
         xmBANuv3+0y5owjjxTHDmeIy97rEJnkCwLQDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=grJ8kkHCukVX33Mml4YFgRW3W+12u0bCkoCy1jnbiXFpH3SeoTRpTudZZkeiCRXUYk
         4fKrIaCCUCgvqvHHRiQLYaCKW6P4lg8WGWjHA6fayFB2eFoax4TKn65UVm7X/o8X8opv
         0fiRIb4JSYOWow4noz4w9Z7Q9lcwHv8IUtJKI=
Received: by 10.90.96.17 with SMTP id t17mr2026809agb.0.1287730749844;
        Thu, 21 Oct 2010 23:59:09 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m66sm2099462yha.21.2010.10.21.23.59.08
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:59:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101022063837.GA6081@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159658>

Jonathan Nieder wrote:

> [Subject: [PATCH en/and-cascade-tests 0/7] ]

Hmph, teaches me to send a series at night time.  The topic is
printing usage information early to avoid repository access during
"git <foo> -h".

Sorry, I should have prepared and sent that earlier.  Hope it
helps still.
