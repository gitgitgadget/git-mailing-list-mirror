From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH] Fix invalid menubar and toolbar entries in plugin.xml
Date: Thu, 14 Aug 2008 23:43:20 +0200
Message-ID: <48A4A6F8.3060205@gmail.com>
References: <48A3310A.8080306@gmail.com> <200808141942.55448.robin.rosenberg.lists@dewire.com> <48A483EF.10508@gmail.com> <200808142242.20476.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "s >> \"Shawn O. Pearce\"" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 23:44:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkcb-00071Y-19
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 23:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbYHNVnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 17:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbYHNVnc
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 17:43:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:40633 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbYHNVnb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 17:43:31 -0400
Received: by ug-out-1314.google.com with SMTP id m2so29960uge.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 14:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PjcUsBFHTzGJ+x5KnbPGxnNvUKhSjMST0evc462ocOo=;
        b=K+3T0NSFxAh64p6+HhPB2CWQMufPWmOnhTMTjTejeeVhHD74EJwLiP07io5zFElm+f
         VkRKDqGe6SPTwyjrmGpAZYiVDiVS5TYScRYm1kVFTwMZb1WfMjbct/CT2DKKSkKdz2li
         ZvSlJ46XJtIqz2HSfvlCo8a+mrhetQQnzpMbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Jzvn2qPkGjacNMXgGvDNA2/P8l0b8jasUtyXR9PYHxMpmgopepd2ZIlr2IiWKwCI+L
         D+u0rMyEr5GRPTSUYtj9lWwZWzAAi5XTSZZlrvGbTF6MUMd2f4OXn9KYqfU6cHSfXlfI
         P/oemj0ylvakfc/0xSz27l66OlbnidmWmigxg=
Received: by 10.210.81.3 with SMTP id e3mr2007245ebb.22.1218750209457;
        Thu, 14 Aug 2008 14:43:29 -0700 (PDT)
Received: from ?192.168.1.20? ( [84.202.12.123])
        by mx.google.com with ESMTPS id c24sm3136261ika.4.2008.08.14.14.43.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 14:43:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <200808142242.20476.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92406>

Robin Rosenberg wrote:
>> Either way I suggest the patch is still valid, because it removes
>> the Git menu from the menu bar. This is consistent with what other 
> But I don't want it removed... , but I can consider hiding the git actions by default.

I see now that both the CVS and SVN plugins have top level menus and toolbars 
(they are hidden by default), so I'm perfectly fine with us doing the same.

Do you want me to resubmit the patch, or is it enough with the patch you amended?

Thanks,

Tor Arne
