From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 05/10] gitweb: use fullname as hash_base in heads link
Date: Mon, 25 Oct 2010 17:07:33 +0200
Message-ID: <AANLkTimcsjo1rH5EFZxnDOrR5pfgHamxN=z30OBSa=Xo@mail.gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1287917136-26103-6-git-send-email-giuseppe.bilotta@gmail.com> <201010251657.02802.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 17:08:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAOea-0001A4-FE
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 17:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab0JYPH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 11:07:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45033 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671Ab0JYPHz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 11:07:55 -0400
Received: by gyg4 with SMTP id 4so2076542gyg.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=h2ezx9HVPhcFKcHLKRaJNYwflxJXejmRTsB7+7D35cU=;
        b=YQ1tE7iQb7eePZr7uaET6rfsvwsue8k8kEKINejDD6TxLaQF0OPpnU5RFZQhb9AeBJ
         Q1AxlctFg+s2DvjBxws+6qVOYDSnPblFZYhCn6OC9VVNWgtBxWqxwvlhHSpkMMJf0l3U
         IHciyNCE/ame2e4ZmFYNX0zW3mAABlxFYjA5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qyXTkGhn95+yOqFMkgDIuIyiEVbrpt4RXMonYVlO/vmuFjbN0ifGuWagwfp5jf2jp6
         UPnOF82WKSABxvv2g01HdB98+QTRRytNmDecS/FoG8d8+YYjHoXH2lZV4YDdxK4FkGqw
         Zai/Yq99HA7YRgBg9dNjuLNwrjcOyz4TuwIiM=
Received: by 10.42.204.66 with SMTP id fl2mr1065900icb.280.1288019274288; Mon,
 25 Oct 2010 08:07:54 -0700 (PDT)
Received: by 10.231.149.141 with HTTP; Mon, 25 Oct 2010 08:07:33 -0700 (PDT)
In-Reply-To: <201010251657.02802.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159956>

2010/10/25 Jakub Narebski <jnareb@gmail.com>:
> On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:
>
>> Otherwise, if names are manipulated for display, the link will point to
>> the wrong head.
>>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
> Shouldn't this patch be at beginning, as first patch of the series?

Given how independent it is from the rest of the series, that's
probably a good idea.

-- 
Giuseppe "Oblomov" Bilotta
