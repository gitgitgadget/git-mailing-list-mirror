From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: How to create empty CENTRAL  git with master / development
 branch ?
Date: Tue, 03 Apr 2012 15:22:22 +0000
Message-ID: <1333466542-ner-2699@calvin>
References: <20120403162352.67cb165e@shiva.selfip.org>
	<4F7B0F1B.3000304@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>,
	"J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Apr 03 17:22:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF5ZO-0006B4-BV
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 17:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab2DCPWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 11:22:48 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63506 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab2DCPWr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 11:22:47 -0400
Received: by wgbdr13 with SMTP id dr13so3851405wgb.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=gG1KHxuk0AgkKfiR0g0LIU3mBi+FF5blk0+StFDycJc=;
        b=A8J7EeoT+MvKW3g9WtQLoExnS8HhijkjlsSZRh6T7J79TLd9qj3j2tSvrkYnkl81+U
         4fxrCCyTm78bXmmOsowizUKDt9ZYOAbZE5k1NO1Bd1OGnFCHgVnqGHkSMzjIUv8CUqd6
         V3a9lYfJO27As2UhEi5SqW/Mi45o2ml4pWhwdZRFLEDHN/+V6356GloXvHckJ3BkYsxF
         vmpXckgaSVqIcanSGDGuf50nHvO6k9Es0MsMZkupPT4XgoKdjxMoDmp2guVuO+XD0RRu
         Wv0ONNL+/RbWwjZoJhKM/MebWL3r8mwyI5zFSqqtsCqg4ZKdKOrtBu12wfkkB0tjxj4J
         YWjw==
Received: by 10.180.91.168 with SMTP id cf8mr37052561wib.0.1333466566530;
        Tue, 03 Apr 2012 08:22:46 -0700 (PDT)
Received: from calvin.caurea.org (62-2-168-230.static.cablecom.ch. [62.2.168.230])
        by mx.google.com with ESMTPS id j3sm70674494wiw.1.2012.04.03.08.22.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 08:22:44 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id C6241192CD4; Tue,  3 Apr 2012 15:22:22 +0000 (UTC)
In-Reply-To: <4F7B0F1B.3000304@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194629>

On Tue, 03 Apr 2012 16:54:19 +0200, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
> Generally: If you want a central repository, the first one to push to it 
> might do something like this:
> 
> git remote add origin ssh://big.brother.edu/repo.git
> git push origin master
> git config branch.master.remote origin
> git config branch.master.merge refs/heads/master

or simply: git push -u origin master

tom
