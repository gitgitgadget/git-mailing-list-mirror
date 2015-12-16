From: "Harfoot A.J." <A.J.P.Harfoot@soton.ac.uk>
Subject: No auto CRLF conversion in Commit Message comments
Date: Wed, 16 Dec 2015 15:13:41 +0000
Message-ID: <FBEAE9E9FAB4174499E31C0F26B4BACD2DED2E66@SRV00048.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 16 16:20:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9DsK-0003J4-SF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 16:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965710AbbLPPUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 10:20:08 -0500
Received: from mailgate6.iss.soton.ac.uk ([152.78.128.11]:37108 "EHLO
	mailgate6.iss.soton.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857AbbLPPUF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 10:20:05 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2015 10:20:04 EST
Received: from mailgate6.iss.soton.ac.uk (localhost.localdomain [127.0.0.1])
	by mailgate6.iss.soton.ac.uk (8.13.8/8.13.4) with ESMTP id tBGFDgWk030673
	for <git@vger.kernel.org>; Wed, 16 Dec 2015 15:13:42 GMT
Received: from UOS-MSG00036-VS.soton.ac.uk (uos-msg00036-vs.soton.ac.uk [152.78.119.50])
	by mailgate6.iss.soton.ac.uk (mailgate6.iss.soton.ac.uk [152.78.128.11]) envelope-from <A.J.P.Harfoot@soton.ac.uk> with ESMTP
	id rBFFDg2311065439kf ret-id none; Wed, 16 Dec 2015 15:13:42 +0000
Received: from SRV00048.soton.ac.uk ([169.254.11.163]) by
 UOS-MSG00036-VS.soton.ac.uk ([152.78.119.50]) with mapi id 14.03.0248.002;
 Wed, 16 Dec 2015 15:13:41 +0000
Thread-Topic: No auto CRLF conversion in Commit Message comments
Thread-Index: AQHROBRYkYrXtaH3HUq0zzehPcZICw==
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.9.181.111]
X-smtpf-Report: sid=rBFFDb231106543900; tid=rBFFDg2311065439kf; client=relay,white,ipv6; mail=; rcpt=; nrcpt=1:0; fails=0
Received-SPF: None; receiver=mailgate6.iss.soton.ac.uk; client-ip=152.78.119.50; helo=<UOS-MSG00036-VS.soton.ac.uk>
Received-SPF: None; receiver=mailgate6.iss.soton.ac.uk; client-ip=152.78.119.50; envelope-from=<A.J.P.Harfoot@soton.ac.uk>
X-UOS-MailScanner-Information: Please contact Serviceline@soton.ac.uk for more information
X-UOS-MailScanner-ID: tBGFDgWk030673
X-UOS-MailScanner: Found to be clean
X-UOS-MailScanner-From: a.j.p.harfoot@soton.ac.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282561>

Hi there,

I'm new to Git, so apologies if this is already available, but after some searching and experimenting I haven't been able to resolve it.

I am running Git 2.6.4.windows.1 on Windows 7 64 bit.

I have the global configuration variable core.autocrlf=true

When I commit, the commit message template file is loaded into my configured text editor (in this case Windows Notepad), however the comment lines are terminated with LF, not CRLF, and so are not displayed as new lines by Notepad.
In the opposite direction, the output of 'git log' redirected to a file has all EOL characters set to LF, when originally entered as CRLF, so automatic conversion is working

I have tried to generate a custom commit message using the commit.template variable, but the commented lines are appended to this file, creating a mixture of EOL characters!

Is there a way to fix this inconsistency?

Cheers,

Andy

-- 

Andy Harfoot

GeoData Institute
University of Southampton
Southampton
SO17 1BJ

Tel:  +44 (0)23 8059 2719
Fax:  +44 (0)23 8059 2849

www.geodata.soton.ac.uk