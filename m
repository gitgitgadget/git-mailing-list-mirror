From: Ivan Zorin <ivan.a.zorin@gmail.com>
Subject: how to check remote git repo for updates without pull/fetch
Date: Fri, 19 Dec 2008 19:15:27 +0300
Message-ID: <494BC89F.9070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 17:17:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDi25-000455-6f
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 17:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbYLSQPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 11:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYLSQPi
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 11:15:38 -0500
Received: from ik-out-1112.google.com ([66.249.90.176]:60189 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYLSQPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 11:15:38 -0500
Received: by ik-out-1112.google.com with SMTP id c29so224752ika.5
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 08:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=NmxaYWKtaMv83Vu7XOeYzU2JLu+to7gGCq/EOojCqlY=;
        b=FL4OR/nJt/hatAvioH2VytBGbmXj+Y2DxfLV4He66P1DjXxoEOFCjHdmgsMkBegP9x
         xGvlt0emnGHsqtT2HcHcvZsA9JI7K0AK0v9mVnwja3e5C9tATssTUyYr+UjMGw14mtvq
         caP91MVy69ovx7NqKwNULIKRyUD1jh5/ThkJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=ABnIBfAg+kZ1BBJLTd2BluajBqAyu8J7OUIvDvDNhgs7Ku/yXZDydU/tK+hxCTvK06
         jN2ttI27cnrYohvA5ob9KmquNNDmDNqDH8wNDQdWoIXObm8G9/2wCp3h0Irkm/ml43wS
         SpOQYSVYiFblPd9c1318YezSWKqPoI8usle+U=
Received: by 10.210.66.13 with SMTP id o13mr3923576eba.106.1229703336275;
        Fri, 19 Dec 2008 08:15:36 -0800 (PST)
Received: from ?192.168.128.2? ([89.169.165.188])
        by mx.google.com with ESMTPS id f4sm15938409nfh.28.2008.12.19.08.15.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Dec 2008 08:15:35 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103566>

Hello. I have not very hard question, but I don't know how to better do
it - could you tell me, please, does exist some way to check remote git
repository for updates without downloading any essential files? I
suppose, that such command should just type something like: "already
updated", if current working tree identical to remote repo, and
something like "there is some updates in remote repo", if remote repo
has some new commits and/or branches. Thanks.
