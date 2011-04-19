From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Renaming a repo
Date: Tue, 19 Apr 2011 11:32:04 -0700
Message-ID: <BANLkTimeufOo1eLESqooaf+zN+16+mUJCA@mail.gmail.com>
References: <BANLkTiknSbWrskhGLWUBEq1=9KV4hC3ttA@mail.gmail.com>
	<4DADD0C4.4010106@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCFie-0002Im-CL
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 20:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701Ab1DSScG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 14:32:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60724 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab1DSScF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 14:32:05 -0400
Received: by yxs7 with SMTP id 7so2067883yxs.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 11:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=o6S317HfmBeLdrhqQDCNawaRheci7kWRwFlFWEB03Vg=;
        b=lj2RpcQGnoqhDpDfs+n0Z9vpzgN6vOL0MQ1hqdrGRdwf3GRdJ4jSz++mQ4zI6scLsP
         VJ6JRo3s6cK3EL/XEgGng8rhuxWP4B9/JMZXL95mI8aMWvalXjtqqcfFT2HmJH1RoFGI
         Ij8ne4n0hn1WtIQul7nZsvSE/yKaMZnYKWWnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VtplEBUwzEOdSv4Wpfj7l1A5mMNDnbfIFThRw+LFkko0zfkn5FTXhxmD/7j7bbedh/
         cU6OntV9Cr+IK43aUG6wCHuyCWXcz4AvYZPCT6ysgo/DHFDbzlL5/LgPjrxzRGUXTfwk
         O8CqpOaZBJCVe0ht9XawzbCpEEnDoFBiAVqus=
Received: by 10.236.153.195 with SMTP id f43mr5251900yhk.62.1303237924155;
 Tue, 19 Apr 2011 11:32:04 -0700 (PDT)
Received: by 10.236.111.17 with HTTP; Tue, 19 Apr 2011 11:32:04 -0700 (PDT)
In-Reply-To: <4DADD0C4.4010106@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171809>

On 19 April 2011 11:13, Tomas Carnecky <tom@dbservice.com> wrote:
> On 4/19/11 8:02 PM, Hilco Wijbenga wrote:
>> 1. The current repo is 'abc.git'
>> 2. git clone abc.git
>
> git clone --mirror abc.git
>>
>> 3. Create new hosted repo 'xyz.git'
>
> cd abc; git push --mirror xyz.git
>
> then you are done.

Wow ... stunned silence ...  :-) *That* was easy. I didn't realize I
could work with bare repos like that.

The more I use Git, the more I like it and the more impressed I am.
