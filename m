From: Eric Kidd <emk.lists@randomhacks.net>
Subject: Re: [PATCH] filter-branch: really allow running in a bare repository
Date: Tue, 3 Feb 2009 15:56:51 -0500
Message-ID: <431341160902031256k689bb0efo766b4a4f2e356d3d@mail.gmail.com>
References: <cover.1233684552u.git.johannes.schindelin@gmx.de>
	 <alpine.DEB.1.00.0902031910001.9822@pacific.mpi-cbg.de>
	 <431341160902031131s63f34665ne9db25d8a4d1f0f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 21:58:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUSLb-0004DY-R9
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 21:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbZBCU4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 15:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbZBCU4x
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 15:56:53 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:63586 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZBCU4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 15:56:53 -0500
Received: by yx-out-2324.google.com with SMTP id 8so799408yxm.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 12:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=fUEOI96KNc4YitPNTg1giu/uwCT/279GnR/S3G9Eb7s=;
        b=g3b7K7ry9jM13BAN5OJqM+Z92zvTHsbLORzbzwcZyg2NX/fxapvfQMtP3G8nStJwu9
         lDrcLbNIovONEFC8IVTUZImAVFfdrVwrFxI/oOq4asv8C4G2zOWTo63Jhina5zR5eGDf
         xPJ25+1nRgNZCN+saE3+TP4lSVl+XEdeWHtFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Rdz1ifdr6haa+q+8NUh72Wh/wINBACmStMzi1ohUD8Pxx0HCbrIVvkXkHAR3Qy/05+
         yXhTio1M8xKxFTcAlhobXR9jFbQYFiJGO8+2blL46PmiwUAzonqHaC7bSE0ekQTgv0Pl
         Qb+E0QtmA6fB8kKRnyeMxPKLUYb4Rb0nZAfho=
Received: by 10.100.144.11 with SMTP id r11mr4163447and.24.1233694611361; Tue, 
	03 Feb 2009 12:56:51 -0800 (PST)
In-Reply-To: <431341160902031131s63f34665ne9db25d8a4d1f0f9@mail.gmail.com>
X-Google-Sender-Auth: c5f60184daa7f839
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108250>

On Tue, Feb 3, 2009 at 2:31 PM, Eric Kidd <emk.lists@randomhacks.net> wrote:
> Just a few minutes after you posted this patch, I posted a
> nearly-identical fix for the same issue:
>
>  http://marc.info/?l=git&m=123368695831812&w=2

A point of clarification: These two bug fixes are independent, and I
was fighting with my mail queue when I saw Johannes' patch.

Cheers,
Eric
