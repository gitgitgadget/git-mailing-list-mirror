From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Disallow '\' in ref names
Date: Fri, 08 May 2009 08:55:50 +0200
Message-ID: <4A03D776.6070309@op5.se>
References: <1241760757-26068-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri May 08 08:56:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2K0R-0002e5-H6
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 08:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbZEHGzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 02:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbZEHGzy
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 02:55:54 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:58775 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbZEHGzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 02:55:53 -0400
Received: by fk-out-0910.google.com with SMTP id 18so662590fkq.5
        for <git@vger.kernel.org>; Thu, 07 May 2009 23:55:52 -0700 (PDT)
Received: by 10.86.93.17 with SMTP id q17mr3295346fgb.75.1241765752503;
        Thu, 07 May 2009 23:55:52 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id e11sm482191fga.1.2009.05.07.23.55.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 23:55:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <1241760757-26068-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118570>

Robin Rosenberg wrote:
> This is asking for trouble since '\' is a directory separator in
> Windows and thus may produce unpredictable results.
> 

NAK. We allow / on unixy systems, and that's the path separator there.
Junio even makes extensive use of it to create per-contributor
namespaces for topic-branches.

Are you guessing this might be a problem in the future, or have you
actually run into it?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
