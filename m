From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsserver: Use Merged response instead of Update-existing for merged files
Date: Mon, 12 Mar 2007 11:21:37 +1300
Message-ID: <46a038f90703111521h59079864q9c9f5d922c92dc99@mail.gmail.com>
References: <11731741443228-git-send-email-frank@lichtenheld.de>
	 <7v4pot281h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org,
	"Andy Parkins" <andyparkins@gmail.com>,
	"Frank Lichtenheld" <frank@lichtenheld.de>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 23:21:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQWQK-0005Zw-ML
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 23:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933569AbXCKWVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 18:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933582AbXCKWVk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 18:21:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:56582 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933569AbXCKWVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 18:21:39 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1780679nfa
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 15:21:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TWpB2Ie31Qb8Ngy1rlCLbS7eZupyu/nA3cTkL89In8Gi+COjgKXnQF6zJdYbeaUEvFkrhpiFyZNUDnxoT0IYngAKhyi3eNMXdIQ5bBhNt8C28yRBYQJE0Si201RH5/VH+t/vjV3e60e7zfSaAtzzyo3056Z9Sf5KqKuZ2JBCfIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nLINxuDNjYxun8c91t1A/r1SpeFCoTdGWXnj2rp1UWkd/Q6/K7+nw0uhvXHl+ao4sY3uhsM3wrVl21kQN0jOt2aokeDW3aCgKAKObXzBiI7sDrIaWtXla2tm2X5S2JTPmumO291TdnQmeSTHPZGFQ02pTKx6U8cpdPBkq3QGWqg=
Received: by 10.82.135.13 with SMTP id i13mr7236892bud.1173651697632;
        Sun, 11 Mar 2007 15:21:37 -0700 (PDT)
Received: by 10.82.183.14 with HTTP; Sun, 11 Mar 2007 15:21:37 -0700 (PDT)
In-Reply-To: <7v4pot281h.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41998>

On 3/10/07, Junio C Hamano <junkio@cox.net> wrote:
> Frank Lichtenheld <frank@lichtenheld.de> writes:
>
> > Using Update-existing leads to the client forgetting about the "locally
> > modified" status of the file which can lead to loss of local changes on
> > later updates.
>
> To me, both of these hunks look correct (the first one is clean
> merge, the second one is merge with conflicts).  Ack?

Ack!



m
