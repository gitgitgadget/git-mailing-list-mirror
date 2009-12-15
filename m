From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] octopus: make merge process simpler to follow
Date: Mon, 14 Dec 2009 23:35:13 -0800
Message-ID: <1260862513.1571.443.camel@swboyd-laptop>
References: <7vk4wrrkce.fsf@alter.siamese.dyndns.org>
	 <1260859755-3990-1-git-send-email-bebarino@gmail.com>
	 <7v3a3c3d5p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jari Aalto <jari.aalto@cante.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 08:35:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKRwe-0003Dh-4G
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 08:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbZLOHfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 02:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbZLOHfV
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 02:35:21 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41809 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228AbZLOHfR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 02:35:17 -0500
Received: by yxe17 with SMTP id 17so3412311yxe.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 23:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=VYyQUqmzbYzQujDaQ23iBHfYiai0ROxELy/SMmdk4dI=;
        b=UchiQ21IY54AaNxg1teu+dtg5GbyYOUdTMeQn+y1qDEoDagzjDz6HDG5SABvK5F2xr
         KjbtUZmaXCJZnTlJwwYdP+El+MzLlKzyzYUTRdJQdwfJg0hJsfwtlYcY5fXF+/DVr41/
         59ubxua2cdtJa3KyvSy1OFm1UH/3bpfW0dcMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=gN31S8GP9wMMhbHNWdOVNzuQi2nX15iy58Hy0N4lL3en0gfQmzwzvbrGCXQ7EDt3uV
         ml7zBlKZwnRyAmo0cRzT72UEGvEMYiUuWqKUE3yX55q9NXbSV/kKHfqPmJXDoQJZGWMY
         NsBfc9I1Mw6yhL8bwkKUSJcRqiPbd/ZAuasmk=
Received: by 10.90.13.40 with SMTP id 40mr2747561agm.14.1260862516484;
        Mon, 14 Dec 2009 23:35:16 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm1864518ywh.18.2009.12.14.23.35.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 23:35:15 -0800 (PST)
In-Reply-To: <7v3a3c3d5p.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135277>

On Mon, 2009-12-14 at 23:32 -0800, Junio C Hamano wrote:

> Ah, thanks and sorry for having you do an extra work.  I amended the
> assignment further like thi,s but haven't got a chance to push the result out...
> 
> 	eval pretty_name=\${GITHEAD_$SHA1:-$SHA1}
> 

Great, thanks.
