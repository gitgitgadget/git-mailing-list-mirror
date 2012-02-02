From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 04:55:27 -0600
Message-ID: <20120202105527.GI3823@burratino>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino>
 <CAMP44s0w1eXWWaMT3WAfLxFHPQvc9dp33cyJ=T2im6g7rsrKhw@mail.gmail.com>
 <8739at8qw6.fsf@thomas.inf.ethz.ch>
 <20120202105006.GH3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 02 11:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsuKT-0006AR-WD
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 11:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459Ab2BBKzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 05:55:45 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:53516 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755290Ab2BBKzp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 05:55:45 -0500
Received: by obcva7 with SMTP id va7so2617162obc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=94RMxeI4ZtxwvBfdPa3gZyVQxdP85vANYJyu7+Z/Zsc=;
        b=Mm61NeGx5Gxo9yAZbhpcTIm12My16Z82R3JhKmHIg1zDG/MgFfBoZa9sVIhkrLNIig
         nsKzXoCI63UHHyle1ZigIoo9hH/q03DNCWf1+iJWXcV7a5xYIBHsjo8S+eaAegRn1et0
         kl393DXtoSzidxcOXHoEKisN/56neDoxpr+W0=
Received: by 10.50.154.200 with SMTP id vq8mr2651830igb.14.1328180144586;
        Thu, 02 Feb 2012 02:55:44 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ub10sm9436332igb.7.2012.02.02.02.55.43
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 02:55:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120202105006.GH3823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189620>

Jonathan Nieder wrote:
> Thomas Rast wrote:

>> Perhaps you could compromise on
>>
>>   completion: work around zsh word splitting bug in : ${foo:=$(bar)}
>
> Thanks, that looks like a good subject line to me.

Ah, except it's not a word splitting bug.  It's an option propagation
bug.
