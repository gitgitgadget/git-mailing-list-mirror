From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/7] gitweb: separate heads and remotes lists
Date: Fri, 17 Sep 2010 00:46:40 +0200
Message-ID: <201009170046.41074.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <1284629465-14798-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 00:47:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwNEH-0003pv-Vf
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 00:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab0IPWqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 18:46:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64986 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502Ab0IPWqs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 18:46:48 -0400
Received: by bwz11 with SMTP id 11so2086439bwz.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3dV+OHWu47sKQ3dDPWRco6YGwLiwk4SloIudOSYRpYQ=;
        b=GDjO199LZiRIQRwnR+U5qe1IRYTrV61U5vB3zJ1CVgONnMQYxf90jARb+irwORBVft
         mRGMi+y1ZjluraZtNYHT0evRXlG3MvLaMYutBrzSbL3IjwCraw39S0hy1d8AoaTQN/TN
         QOjJsn+TmRZku1GyYjLxvKUYrG03RLtA3yGk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GfNRHHoUt3c6lnirUoW7BKFaT4LBbwBOo6UZsj3dWGWeCQtDsohDQdo+ROqyN8cTov
         /tFvGAJG4ryBq2iQVhx76Vo7camPir8DvUeeGNn1Y7+2hCzXYPvEIu/5zpF1+Cre3vJk
         WXSTnB5xQfO1TsuK6vtxQdtnnxPBfiV7QuTj4=
Received: by 10.204.98.19 with SMTP id o19mr3306598bkn.6.1284677206676;
        Thu, 16 Sep 2010 15:46:46 -0700 (PDT)
Received: from [192.168.1.13] (abvm37.neoplus.adsl.tpnet.pl [83.8.210.37])
        by mx.google.com with ESMTPS id y2sm2958734bkx.8.2010.09.16.15.46.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 15:46:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1284629465-14798-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156359>

On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:

> We specialize the 'heads' action to only display local branches, and
> introduce a 'remotes' action to display the remote branches (only
> available when the remotes_head feature is enabled).
> 
> Mirroring this, we also split the heads list in summary view into
> local and remote lists, each linking to the appropriate action.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Very nice.

ACK.

-- 
Jakub Narebski
Poland
