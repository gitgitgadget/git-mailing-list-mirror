From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Tue, 23 Mar 2010 12:03:44 +0000
Message-ID: <a5b261831003230503k73f62a88lc5a9b31da3e9d893@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
	 <alpine.DEB.2.00.1003221012290.11364@ds9.cixit.se>
	 <alpine.DEB.1.00.1003221155200.7596@pacific.mpi-cbg.de>
	 <46dff0321003221854t2d95d18dx1a6cdf1174ea2efd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysgit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 13:04:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu2pr-00054X-SY
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 13:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770Ab0CWMDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 08:03:47 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:38167 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab0CWMDq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 08:03:46 -0400
Received: by wwe15 with SMTP id 15so4012125wwe.19
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=rvwIfqydtTMD+PW8QvUA9j/BKvlTutIfFpbWASTtB1E=;
        b=GqztMmvAtvDxpsEA0VPPhdHTnF2TBPxVT6YXr8eNjR4SMwW0yMZpyygqV3ArKU+cHS
         osa+NUAB5p2ivP6OcX6N8eMjCh/NQtc6WIXQzCLiNkgjJCbTcG0DfPkruie0tToXpnY0
         C3bGeR3l5Sksz9Utq4K57m0exNGj2fB+SbN+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RTkyJOkz7d4QdTaAAMlX+6vQbTfE9U162RuWBvabCV7ltjIWEgKgTFAeXa8U9w5UuH
         45I/oGBL6egicPdhJGriR89n1vLyclL8GTlSWvucHpCuxuT1ObwpSLEz/nNNrRaMgdiI
         h7MjvPERP+ojaZbJhIH2N0TQ2IGNxE5oFoAn4=
Received: by 10.216.90.17 with SMTP id d17mr2210908wef.175.1269345825040; Tue, 
	23 Mar 2010 05:03:45 -0700 (PDT)
In-Reply-To: <46dff0321003221854t2d95d18dx1a6cdf1174ea2efd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143009>

On 23 March 2010 01:54, Ping Yin <pkufranky@gmail.com> wrote:
> With putty and pageant, the key with passphrase can be used.
> Is there any way to use key with passphrase when using the msysgit ssh?

Use ssh-agent.

After you start the msys shell enter:

eval $(ssh-agent)

Then you can use 'ssh-add' to add a key to the agent. If it requires a
password then it will prompt you at that point. Now any further ssh
activity in the current session can acquire the pre-authenticated key
from the agent.
