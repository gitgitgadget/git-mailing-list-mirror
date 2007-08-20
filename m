From: Robert Boone <robert@rlb3.com>
Subject: Centralized processes in git
Date: Mon, 20 Aug 2007 13:30:47 -0500
Message-ID: <31FEEAE6-58A6-4A74-9DB7-E6F9D56D1C48@rlb3.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 20:31:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INC1j-0003e9-8S
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 20:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbXHTSax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 14:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbXHTSax
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 14:30:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:32324 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbXHTSaw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 14:30:52 -0400
Received: by nz-out-0506.google.com with SMTP id s18so494372nze
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 11:30:51 -0700 (PDT)
Received: by 10.142.154.20 with SMTP id b20mr600338wfe.1187634650764;
        Mon, 20 Aug 2007 11:30:50 -0700 (PDT)
Received: from ?192.168.90.77? ( [198.66.78.2])
        by mx.google.com with ESMTPS id 3sm7312489wrh.2007.08.20.11.30.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2007 11:30:49 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56235>

Hello,
     My company is looking at git to replace subversion as our scm.  
We have a small team of developers which need to publish to a  
centralized repository. One thing we would like is to have an  
automated bug fix merge ability. So if I make a bug fix to master we  
want that fix to be merged into other branches that we set. If there  
is a conflict we want that person  to be notified by email or some  
other way. I would like to know if anyone on the list has a good way  
to implement this?
