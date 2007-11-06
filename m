From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [BUG] git grep broken on master - won't work when merging
Date: Tue, 6 Nov 2007 15:00:32 +1300
Message-ID: <46a038f90711051800l41e51a68r3e0ff98a7ace433@mail.gmail.com>
References: <46a038f90711051553p6202cc62wfda6b45ff7769984@mail.gmail.com>
	 <7vlk9ckwyn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 03:00:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpDkH-0007CK-FR
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 03:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbXKFCAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 21:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbXKFCAe
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 21:00:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:40275 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbXKFCAd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 21:00:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1028738ugc
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 18:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fxvjiN7oVYr/mHDZOXef4x9HXWpsZjJCuGCIocJe0xs=;
        b=WGX6RGHzItPFsqbZ0UFvNmQnOIVl/RDWJ6qQmpNNmt1TkfFDAjLxd4v1eid4Ykt5YUVW89t9vLHeR2YEa7jRG08QeCdiYnxLxbm0A6etKYGv7PzLYt2Lv3CkRV/JxPEiwZMQzHsvrQQvf5wPAM8eHpNvP2ZnXZuzCqmBTQSDUqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nY2juS5TDhXvD2NcPlePiaNsXsRTf/C6jkeah3wop+1pEga1EtyzmSzSv0IVeiJo7iHJEMYbHEiDlHpsaC6LyUt6fRERuOi7V8pVOYo35df87jrLVLmG9AYZxz3WO9Mu1y8yJCdS/5re54YJqwTgQu474/JdwZw4RLasFW/DwUY=
Received: by 10.66.216.8 with SMTP id o8mr703594ugg.1194314432482;
        Mon, 05 Nov 2007 18:00:32 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Mon, 5 Nov 2007 18:00:32 -0800 (PST)
In-Reply-To: <7vlk9ckwyn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63613>

On 11/6/07, Junio C Hamano <gitster@pobox.com> wrote:
> I think 36f2587ffb6802cb38071510810f48cddfc4f34a (grep: do not
> skip unmerged entries when grepping in the working tree.) is the
> dud one.  Would this help?

Works great here! Thanks!

cheers,


martin
