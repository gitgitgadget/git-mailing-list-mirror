From: Martin Pirker <Martin.Pirker@iaik.tugraz.at>
Subject: git-describe hash length
Date: Thu, 22 Jan 2009 12:26:06 +0100
Message-ID: <497857CE.3060101@iaik.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 13:27:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPyem-0004Nl-6y
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 13:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbZAVM0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 07:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754244AbZAVM0J
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 07:26:09 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:3147 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbZAVM0I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 07:26:08 -0500
X-Greylist: delayed 3538 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2009 07:26:08 EST
Received: from thor.iaik.tugraz.at (mail1.iaik.tugraz.at [129.27.152.30])
	by mailrelay2.tugraz.at (8.14.3/8.14.3) with ESMTP id n0MBR3Zk005229
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 12:27:03 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.7.2 mailrelay2.tugraz.at n0MBR3Zk005229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tugraz.at;
	s=mailrelay; t=1232623624; bh=Yhq80oNCeQk02QIBiJy3drC0IbLMOlQWaKcTB
	J3wx7k=; h=Message-ID:Date:From:MIME-Version:To:Subject:
	 Content-Type:Content-Transfer-Encoding; b=maSr3oiR1JwCqRKn0bxbCzTl
	CfMqtrDgAvYut0UOxKAWDZknX459D4cpHby5QF5pjdM5S1w8i6FEQQFa29UTBHhlrw8
	qdrBpSRTYAGw5xKC0B35pZnTsuL38IBnS59X1e2bbFkWG4pJxj99E61/OQEmz+ENZEI
	y7VEQkunT2D+4=
Received: from localhost (localhost [127.0.0.1])
	by thor.iaik.tugraz.at (Postfix) with ESMTP id 9040E1067B3C7
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 12:27:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at iaik.tugraz.at
Received: from thor.iaik.tugraz.at ([127.0.0.1])
	by localhost (thor.iaik.tugraz.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pv16KEZdw2Qt for <git@vger.kernel.org>;
	Thu, 22 Jan 2009 12:27:03 +0100 (CET)
Received: from [129.27.152.74] (mannus.iaik.tugraz.at [129.27.152.74])
	by thor.iaik.tugraz.at (Postfix) with ESMTP
	for <git@vger.kernel.org>; Thu, 22 Jan 2009 12:27:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
X-TUG-Backscatter-control: hn0LrPnJ+/fhju8CMzmpjQ
X-Spam-Scanner: SpamAssassin 3.002005 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.65 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106745>

Hi!


john@doe:/workspace$ git version
git version 1.6.1
john@doe:/workspace$ git describe
fatal: cannot describe '7aee61cc635a923e70b74091486742481ee0928b'
john@doe:/workspace$ git describe --always
7aee61c
john@doe:/workspace$ git describe --always --abbrev=8
7aee61cc


man git-describe:

  --abbrev=<n>
      Instead of using the default 8 hexadecimal digits as the
      abbreviated object name, use <n> digits.



There is one character missing from default or what am I missing?

Thanks,
Martin
