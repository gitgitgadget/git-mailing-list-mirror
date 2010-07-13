From: Valeo de Vries <valeo@valeo.co.cc>
Subject: Re: Massive repository corruptions
Date: Tue, 13 Jul 2010 11:17:25 +0100
Message-ID: <AANLkTil5XgnUqm3hy4OAEBS9-ylUu7rSmKUAQXD7LcHX@mail.gmail.com>
References: <20100713015600.GA29392@nibiru.local>
	<AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com>
	<20100713050350.GB29392@nibiru.local>
	<20100713053154.GC29392@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: weigelt <weigelt@metux.de>
X-From: git-owner@vger.kernel.org Tue Jul 13 12:18:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYcYz-000149-QR
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 12:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab0GMKRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 06:17:31 -0400
Received: from mail-wy0-f194.google.com ([74.125.82.194]:57258 "EHLO
	mail-wy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab0GMKR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 06:17:29 -0400
Received: by wyi11 with SMTP id 11so1269954wyi.1
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 03:17:27 -0700 (PDT)
Received: by 10.216.68.142 with SMTP id l14mr5007680wed.67.1279016246835;
        Tue, 13 Jul 2010 03:17:26 -0700 (PDT)
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
        by mx.google.com with ESMTPS id m40sm2309676wej.40.2010.07.13.03.17.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 03:17:26 -0700 (PDT)
Received: by wwi17 with SMTP id 17so835451wwi.1
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 03:17:25 -0700 (PDT)
Received: by 10.227.154.136 with SMTP id o8mr11433882wbw.189.1279016245385; 
	Tue, 13 Jul 2010 03:17:25 -0700 (PDT)
Received: by 10.227.142.147 with HTTP; Tue, 13 Jul 2010 03:17:25 -0700 (PDT)
In-Reply-To: <20100713053154.GC29392@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150894>

On 13 July 2010 06:31, Enrico Weigelt <weigelt@metux.de> wrote:
> * Enrico Weigelt <weigelt@metux.de> wrote:
>
> <snip>
>
> What's strange:
>
> when copying pack files from another machine to this box and
> run git index-pack there, it fails with the same error.
>
> also: pushing into a new (bare) repo sometimes fails with
> inflate errors, sometimes succeeds but leaves an broken packfile.

The pack files you copied over from another machine, were they sane
(i.e. non-corrupt)? If so, that perhaps smells like your hard drive
could be on its last legs...
