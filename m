From: Andy Parkins <andyparkins@gmail.com>
Subject: Funny reflog has missing space
Date: Tue, 27 Feb 2007 15:29:11 +0000
Message-ID: <200702271529.13258.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 16:29:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4Ga-00081g-1A
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbXB0P3V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933050AbXB0P3V
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:29:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:28662 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932715AbXB0P3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:29:20 -0500
Received: by nf-out-0910.google.com with SMTP id o25so215622nfa
        for <git@vger.kernel.org>; Tue, 27 Feb 2007 07:29:19 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=byltG+Dv8x/Ifzis3+zy1o/hu1w8eqjny5s7RRdwiGMmx8jfhkMFsZA5aqJkVPvLXKrwOvSc16NahKa2/Vaj9Qy8lXUBW5XpVStExLmZUsHzkT6LsdxtIDne7U24a5gd8iyzxtoP46g+9PQKd2dTKLfpuu3doO1cE9Khnmxpquk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=U0toY/tjeUYRbhal4XlWy7KJZ/kuotioPxhjUNA8clFhS2Ia6PjjuTInhuRURSZiEFFeHBHe7gg/yJRIxyaFirAR3noKSPbUdi/wjogtGx1IbVwFMJNhWWdNqbQ8qa0TgQo9Xr5y29cH6xAQuVaiPvW7zE0jIfraIHPxT9gUg7I=
Received: by 10.49.12.4 with SMTP id p4mr1330639nfi.1172590159337;
        Tue, 27 Feb 2007 07:29:19 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id h1sm2231041nfe.2007.02.27.07.29.16;
        Tue, 27 Feb 2007 07:29:16 -0800 (PST)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40746>

Hello,

I've just peeked in my reflog (tail .git/logs/HEAD), and found something 
strange:

72160ca5c05fab4fbd3c24c9b13cbd0651b60532 
ca7b20e2677960cfc52c525b8f8bdf12ce79176b Andy Parkins <long@emailaddress.com> 
1172589175 +0000commit: Log message goes here

Notice that there is no space between the "+0000" and the "commit".  This is 
true for every item in this log and every log in this repository.

Over in another part of the forest, I've got my git repository.  This is fine, 
and has the space where I would expect.  The only difference I can see is 
that in one I'm using my long work email address, and in the git one I'm 
using my shorter gmail address.

Is this normal?  "git-reflog show" works fine in both cases.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
