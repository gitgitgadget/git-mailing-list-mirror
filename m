From: Shakthi Kannan <shakthimaan@gmail.com>
Subject: Re: setup gitosis on Fedora 11
Date: Mon, 20 Jul 2009 11:13:35 +0530
Message-ID: <d16b1c80907192243v6a2033cdr84eba41683c29403@mail.gmail.com>
References: <1247867114.2384.15.camel@brizlyMobil>
	 <2e24e5b90907171844o11eb6699m929e3c0df621ef67@mail.gmail.com>
	 <1247902835.2384.86.camel@brizlyMobil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 07:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSlkD-0004h4-TH
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 07:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbZGTFsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 01:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbZGTFsy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 01:48:54 -0400
Received: from mail-pz0-f184.google.com ([209.85.222.184]:43727 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbZGTFsy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 01:48:54 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2009 01:48:53 EDT
Received: by pzk14 with SMTP id 14so244868pzk.33
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 22:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=a+I71E1uY+aRY8kAM1n7pgM3KfwjViShimkp8PU4ctY=;
        b=E9jt4ODekqaHRp9QkW3vXQpogKP5s6W5FpnFQwoF9tS+jp9mrtxIhDdfzFbX+CjiIc
         sFLW48VnnG+4Sc5CGuVmL3BfRovS5eAL1Li2qTDylAb7NpSJX7ICJdjPF8DckZ3d2AWT
         0KyNLYUfh5dhZXF6TK3Gqz5WLzyNh4agm6ev0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=uaCCwVnGlwDIigkUcFkrM2nknVWS7RmwL2RhAVsLv5q4EXyaw5O22pxay/Xs3dweeX
         6fkwVhJtQKoxNtqDSBPefND0ovQ64V5nIqa9LaZdN7IZun33uAnRuu6Q7AZlx6yC511j
         sFma2IXmXB4DRyN43fBXBf6arOcr4UdHsIAY8=
Received: by 10.115.72.17 with SMTP id z17mr6841197wak.183.1248068615662; Sun, 
	19 Jul 2009 22:43:35 -0700 (PDT)
In-Reply-To: <1247902835.2384.86.camel@brizlyMobil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123569>

Hi,

--- On Sat, Jul 18, 2009 at 1:10 PM, brizly vaan van
Ulciputz<brizly@freenet.de> wrote:
| brizly2 is my notebook
| s28 is the server with gitosis
|
| The user brizly exists on notebook as on s2
\--

As per the gitosis documentation that I have tested, the local user
does not have a HOME account on the gitosis remote server. I am not
sure if specifying the SSH file as 'username@hostname' will make a
difference in this context, when you add the local user SSH key to
gitosis-admin/keydir.

---
| Because my first run wasn't very successfull, i tried another tutorial
| where the developer-machine and the gitosis-server are 2 different ones.
| see http://www.shakthimaan.com/installs/gitosis.html
\--

Please ping me 'mbuf' on #git if you have any queries regarding the
documentation.

SK

-- 
Shakthi Kannan
http://www.shakthimaan.com
