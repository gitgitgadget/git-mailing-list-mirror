From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: How to exclude files from "git diff"
Date: Fri, 18 Dec 2009 09:09:15 -0800
Message-ID: <6dc9ffc80912180909q2e9cbe30r7c802a2152c5954@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 18:09:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLgKS-0007CW-Ip
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 18:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbZLRRJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 12:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbZLRRJT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 12:09:19 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42166 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272AbZLRRJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 12:09:18 -0500
Received: by ewy19 with SMTP id 19so1702097ewy.21
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 09:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=tuVllWljWr0FxVEwwjA7x4SQ3X7vQqmngLLK2YTYnjU=;
        b=sVUXkFr9LZ5TEPgYzI8B12tDHwFUxwWViuglGk26qVexOjnzsVTWU0CjNwF1rpzxAA
         QbVQuRZ/+u4aH2YfRFZuezSELuQ0S18R+pcyhopeyVnaJwv7OfPuQHohH1XIYDmtqeD6
         ObrXEE33OcHHFJouGBPhEq+Q4GwLGQtoWy2c0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=BbBiC70uKsAmgJcJfqF8iGFqYSJvhrNvjMZHtd3Zf5dlaknwfDrj4mtutv6NuUDAx0
         BPS+dD5M4J79g13Sl76iWZg6NdFe5KufScQynVvZa4Cj7nx5RzOlC6Otl79wvg+wuitu
         ibBN5CdROT1vDSouRsqUEQ+KHOPsbU4UpjlAY=
Received: by 10.216.90.196 with SMTP id e46mr1555193wef.194.1261156156426; 
	Fri, 18 Dec 2009 09:09:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135420>

Hi,

I have some bookkeeping files in my git repository.  How do I
exclude them from "git diff"? Does "git diff" support

# git diff --exclude="foo.*.bar*"

Please CC me since I am not on the git mailing list.

Thanks.


-- 
H.J.
