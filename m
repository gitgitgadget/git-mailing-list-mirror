From: Dario Bertini <berdario@gmail.com>
Subject: commit --strict feature request
Date: Tue, 23 Mar 2010 18:47:16 +0100
Message-ID: <4BA8FEA4.60504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 18:47:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu8CN-0006YH-AC
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 18:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab0CWRrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 13:47:22 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:42051 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab0CWRrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 13:47:21 -0400
Received: by fxm23 with SMTP id 23so2391014fxm.1
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=5C/M0kKNF8hwSxoEWr4IyGXq5cIPnJ5Xnn3EsLvzFbk=;
        b=M9cN+k/p1YHeKQ0BceU2tL0l2qfnLMNuaDYCnZbw59sBH7Gh6ATeiPEBdjd1tQcUof
         YUPbwvfdGuZ6ODXBT1hl2qN1ewnuY4tl7xaiMAQ3sRWUmwuztgTgbS95oxIVnebEo8t2
         i/FKLCYnPfT/snEQWfUm46m0cmZmrsYlBnBtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=mDpAnkQZXf2D3UyIGRuVztGeI3O+VWJ/bS4jIUJLYAXo2OmapQArN/NZ59MpGWbIYP
         vhvhkge6sDM9gBrUO1amttrWrn+ei4Sq3TfvDbrsyyJcEg4uoSbEFGQVRju8QXyvSi7f
         qtFm30exLsQwHXoCEeGky2U/2ZAUcQJTDDB8I=
Received: by 10.223.15.89 with SMTP id j25mr8743709faa.97.1269366439844;
        Tue, 23 Mar 2010 10:47:19 -0700 (PDT)
Received: from [192.168.1.102] (host225-78-dynamic.5-87-r.retail.telecomitalia.it [87.5.78.225])
        by mx.google.com with ESMTPS id 13sm6161015fks.30.2010.03.23.10.47.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 10:47:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); it; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143036>

Hi, i usually use bzr, and today i was searching for a commit --strict 
equivalent in git... i asked around and it seems there isn't one, so i'm 
writing this.

basically, by doing commit --strict it refuses to commit if there are 
untracked (and thus not ignored) files in the tree, this helps against 
forgetting to add new files (actually i find it so useful that i've even 
changed commit to be an alias to commit --strict in my bzr aliases )


greetings
