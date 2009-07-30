From: Josh ben Jore <jbenjore@whitepages.com>
Subject: Merge-base algorithm?
Date: Wed, 29 Jul 2009 21:16:30 -0700
Message-ID: <D5F958F92101F74D8A5683C2FE14F4200F231037@post.corp.w3data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 06:16:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWN4J-00037m-7m
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 06:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbZG3EQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 00:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbZG3EQZ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 00:16:25 -0400
Received: from mail0.w3data.com ([38.112.225.178]:15287 "EHLO
	hub.corp.w3data.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750858AbZG3EQZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jul 2009 00:16:25 -0400
Received: from post.corp.w3data.com ([172.18.0.206]) by hub ([172.25.0.29])
 with mapi; Wed, 29 Jul 2009 21:16:31 -0700
Thread-Topic: Merge-base algorithm?
Thread-Index: AcoQzIQSjevrlqlLToKhEgVwQ+ZTkA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124441>

What is the merge-base algorithm for selecting nodes? How can I subsume nodes in the selected list?

I want to change the result of my current merge-base command. Right now it includes nodes "A", "B", and "C" and I am experiencing a segmentation fault when merging "A" and "B." I want to add a commit to the tree which subsumes nodes "A" and "B" so that my merge-base is against "new node(A+B)" and "C" or something similar.

I am attempting to work around the bug described in the thread "Null deref in recursive merge in df73af5f667a479764d2b2195cb0cb60b0b89e3d."

Regards,
Josh
