From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Sourceforge doesn't like git cvsimport
Date: Wed, 16 Nov 2005 10:01:58 -0800
Message-ID: <437B7416.8030704@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 19:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcRbt-0005QE-NR
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 19:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVKPSCI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 13:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVKPSCI
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 13:02:08 -0500
Received: from terminus.zytor.com ([192.83.249.54]:37510 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030299AbVKPSCG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 13:02:06 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAGI2211004200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Nov 2005 10:02:02 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12034>

		die "Socket to $serv: $!\n" unless defined $s;
		$s->write("BEGIN AUTH REQUEST\n$repo\n$user\n$pass\nEND AUTH REQUEST\n")
			or die "Write to $serv: $!\n";
		$s->flush();

		my $rep = <$s>;

		if($rep ne "I LOVE YOU\n") {
			$rep="<unknown>" unless $rep;
			die "AuthReply: $rep\n";
		}

-------

: tazenda 23 ; telnet cvs.sourceforge.net 2401
Trying 66.35.250.207...
Connected to cvs.sourceforge.net.
Escape character is '^]'.
BEGIN AUTH REQUEST
/cvsroot/bochs
anonymous

END AUTH REQUEST
cvs [pserver aborted]: descramble: unknown scrambling method
Connection closed by foreign host.
