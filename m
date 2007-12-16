From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 19:24:17 +0100
Message-ID: <200712161924.18265.jnareb@gmail.com>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <20071216162637.GA3934@fieldses.org> <200712161916.44715.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio Hamano <junkio@cox.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:24:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3yAU-000576-JY
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 19:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbXLPSY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 13:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbXLPSY1
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 13:24:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:11009 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbXLPSY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 13:24:27 -0500
Received: by fg-out-1718.google.com with SMTP id e21so198235fga.17
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=jhzTDf4eYKGKA5DHdc3aU3bu6MpSp4BD9DYbukkW2+c=;
        b=RiN85oKlAGm+pwB2jqXHjLW4zunRwAYfpcKTox/z1wfhQOqCphF4JrLhdyvZWzB3QxI42UM/wqvnvVlHQ+LN9Pb9oOCoMlnTktOgHJ9vdm8JgCtzBo3wdncFDD1ZF3n9Mt1LBcopO8LKXw6pPgscb9LzSJk/Nqh8xNum7UstGXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bTlVYnpu5N5B0EmB5kUsPd2Lt6zZsZdWFHdlXCQ2tYCM3dWG06gXbxmcbLyb8EnOZRXCGmSZvexNcUNRrT50xEHfkI9aXKy5RfnYqfp2j2Vbm/O8wogtLHQ6Xm7K2qGsSwWdl6AXRxxaSukIMNy2s6bQQascX6/qCkDhUm/PVzE=
Received: by 10.86.71.1 with SMTP id t1mr5535259fga.33.1197829465545;
        Sun, 16 Dec 2007 10:24:25 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.189.199])
        by mx.google.com with ESMTPS id 4sm8286219fge.2007.12.16.10.24.22
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Dec 2007 10:24:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712161916.44715.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68475>

By the way, I have just [a beginning of] an idea: what if we look at 
neighbour lines to try to detect whitespace errors? For example when 
using tabs for indent, spaces for align, I think it is an error if 
spaces sequence after tab begins earlier than tab sequence in neighbour 
line ends.

What do you think about it?
-- 
Jakub Narebski
Poland
