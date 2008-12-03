From: "Tzury Bar Yochay" <tzury.by@gmail.com>
Subject: Re: Is there a way to control the number of revisions will be saved by git
Date: Wed, 3 Dec 2008 20:23:38 +0200
Message-ID: <2f5ea7490812031023j6f338eb4v3f272b7d9d88fd33@mail.gmail.com>
References: <2f5ea7490812030301p29e944fw5f59943dc352cd09@mail.gmail.com>
	 <2f5ea7490812031020l57ec1a04x257c66549f3dac8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 19:33:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7wXH-00032m-Qr
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 19:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbYLCSb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 13:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYLCSbz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 13:31:55 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:11695 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139AbYLCSby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 13:31:54 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3043582fkq.5
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=KhDm9+halXYQw0ILYXHZJcAjS2gQUVS0So0ThRgzHGc=;
        b=TgXv53Sy2Lzwz7tcHTp1ZwEP7nqCFoyR2ncWiB4aEwdo5rCQO/BVMFduYbTRPz6Of6
         AfAmrHxL2q/IvCGBmMskyzabPnz6SvIhPGjhG5iZN4SfZ5MbR+osn30jt25700ohAkSx
         u6ihBeV4uNfJP5fmt5PTShkS88FyCzxDwWGxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Vx+9Rf3vWviSUQpv+rlSWEoLJHMomRDtF+fca5378zrYu4ot/R7xOg702wAlh2uHK5
         ZjTavsrZT24rQXKABgMNjaQwEPLYw1A8xEJBhHcP43HB8u82NDHkALCwIekIDwkFiRbY
         JPwsNgjVP4PgjWbF46f3bYLVOyWrTR/7/3mdg=
Received: by 10.181.208.11 with SMTP id k11mr4726492bkq.180.1228328618119;
        Wed, 03 Dec 2008 10:23:38 -0800 (PST)
Received: by 10.180.249.13 with HTTP; Wed, 3 Dec 2008 10:23:37 -0800 (PST)
In-Reply-To: <2f5ea7490812031020l57ec1a04x257c66549f3dac8a@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 21ac4613de83a8d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102276>

On Wed, Dec 3, 2008 at 8:20 PM, Tzury Bar Yochay <tzury.by@gmail.com> wrote:
>> Why would you want that, by the way?
> I was thinking of building some experimental application on top of git
>

Looking at the numbers (of bytes). GIT's efficiency seems to redundant
this option which was a result of my concern about disk space usage.

GIT creators are magicians!
