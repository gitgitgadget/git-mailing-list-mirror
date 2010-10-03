From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 00/16] Add missing &&'s in the testsuite
Date: Sun, 3 Oct 2010 16:09:13 -0500
Message-ID: <20101003210913.GD22743@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:12:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2VrR-0000rH-C9
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755088Ab0JCVMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 17:12:35 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:57562 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754723Ab0JCVMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 17:12:34 -0400
Received: by qyk36 with SMTP id 36so2184108qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1US9Z+udgMmA59S/Rm2ZV27EJS78RTPyNYyACsGAy/0=;
        b=ZI+ZiGk3Ab8CpjZg7QNg08T88edOpai0j4xmJp1a2qmyjuLOuP8w7Z1QE5m3f2GfTG
         yGaoWdoFMnAX4QwJ8xacXwBU5dTr88Swb4BKNr5bGQjITIH3WwQs3BmnM8Dckm3me1uk
         K9Z3YRQ2MLsOAibWPM8w02iPFd2bf3Q9hc9/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Cj9RFCzEh90DFr2dpTFmtX0rnGZRXTPThIs0U+17BRrtMYe3YjcwRlQd/HvUVaDXZK
         gErhjTXWMimb6fHyUnhMluxceiOj0cZv1pQlYIYQQrOAKuf9yFNvtpTKDJc7FrCkekTT
         oldB+KXQOJEUmlejoHkKabWsNhbdmi12rr+v4=
Received: by 10.229.231.3 with SMTP id jo3mr6345085qcb.21.1286140347332;
        Sun, 03 Oct 2010 14:12:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id e6sm4485412qcr.5.2010.10.03.14.12.25
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 14:12:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157924>

Elijah Newren wrote:

> This patch series fixes many of the missing &&s in the testsuite.
[...]
>  100 files changed, 429 insertions(+), 418 deletions(-)

Thanks for your persistence, and sorry to nitpick so.

With the exception of patches 7 and 15 as already mentioned, this
looks ready to me.
