From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: git fetch: where are the downloaded objects stored?
Date: Mon, 3 Mar 2008 13:40:50 +0100
Message-ID: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 13:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW9yz-0004NG-F3
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 13:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbYCCMky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 07:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755023AbYCCMkx
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 07:40:53 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:39300 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986AbYCCMkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 07:40:53 -0500
Received: by wf-out-1314.google.com with SMTP id 28so6879414wff.4
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ec/2XInGgQQiXkUAK2A4Iwl590Wz+h8bwzBnrtse5KU=;
        b=WiR4JzBwUn6hDPP4CpkM4jnc7nVAz5njdiE4mLpBIT5ScvCvIV9adRJQDUG8kAlJAq0nnsOGZdhnhuOstEDtN5Fdyhpydl4geFSROuFMjvC6KM84lNDHtWAWAjfe7jZDNY/ephQ13uNMeqp6jXyrZkdOXyFSAWXbFyDjMzdsvQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jNohd5oJiQaA3oTDs1Sgl40ydU9m0F2zm47rImvOh1Rr20KsAX/19fTtllSZh6iiWVGT0LOteIuWzfDwsH7KB1S9gnSipOF24pbsLoYl8DrbKdRKPpztOfR/O2dv7At+mE3DRlxTvqgpiGsRVnd+84na8TugNrXn/L3bke7wvsY=
Received: by 10.142.89.9 with SMTP id m9mr8984846wfb.116.1204548050718;
        Mon, 03 Mar 2008 04:40:50 -0800 (PST)
Received: by 10.143.196.10 with HTTP; Mon, 3 Mar 2008 04:40:50 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75923>

Hi all,
I'm thinking about writing some documentation including diagrams about
the common git operation like pull, fetch, merge and so on in order
to give a "visual" learning procedure about:
- local and remote branches
- index
- checkout dir
-
