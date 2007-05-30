From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 21:28:33 +0200
Organization: Dewire
Message-ID: <200705302128.34111.robin.rosenberg.lists@dewire.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com> <200705302028.15549.robin.rosenberg.lists@dewire.com> <fcaeb9bf0705301208p6ce00315uc3cde4d43903ec0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Paolo Teti" <paolo.teti@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Lederhofer" <matled@gmx.net>,
	"Junio C Hamano" <junkio@cox.net>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 21:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtTq8-0007n9-Jq
	for gcvg-git@gmane.org; Wed, 30 May 2007 21:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbXE3T2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 15:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754144AbXE3T2I
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 15:28:08 -0400
Received: from [83.140.172.130] ([83.140.172.130]:20927 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753731AbXE3T2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 15:28:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 25694802814;
	Wed, 30 May 2007 21:21:41 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23564-05; Wed, 30 May 2007 21:21:40 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CB9A68027EF;
	Wed, 30 May 2007 21:21:40 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <fcaeb9bf0705301208p6ce00315uc3cde4d43903ec0c@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48783>

onsdag 30 maj 2007 skrev Nguyen Thai Ngoc Duy:
> Clearcase symlinks require checkout/checkin stuffs that I really don't
> want to mess up with. Moreover, it seems not work if the link
> destination is out of clearcase view (which is what I wanted).

Well obviously.. :/

I guess junction points in dynamic views are out of the question too. Would
setting GIT_DIR be too cumbersome?

-- robin
