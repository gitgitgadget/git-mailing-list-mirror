From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: git cvsimport: new tags not imported on second cvsimport
Date: Sat, 4 Aug 2012 17:01:49 +0400
Message-ID: <9510482012.20120804170149@gmail.com>
References: <1123570348.20120804133108@gmail.com> <m2lihvt2gi.fsf@linux-m68k.org>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 15:01:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxdym-00044D-Og
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 15:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379Ab2HDNA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 09:00:59 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48195 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752142Ab2HDNA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2012 09:00:58 -0400
Received: by lagy9 with SMTP id y9so6505lag.19
        for <git@vger.kernel.org>; Sat, 04 Aug 2012 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:cc:subject
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=BpoohIvYyHLcEef0KjtPdMzf602SHLkgapaMugrXz0s=;
        b=tQTlLbuOoeVV6AuLJOF9wQ43WhWP2S5hGoffZM5XIoVeYw7+5hMnXTLKTTpEIDCZi2
         OxGYncz4R4SqhmciEjYbZkQN5Bao6L6XyZzRrZSCcfrJAaOGv8MG88qldbhOWq8rQP7s
         zaRzmllmTXGN5Wlw94/xhvtLalo4MF4Ozk6W0kV70nXQry1pYqiAcN14RjKoOSVhWiWd
         DQKQFAEBOiELWMIUpN8H9RXBcwZe7jLZsq8yA5nnHNqzMJ4vA1VlSPJsG9iqaqhhF87w
         OmILZq1VmS731+fxopCa0v+oFjulGQihMQr8rrXOMsG2iforCe5/2pmhvbXa2aeD9WdM
         6aJQ==
Received: by 10.152.132.233 with SMTP id ox9mr4714287lab.25.1344085256608;
        Sat, 04 Aug 2012 06:00:56 -0700 (PDT)
Received: from MAR2.localnet (ppp91-122-22-19.pppoe.avangarddsl.ru. [91.122.22.19])
        by mx.google.com with ESMTPS id sn2sm4878177lab.16.2012.08.04.06.00.54
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Aug 2012 06:00:55 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <m2lihvt2gi.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202877>

AS> Ilya Basin <basinilya@gmail.com> writes:

>> I made the initial import:
>>     git cvsimport -d :pserver:user@blackbird:10010/data/cvs/webgui -C SAP -r cvs -k SAP
>>
>> edited .git/config:
>>     [cvsimport]
>>             module = SAP
>>             r = cvs
>>             d = :pserver:user@blackbird:10010/data/cvs/webgui
>>
>> did some commits to CVS and created a new tag
>>
>> Then ran:
>>     git cvsimport -ak
>> To synchronize with CVS.
>>
>> The new commits were imported, but the new tag wasn't.

AS> cvsimport never reconsiders changesets that were already imported, so if
AS> the tag was added to such a changeset it won't be seen.

AS> Andreas.


Do you mean, if I tag BEFORE cvsimport, it will be imported?
How to make the git repo "forget" the last cvsimport?

-- 
