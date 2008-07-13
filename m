From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk - work around stderr redirection on Cygwin
Date: Sun, 13 Jul 2008 16:37:20 -0400
Message-ID: <487A6780.7030500@gmail.com>
References: <1213462668-424-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>, paulus@samba.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:38:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI8Kx-0006yP-SX
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbYGMUh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYGMUh1
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:37:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:48916 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbYGMUh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:37:26 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2268781ywe.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 13:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=CM8hGvbI71cNRO5fKVTM/IyOD6UEmSRj9zecuXqQ1p0=;
        b=XGWo16AeIebfBnDai7SdCY3BOYE1DZ2zocjJG6nQLcn8j/HOK6os2j3JlK5wXj+jYf
         sySFjYRlQI4kdOyIKFcQ8bS14qpVjTsfZaj3S12evNGSrav6ihQFkjRVRSBLTp37ZqiX
         /0VmxVE37MYfsof2SkPTMP1n998GdyZ8uyiJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bQPir4a48k9NXciTxrGMUWb+JSjoam+4Z2H33imLAbvo74qrr4OHgaVl2MxImggAh4
         391MWjZ4Dy6fgFMR2GuftySuG4sPyT6niscP9vcP4aSnFACiWezwsYcg0tVl6F/zF+UZ
         mMCdlh1ED6mo9virJ+OBuIO+aE/CTIar+9rX4=
Received: by 10.150.95.5 with SMTP id s5mr19088643ybb.246.1215981443379;
        Sun, 13 Jul 2008 13:37:23 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.191.242.168])
        by mx.google.com with ESMTPS id 5sm4906323ywd.8.2008.07.13.13.37.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jul 2008 13:37:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <1213462668-424-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88335>

Mark Levedahl wrote:
> Cygwin is *still* shipping with antiquated Tcl 8.4.1, and will continue
> to do so for the indefinite future. This version does not understand
> the "2>@1" redirection syntax, so such redirection of stderr must be
> done using sh.
>   

Ping. This bug is in 1.5.6.x, and thus also in the current Cygwin git 
release: as a result, several gitk context menu items cause errors. (Let 
me know if I should resend the patch).

Mark
