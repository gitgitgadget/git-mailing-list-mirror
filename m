From: Orestis Markou <orestis@orestis.gr>
Subject: Re: git-svn doesn't recognise trunk as parent of branch
Date: Mon, 13 Apr 2009 10:35:40 +0300
Message-ID: <C093912B-E316-4AC1-B50D-D91FF9823582@orestis.gr>
References: <F562B0FA-6E9F-45AD-ADD5-D6EE1AD9C248@orestis.gr> <20090412185440.GA25300@m62s10.vlinux.de> <3110D1F9-B096-4E10-8795-748EF5E38318@orestis.gr> <CDAC8304-EADC-4481-96C9-968DCC4E61A5@orestis.gr> <20090413072601.GC25300@m62s10.vlinux.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 13 09:37:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtGjL-0003Y6-5G
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 09:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbZDMHft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 03:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZDMHft
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 03:35:49 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:33898 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbZDMHfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 03:35:48 -0400
Received: by fxm2 with SMTP id 2so1883828fxm.37
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 00:35:46 -0700 (PDT)
Received: by 10.103.138.16 with SMTP id q16mr3169008mun.114.1239608146652;
        Mon, 13 Apr 2009 00:35:46 -0700 (PDT)
Received: from ?192.168.1.5? (athedsl-129796.home.otenet.gr [85.75.82.163])
        by mx.google.com with ESMTPS id e9sm9244511muf.8.2009.04.13.00.35.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 00:35:46 -0700 (PDT)
In-Reply-To: <20090413072601.GC25300@m62s10.vlinux.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116416>

On 13 Apr 2009, at 10:26, Peter Baumann wrote:

> On Mon, Apr 13, 2009 at 02:58:45AM +0300, Orestis Markou wrote:
>> And I also realised that I don't need to rewrite the history  
>> itself. I
>> was confused because gitk was caching something and I had to  
>> restart it
>> to see the updated info.
>
> The rewrite is done by git filter-branch and this *will* be  
> necessary if you
> ever want to clone/push/fetch from/to this heavily grafted repo.  
> Grafts are
> only repository local and using filter-branch, you could make them  
> permanent.
>
> -Peter


Thanks - I understand that. However, this is a git-svn repo, and I  
don't have a need to do so. The suggestion is to not push or pull  
between git-svn repos but go through svn - AFAICT, that is.

Orestis
