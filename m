From: Martin Gregory <marting@adelaideinterim.com.au>
Subject: sparse checkout file with windows line endings doesn't work
Date: Mon, 16 Sep 2013 22:50:28 +0930
Organization: AI
Message-ID: <SDZQSFBTWig9IERCPVQvNjIyNDgyMzQ@IBMLT4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 17 00:26:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLhFL-0003cY-FC
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 00:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab3IPW0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 18:26:15 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33869 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330Ab3IPW0O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 18:26:14 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so5933384pab.35
        for <git@vger.kernel.org>; Mon, 16 Sep 2013 15:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:subject:to:message-id:mime-version
         :organization:content-type:content-transfer-encoding;
        bh=Fj7zgppjYiX8BuWurO/WR3DlDVgIhCd7bScYOJYHn4g=;
        b=hX9NsPPGgB8e5p1Ir2VSg4tDZd2OOdSROTJ0nZ76xWfj2jHuIfzuW6YczQ2uQESpq8
         EodkN3RDa+3cAd+u2a7PlIESdq/QsTS/Qa6+wNfoNWEGumhAQwKMlzwFLT+x6mS4PH83
         tQyqEesK5bL/AcPhul5k5YO0c9t943Lguzh2SqKdNjRs6Sv7xEporsoJo60hqxafqqCX
         qFT51YUp8F9q1wGakp49zxyQQ/zyaUgdk02D8w9eL4ps3eIQLvg83IdrySpyrx0pRHDh
         b4ly0Mo2HCaHB+KbbnYPwN8BHXaG/2Ot7gFhKngTb3qc8Ma42O9xUOs754NQsy1UGuRJ
         qzMw==
X-Gm-Message-State: ALoCoQnkRP/IClVzZ/C0vDMXRYsLoKl/XBzWdScaD9yHpdU/O/aqazpwqbRzqdT9Ocs9nD0etf0P
X-Received: by 10.68.132.71 with SMTP id os7mr61217pbb.188.1379370373979;
        Mon, 16 Sep 2013 15:26:13 -0700 (PDT)
Received: from IBMLT4 (ppp14-2-54-108.lns21.adl2.internode.on.net. [14.2.54.108])
        by mx.google.com with ESMTPSA id py4sm33565089pbb.33.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 16 Sep 2013 15:26:13 -0700 (PDT)
X-Mailer: GoldMine [9.2.1.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234848>

Hi,

Please see  http://pastebin.com/zMXvvXuy

It shows that if the .git/info/sparsecheckout file is in windows format
(windows line ending) then it doesn't work.

Thanks for any advice.

This is git 1.8.3.msysgit.0

Martin
