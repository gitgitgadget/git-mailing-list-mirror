From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: convert from perl internal to utf8 for commitdiff_plain
Date: Tue, 29 Jan 2008 13:40:21 +0100
Message-ID: <200801291340.22421.jnareb@gmail.com>
References: <87ve5dicih.wl@mail2.atmark-techno.com> <7vejc1qium.fsf@gitster.siamese.dyndns.org> <87ejc0j08t.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 13:41:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJplx-00035r-Ld
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 13:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbYA2Mke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 07:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754267AbYA2Mke
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 07:40:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:12042 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbYA2Mkd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 07:40:33 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2076703fga.17
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 04:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=GRg0HObV4qZoSI9ycJNJbvDzqPWY+LbZYdqcuvFLab4=;
        b=jSiLXuVdPfWjil/pkvDbgQuv7j+SiHZOx/izuRLdSICUe52gMfsyndK/gyz7wU0hFDyVPK5hoTB8x+Kx4MrtONMF6FFm6HEWQrTxKTxCSNneW4yjITzYFzCXxqIkXArzpBTHQ0WY5qAwAgxzYQwpNKMJebDGbYW0pK3LD+mQfWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=herVYAuOYhu40H1iU8nDgQjSZhpbTq7SPMWbz+L2vIfuoQkIPV6z7XyhAHe9RAzxyfMC8hlNUtlzmn4RHenaUP7UKvHLhII0T+5GqNBEOdL/nd/UFqNv7Uc/j1GWRwMYyr+E7bAK2A+tEWlyRAgs9LDvrpNzxX+tDJVx1XhiRCA=
Received: by 10.82.174.20 with SMTP id w20mr12054033bue.28.1201610429481;
        Tue, 29 Jan 2008 04:40:29 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.244.23])
        by mx.google.com with ESMTPS id i6sm1625029gve.5.2008.01.29.04.40.26
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Jan 2008 04:40:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87ejc0j08t.wl@mail2.atmark-techno.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71976>

Yasushi SHOJI wrote:

> Junio, please use this if you are ok.

While we are now in feature freeze, I think this can be considered
a bugfix.

-- 
Jakub Narebski
Poland
