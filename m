From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git as a backup system?
Date: Mon, 8 Nov 2010 12:04:27 -0600
Message-ID: <20101108180427.GA4005@burratino>
References: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:04:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFW5J-00066z-A7
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab0KHSEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:04:44 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38329 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab0KHSEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:04:43 -0500
Received: by pvb32 with SMTP id 32so1377896pvb.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 10:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yY1FhTuDqCNxxp8GJrhSIGcaI5DE6agKyKb/zJKbp7M=;
        b=v1/PU8iWd6YdlHSdBlKFz+wRV++a4AFLMDoKinHZUyg4SQ/69qeYCfkou+Sv/Beteq
         azVB6oWCkGm/IngK3i6mpzl16KXixkEEh5nOD3ZjTyAZOLhbfR6mZtiYiyt3cHt+6PrQ
         kGiI6TM77CnGpk/SvStyEtnUEjkwWkfFoYCDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ls5C87K49yTpbK9GVfVtLE5q/FfB6gN+rGTfA/3LgSkJuqcbBcVEj5w33+Fq8+mnJf
         F4/Yrb3HMyI4ggtCPg/EDpJbrcwWSsqXZ3mX7iZ0L4HSrOnLMCH61gywi9X+1Ed9i+6Q
         2Hh9lPwIg8cEqlEpipSpz1dVTGlTtpBXqn30c=
Received: by 10.224.214.5 with SMTP id gy5mr4125251qab.215.1289239482922;
        Mon, 08 Nov 2010 10:04:42 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id k15sm143198qcu.35.2010.11.08.10.04.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 10:04:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160959>

Eric Frederich wrote:

> Am I insane?  Are there other tools more suited toward this?
> I just thought of using Git since I looked at my 9G worth of data out
> there in my backup directory that is almost exactly the same and said
> "git could handle this well".

You might like bup: https://github.com/apenwarr/bup#readme
