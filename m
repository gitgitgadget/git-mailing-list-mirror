From: Ittay Dror <ittay.dror@gmail.com>
Subject: connecting existing local git repository to svn
Date: Tue, 27 Jan 2009 06:10:15 +0200
Message-ID: <497E8927.1060506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 05:12:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRfJe-0002gB-EZ
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 05:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbZA0ELV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 23:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbZA0ELV
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 23:11:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:62006 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZA0ELU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 23:11:20 -0500
Received: by ug-out-1314.google.com with SMTP id 39so190720ugf.37
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 20:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=kACb38AeQR2zb++Yh5vu5D9qkK1XtgvV806AzglHkic=;
        b=iIxqQRRoglQBqbO2oz3i96KCx/JEk/9rSWLA+v5FzLSB7so73p4Tk3w7KVPxCNXWBu
         6pW70tHacYSG7iWmlOc11c7bc+JdnKT93AwAduL6UDCj5SKLpNTSv2SHSb1GnK8HHL3C
         ZWGioOHnm8NLob7K6FPQ9bpy+P7WTGmMWjO50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=MQT4Py3LV8F4ATAXE8Nu6kHFk6dc6S1tAk9G7Cy775opuOUIxvXx03AYRhKZvywU3T
         VtxBv1Zdctgq7LX5gSBLwgsupVNjJsAz+fjbS9YzKk2kTehhzO9GWbhIoAHYapR2dtr3
         d0ENcVYLhvCSKUzmLGAI/omkfxcWUoGL2YYb8=
Received: by 10.66.217.18 with SMTP id p18mr1597713ugg.60.1233029478630;
        Mon, 26 Jan 2009 20:11:18 -0800 (PST)
Received: from ?10.10.2.8? ([212.143.191.180])
        by mx.google.com with ESMTPS id j4sm5435998ugf.16.2009.01.26.20.11.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 20:11:17 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107304>

Hi,


I'd like to create a branch in a subversion repository so that I can
work with git-svn on it.


My git repository is already with a history, that I don't want to
replicate to subversion, I want to start with subversion having just the
latest revision and then continue from there normally (git svn
dcommit/rebase).


How can I do that?


Thanks,

Ittay
