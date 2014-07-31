From: "Philip Oakley" <philipoakley@iee.org>
Subject: article: Using a rolling hash to break up binary files
Date: Thu, 31 Jul 2014 23:31:52 +0100
Organization: OPDS
Message-ID: <D7F507613B1F45379A43C1BCF2F088B0@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 00:31:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCytB-00083d-SS
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 00:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbaGaWby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 18:31:54 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:59192 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751759AbaGaWbx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2014 18:31:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ap1xAPzC2lMCYJVuPGdsb2JhbABbgwwBAVERHhIXiDKrJJk2EYc/BAEBAgENgQAXBQEBAQE4NoN+FAEBLh4BASwCCAIBJDkBBBoGBwMaGwIBAgMBiDUJo3mHJI8GkHqQAYMBgRwFikuHBKBAggU8
X-IPAS-Result: Ap1xAPzC2lMCYJVuPGdsb2JhbABbgwwBAVERHhIXiDKrJJk2EYc/BAEBAgENgQAXBQEBAQE4NoN+FAEBLh4BASwCCAIBJDkBBBoGBwMaGwIBAgMBiDUJo3mHJI8GkHqQAYMBgRwFikuHBKBAggU8
X-Header: TalkTalk
X-IronPort-AV: E=Sophos;i="5.01,775,1400022000"; 
   d="scan'208";a="642351399"
Received: from host-2-96-149-110.as13285.net (HELO PhilipOakley) ([2.96.149.110])
  by out1.ip06ir2.opaltelecom.net with SMTP; 31 Jul 2014 23:31:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254616>

I thought it worth bring to the list's attention a  recent article on 
CodeProject that may be of interest to those looking at splitting binary 
files into deterministic hunks.

http://www.codeproject.com/Articles/801608/Using-a-rolling-hash-to-break-up-binary-files

It's based on Rabin and Karp's algorithm 
http://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm.

--
Philip 
