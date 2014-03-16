From: Dragos Foianu <dragos.foianu@gmail.com>
Subject: [GSoC 2014] git config API improvements
Date: Mon, 17 Mar 2014 00:27:58 +0200
Message-ID: <1395008878-18677-1-git-send-email-dragos.foianu@gmail.com>
Cc: Dragos Foianu <dragos.foianu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 23:28:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPJXt-0004IX-Rd
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 23:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbaCPW2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 18:28:13 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:57644 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbaCPW2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 18:28:12 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so3444932eek.37
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=u4woUJ4shQXVLzm8M3xNgw70VcNa0cQLdDJSaF/x3+U=;
        b=ehcCtgJzMinznOLttZWPlHeG8m6N1ZGYZHnjioW46W9Z9FwcdbsjM2ik6G09EMorWW
         6f89RQfSmfDIYSXR7IHluDy1fgvwbgZqspFZqseNMeeVNKtzD6fIk8FaldvlOsHuWv0R
         RmOt/fmXRWsW6T1W8J4orOd2UAPLNI/fK3W0VWqcgdhGnuSPcNwWmUapXnTJnDKgo2CH
         ZKxJkJAox9QTNc4B3c/RvtVzHAqIaK9D3oeXx9goCOmMRQeUdHE4A+DS4QRSqivDM9d4
         gUW8zuBljEJe09xNLJwto9GiywHIHgCiHK1wqtEQ5prg+OLev0THsFDXv9AgNUosYMHk
         XH3g==
X-Received: by 10.14.10.73 with SMTP id 49mr20609671eeu.52.1395008891329;
        Sun, 16 Mar 2014 15:28:11 -0700 (PDT)
Received: from localhost.localdomain ([109.100.93.176])
        by mx.google.com with ESMTPSA id m42sm35150199eex.21.2014.03.16.15.28.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Mar 2014 15:28:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244212>

Hello,

My name is Dragos Foianu and I am an undergraduate student at University Politehnica of Bucharest in Romania. This is my final year and I'm planning on doing something more exciting than the simple 
assignments I get from the university.

I have been working with git for quite some time now and I'm currently using it for my diploma project. It was annoying at first but now I love it and it has helped me many times in the past. I wanted to 
contribute to the project and I feel that GSoC 2014 is the perfect opportunity for this.

I am primarily interested in the "git config API improvements" project. I have glanced over the code in order to get an idea of how git-config currently works. The project idea page gives a very good 
description of what is desired. Caching and retrieving values by name sounds to me like a hint to use a hashtable-like data structure. Conveniently, there is already a hashmap implementation in git and 
even more conveniently, there is a cache implementation that uses that data structure. So that part is fairly straightforward.

I have a question, however: how would I go about detecting when a cache invalidation is necessary? Considering I have read a configuration file and cached the configuration in memory, what can trigger 
one of the existing cache entries to be invalidated?

That is all I have to ask for now. I will look over the code during the next few days to get the bigger picture and submit my application. At [1] you can find my microproject patch. I am eagerly awaiting 
for any questions you might have.

All the best,
Dragos

[1] http://thread.gmane.org/gmane.comp.version-control.git/244210
