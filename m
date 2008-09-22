From: Tim Harper <timcharper@gmail.com>
Subject: Re: ignoring files/directories in git
Date: Mon, 22 Sep 2008 12:47:37 -0600
Message-ID: <74FEF67B-4F2F-46D6-9679-97C2C19829F5@gmail.com>
References: <19596152.post@talk.nabble.com> <19596620.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 20:49:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhqSs-0005LU-UA
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 20:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYIVSrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 14:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753000AbYIVSrp
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 14:47:45 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:8141 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbYIVSro (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 14:47:44 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1335576waf.23
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=ToNHmed/MhSQFSI8K7j6gB31Iplii02fLlhWRbLUaFw=;
        b=OwrYN41tYC+V1Sbwvu4HFslVUfw3MDm/Iy0vvRWBsNDaXAJYME3B9M79g27OueFcBi
         1+AKi3MZWn/wnV5NVV+w53bnK+E5fNJfduzIcoQyU46DICovKl0DrOyNXlO6aiHTl5cJ
         7LrZiwnpFyjARd4KtFlHqp8Avt8rZPOeJA0/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=WbQ8Bzc/wUOhHm/eeJwU87k22yTHFYeV5nMM609fSoFvFq2F38OVCCMVjYzYO4n7YH
         1o9JJoPi4bfw2/+kOL/aYc6JK2fJl/zsOfXscpcYBo9gdrRV+SSb0z9WqF+JUMtPByPj
         wkEVOCWhD82eZKBDbBffrFeIAxDtvpfToyads=
Received: by 10.114.80.4 with SMTP id d4mr5060099wab.166.1222109263842;
        Mon, 22 Sep 2008 11:47:43 -0700 (PDT)
Received: from ?10.1.1.135? ( [66.182.89.5])
        by mx.google.com with ESMTPS id z20sm10064230pod.11.2008.09.22.11.47.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 11:47:42 -0700 (PDT)
In-Reply-To: <19596620.post@talk.nabble.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96506>

On Sep 21, 2008, at 11:42 AM, mwolfe38 wrote:

>
> Fixed, by removing the trailing / in the names it will then ignore  
> all files
> in that directory,
> so now i just have
> cache
> log
> instead of
> cache/ and log/

FYI, you might try this instead:
/cache
/log

It's more specific, and if you had a file like "/lib/adapters/log/ 
rotater.rb", it wouldn't be ignored, whereas it would without the  
leading slashes.

Tim
