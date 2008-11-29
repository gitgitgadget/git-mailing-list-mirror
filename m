From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: more merge strategies : feature request
Date: Sat, 29 Nov 2008 11:48:45 -0500
Message-ID: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 29 17:50:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6T1A-0000WG-Mp
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 17:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbYK2Qss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 11:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbYK2Qss
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 11:48:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:35888 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbYK2Qsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 11:48:47 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1290964fgg.17
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=AEE+apg5RZE7h8W+08Hr/9PqePTWtHOkDhhu4MJ67KM=;
        b=C2qM//Z6wb4vQeVepPZCxHXvN4rF+qC/jue106sUKn/mvKq7X8gUw6SN/p+a2w3wat
         La5oQCCwWPBmsigyGMpgaMOUvGJf+Ki1ecoHlX1g8duuYc2XKRcLegIHYat6xOz/9LSW
         9OA2lEdGVxdEkm6pBfBdGTMWxIfZ3QtprpB2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ggeUcJLIhIFneem6QjGGAuA6tQtqbkzbVKDhzQ2u9QO2h0GoJot6z9pIopl1ujZplJ
         F6ZFagB+BX+ifYF6y8l5bk59yJYz0yXNGek5Dj8rRvB0RdLDLjAUUEw3qTTOM2GXvK6x
         v24f9BdE9JM8ZfQ3PPSLrSagdWEbrwmuViWr4=
Received: by 10.187.210.3 with SMTP id m3mr2158735faq.59.1227977325798;
        Sat, 29 Nov 2008 08:48:45 -0800 (PST)
Received: by 10.187.193.13 with HTTP; Sat, 29 Nov 2008 08:48:45 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101918>

conflict: this strategy would always resolve in a merge conflict
allowing you to use git mergetool to piece the files back together.

no-overwrite: if a change from the branch being merged in would
overwrite something in the current branch don't merge it. (I think it
needs a better name)


-- 
Caleb Cushing
