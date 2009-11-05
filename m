From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGIT PATCH/RFC]
Date: Thu, 05 Nov 2009 11:13:12 +0100
Organization: LyX
Message-ID: <4AF2A538.7040303@lyx.org>
References: <4AF19630.2070402@lyx.org> <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 11:13:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5zLI-0003eR-OC
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 11:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbZKEKNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 05:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752840AbZKEKNM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 05:13:12 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:11137 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbZKEKNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 05:13:11 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1097270eyd.19
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 02:13:15 -0800 (PST)
Received: by 10.213.25.66 with SMTP id y2mr3491250ebb.97.1257415995733;
        Thu, 05 Nov 2009 02:13:15 -0800 (PST)
Received: from ?192.168.4.216? ([62.161.104.182])
        by mx.google.com with ESMTPS id 5sm3175370eyf.39.2009.11.05.02.13.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Nov 2009 02:13:14 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <e5bfff550911050141t751d45a0r4e340fa0d10af366@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132220>

Marco Costalba wrote:
>
>>  uint qHash(const ShaString& s) { // fast path, called 6-7 times per
>> revision
>>
>>     
>
> Function:
>
> uint qHash(const QByteArray&);
>
> is already defined in the Qt Core libraries, so I have a link error
> with your patch.
>   

By the way, this function of yours is not used anywhere AFAICS.

Abdel.
