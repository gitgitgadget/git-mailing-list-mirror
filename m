X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ian Molton <spyro@f2s.com>
Subject: trouble with git cvsimport
Date: Mon, 11 Dec 2006 23:28:00 +0000
Organization: The Dragon Roost
Message-ID: <457DE980.50605@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 23:28:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 2.0a1 (X11/20061107)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34049>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtuZ7-0002aR-39 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 00:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750727AbWLKX2F (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 18:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWLKX2F
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 18:28:05 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:49082 "EHLO
 outmail.freedom2surf.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1750727AbWLKX2D (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 18:28:03 -0500
Received: from [192.168.1.2] (i-83-67-116-184.freedom2surf.net
 [83.67.116.184]) by outmail.freedom2surf.net (Postfix) with ESMTP id
 3CA0F50EFC for <git@vger.kernel.org>; Mon, 11 Dec 2006 23:28:01 +0000 (GMT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi.

I imported a CVS repo with git cvsimport, which went well enough, 
however subsequent repeats of the same command arent updating the git 
repo. whats up?

command Im using is:

git-cvsimport -d:local:/home/ian/projects/hh.org_cvs/cvs/ -k -m -p x -o 
