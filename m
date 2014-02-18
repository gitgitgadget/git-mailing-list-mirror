From: Semyon Perepelitsa <semaperepelitsa@gmail.com>
Subject: Re: [PATCH v2 3/3] push: Add the --no-recurse-submodules option
Date: Wed, 19 Feb 2014 01:49:25 +0800
Message-ID: <A67F2B72-5398-4035-B79B-0568CA4BB0B4@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 18:49:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFonZ-0004Wc-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 18:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbaBRRtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 12:49:33 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:43724 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbaBRRtc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 12:49:32 -0500
Received: by mail-lb0-f182.google.com with SMTP id w7so12793165lbi.27
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 09:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=zMGbXyGDX+hu7qZa7SxYlCROXDMP+D8LvEDQ5gCqFzk=;
        b=hR1HHHm7xJPtCju35jCQ/fOhhgc3jf0qYTlhKZollp97nRwpj/UAUdLfvewMpKwhBl
         PoodV32ynPWJBlTYJ/5650IhHnUSoU+B8Kg65DNpvpsLReJglOBmPSSsDm9BvepCfn2c
         fp4Z08aQ0Zq13T+3But6HGzTYdouXyT9EvA2Zwve5ha4L/65qOr4ZJX9lxp89DYSOSqM
         oYLRz/mfcN5m9t3WKmZd1c4ngcUPfqOOp1iaZvj70ldMuqdG1suL1LH4POyFsSaN0qZ8
         /ewtQ6B+PXN1e5yNNgzt9D3QGYkEvsLFQy1kjG1vctAbrLHAtEjpIVFCpKjs/DkTHR1+
         LgNA==
X-Received: by 10.112.169.8 with SMTP id aa8mr7585lbc.72.1392745770893;
        Tue, 18 Feb 2014 09:49:30 -0800 (PST)
Received: from [10.0.1.4] (dnm.57.120.188.95.dsl.krasnet.ru. [95.188.120.57])
        by mx.google.com with ESMTPSA id mo3sm24396720lbb.17.2014.02.18.09.49.28
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 09:49:29 -0800 (PST)
X-Mailer: Apple Mail (2.1827)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242333>

I noticed the option in the man-page but there is still no configuration option available. Did you forget to add it after all? Right now --recurse-submodules has little use by itself as the problem it solves is forgetting to push a submodule which is no different from forgetting to specify the option.