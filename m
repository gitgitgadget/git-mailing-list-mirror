From: =?UTF-8?Q?Albin_Otterh=c3=a4ll?= <gmane@otterhall.com>
Subject: 'git mv' doesn't move submodule if it's in a subdirectory
Date: Fri, 15 Apr 2016 10:14:11 +0200
Message-ID: <5710A2D3.8090003@otterhall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 10:21:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqz07-0000uL-MW
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 10:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbcDOIVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2016 04:21:03 -0400
Received: from db1.countermail.com ([46.253.205.114]:33284 "EHLO
	db1.countermail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbcDOIVA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2016 04:21:00 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Apr 2016 04:20:59 EDT
Received: from 192.168.0.1 [46.253.205.116])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by db1.countermail.com (Postfix) with ESMTPSA id 8812882A010D
	for <git@vger.kernel.org>; Fri, 15 Apr 2016 08:14:21 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291599>

I've a submodule located in a subdirectory
({git_rep}/home/{directory}/{submodule}), and I wanted to move the whol=
e
directory up a level ({git_rep}/{directory}/{submodule}). But when I
used 'git mv {directory} ../' the '.gitmodule' file didn't get modified=
=2E

Best regards,
Albin Otterh=C3=A4ll
