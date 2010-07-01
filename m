From: Ryan McCue <me@ryanmccue.info>
Subject: Forcing CRLF for files in a directory
Date: Thu, 01 Jul 2010 22:12:52 +1000
Message-ID: <4C2C8644.4060208@ryanmccue.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 14:13:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUIdi-0000Iz-4A
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 14:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0GAMNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 08:13:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:56373 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597Ab0GAMNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 08:13:01 -0400
Received: by pxi14 with SMTP id 14so322428pxi.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 05:13:00 -0700 (PDT)
Received: by 10.142.67.30 with SMTP id p30mr12714559wfa.154.1277986380540;
        Thu, 01 Jul 2010 05:13:00 -0700 (PDT)
Received: from Ryan-McCues-MacBook.local ([123.208.138.57])
        by mx.google.com with ESMTPS id g37sm3880904rvb.5.2010.07.01.05.12.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 05:13:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150032>

Hi there,

I'm working on a project at the moment which stores raw HTTP header data 
along with bodies for use during testing. As each header line must be 
separated by a CRLF, these need to remain so in the repository.

My question is: Do I need to do anything special to ensure these CRLFs 
aren't converted to LFs during checkout?

Thanks,
Ryan.
